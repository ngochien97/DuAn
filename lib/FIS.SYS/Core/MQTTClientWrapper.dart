import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:khao_thi_gv/F.Utils/Utils.dart';
import 'package:khao_thi_gv/FIS.SYS/Core/CacheService.dart';
import 'package:khao_thi_gv/FIS.SYS/Core/routes.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Notifications/Models/HistoryNotificationItem.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/TakerGroup.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/takergroup/NotificationBloc.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/TakerGroups/bloc/student_detail/takergroup/NotificationEvent.dart';
import 'package:khao_thi_gv/Khao_thi_GV/RouteNames.dart';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../locator.dart';
import 'Config.dart';

class MQTTClientWrapper {
  MqttServerClient client;

  VoidCallback onConnectedCallback;
  Function() onLocationReceivedCallback;
  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

  Future prepareMqttClient() async {
    await _setupMqttClient();
    await _connectClient();
    messageArrived();
  }

  Future<void> _connectClient() async {
    try {
      // ignore: avoid_print
      print('MQTTClientWrapper::Mosquitto client connecting....');
      connectionState = MqttCurrentConnectionState.CONNECTING;
      await client.connect();
    } on Exception catch (e) {
      // ignore: avoid_print
      print('MQTTClientWrapper::client exception - $e');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }

    if (client.connectionStatus.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.CONNECTED;
      // ignore: avoid_print
      print('MQTTClientWrapper::Mosquitto client connected');
    } else {
      // ignore: avoid_print
      print(
          'MQTTClientWrapper::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }
  }

  Future<void> _setupMqttClient() async {
    final deviceId = await Utils.getDeviceId();
    client = MqttServerClient.withPort(ConfigAPI.urlSocket, '', 443);
    final connMess = MqttConnectMessage()
        .withClientIdentifier(deviceId)
        .keepAliveFor(20) // Must agree with the keep alive set above or not set
        .startClean() // Non persistent session for testing
        .withProtocolVersion(MqttClientConstants.mqttV311ProtocolVersion)
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMess;
    client.useWebSocket = true;
    client.onSubscribed = _onSubscribed;
    client.autoReconnect = true;
    client.logging(on: false);
    client.setProtocolV311();
  }

  void subscribeToTopic(String topicName) {
    // ignore: avoid_print
    print('MQTTClientWrapper::Subscribing to the $topicName topic');
    client.subscribe(topicName, MqttQos.atMostOnce);
  }

  void messageArrived() {
    // blocScrollParent.add(ShowSnackbarEvent(content: 'hello'));
    Utils.console("notification");
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) async {
      final MqttPublishMessage recMess = c[0].payload;

      List<int> bytes = [];
      recMess.payload.message.forEach((e) {
        bytes.add(e);
      });

      final newLocationJson = utf8.decode(bytes);

      if (c[0].topic.endsWith('TEST-TAKER-GROUP')) {
        final jsonData = json.decode(newLocationJson);
        final takerGroup = TakerGroup.fromJson(jsonData['test_taker_group']);

        // TODO(phuocnh): neu dang o man hinh kip thi thi update screen
        if (CoreRoutes.instance.curentRoutes == RouteNames.TEST_TAKER ||
            CoreRoutes.instance.curentRoutes == RouteNames.TEST_TAKER_CLOSE ||
            CoreRoutes.instance.curentRoutes == RouteNames.TEST_TAKER_DELETE) {
          if (jsonData['command'] == 'update_test_taker_group') {
            locator<NotificationBloc>().add(TakerGroupUpdateEvent(takerGroup,
                message: 'Kíp thi ${takerGroup.id} được cập nhật',
                type: 'update_test_taker_group'));
          }
        } else {
          if (jsonData['command'] == 'update_test_taker_group') {
            // save history
            var jsonData = json.encode(takerGroup);
            final data = HistoryNotificationItem(
                '${takerGroup.name}',
                'update_test_taker_group',
                'Kíp thi ${takerGroup.id} được cập nhật',
                objectData: jsonData);
            await CacheService.add<HistoryNotificationItem>(data.id, data);
            locator<NotificationBloc>().add(GetHistoryNotificationsEvent());
          }
        }

        // neu khong phai man hinh kip thi => luu cache
      }

      // locator<SnackBarBloc>().add(ShowSnackbarEvent(content: newLocationJson));

      // ignore: avoid_print
      print('MQTTClientWrapper::GOT A NEW MESSAGE $newLocationJson');
    });
  }

  void _publishMessage(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
  }

  void _onSubscribed(String topic) {
    // ignore: avoid_print
    print('MQTTClientWrapper::Subscription confirmed for topic $topic');
    subscriptionState = MqttSubscriptionState.SUBSCRIBED;
  }

  void _onDisconnected() {
    connectionState = MqttCurrentConnectionState.DISCONNECTED;
  }

  void _onConnected() {
    connectionState = MqttCurrentConnectionState.CONNECTED;
    // ignore: avoid_print
    print(
        'MQTTClientWrapper::OnConnected client callback - Client connection was sucessful');
    onConnectedCallback();
  }
}

enum MqttCurrentConnectionState {
  IDLE,
  CONNECTING,
  CONNECTED,
  DISCONNECTED,
  ERROR_WHEN_CONNECTING
}

enum MqttSubscriptionState { IDLE, SUBSCRIBED }
