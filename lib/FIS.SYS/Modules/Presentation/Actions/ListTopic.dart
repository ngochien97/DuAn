import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:khao_thi_gv/FIS.SYS/Modules/Presentation/PresentationItem.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../F.Utils/SrceenExtensions.dart';
import '../../../../F.Utils/Utils.dart';
import '../../../../Khao_thi_GV/RouteNames.dart';
import '../../../Components/ComponentsBase.dart';
import '../../../Core/Config.dart';
import '../../../Core/routes.dart';
import '../../../Skins/Typography.dart';
import '../../../Styles/StyleBase.dart';
import '../../Students/StudentDetailDA.dart';
import '../../Students/StudentItem.dart';
import '../../TakerGroups/ClassInfomation.dart';
import '../../User/UserItem.dart';
import '../DA/PresentDA.dart';
import '../Providers/PresentationProvider.dart';
import 'ListPresentation.dart';
import 'ListStudent.dart';

class ListTopicScreen extends StatefulWidget {
  final ClassInfomation classInfo;
  const ListTopicScreen(this.classInfo);
  @override
  _ListTopicScreenState createState() => _ListTopicScreenState();
}

class _ListTopicScreenState extends State<ListTopicScreen> {
  StudentDetailDA studentDetailDA = StudentDetailDA();
  List<StudentItem> students;
  MqttServerClient client;
  String topic;
  static const storage = FlutterSecureStorage();
  PresentDA presentDA = PresentDA();
  bool isLoadding = true;
  bool isLoadmore = false;
  bool isSaving = false;
  bool _enableContinueLoadMore = true;
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    getTopic().then((value) => connect());
    loadData();
    //get list students
    studentDetailDA
        .getStudentInClassFromCache(widget.classInfo.id)
        .then((data) {
      if (data.code == 200) {
        Provider.of<PresentationProvider>(context, listen: false).students =
            data.students;
        students = data.students;
      }
    }).catchError(Utils.error);
    _controller.addListener(scrollToLoadMore);
  }

  Future scrollToLoadMore() async {
    if (_controller.position.extentAfter > 100) {
      _enableContinueLoadMore = true;
    }

    if (_controller.position.extentAfter == 0) {
      if (_enableContinueLoadMore) {
        _enableContinueLoadMore = false;
        await Provider.of<PresentationProvider>(context, listen: false)
            .loadMoreData();
      }
    }

    // if (isLoadmore) {
    //   return;
    // }
    // if (_controller.position.extentAfter < 100) {
    //   setState(() {
    //     isLoadmore = true;
    //   });

    //   await Provider.of<PresentationProvider>(context, listen: false)
    //       .loadMoreData();
    //   setState(() {
    //     isLoadmore = false;
    //   });
    // }
  }

  Future finishPresent(
      PresentationItem present, PresentationProvider provider) async {
    if (present.isSaving) {
      return;
    }
    try {
      present.isSaving = true;
      provider.rebuild();

      final data = await presentDA.submitAnswer(present.id);
      if (data.code != 200) {
        present.isSaving = false;
        provider.rebuild();
        return;
      }

      final builder = MqttClientPayloadBuilder();

      builder.addString(
          '{"command": "finish_presentation","presentation_id":${present.id},"device_id":"${await Utils.getDeviceId()}"}');

      client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload);
      await provider.removePresent(data.present);
    } catch (e) {
      present.isSaving = false;
      provider.rebuild();
    }
  }

  Future loadData() async {
    final provider = Provider.of<PresentationProvider>(context, listen: false);
    await provider.loadData();
    setState(() {
      isLoadding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FColors.grey2,
      appBar: FAppBar(
        headerLead: FIconButton(
          icon: FOutlinedIcons.left,
          backgroundColor: FColors.transparent,
          size: FIconButtonSize.size48,
          color: FColors.grey9,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        headerCenter: Container(
          alignment: Alignment.center,
          child: FText(widget.classInfo.name ?? '',
              style: FTextStyle.titleModules3),
        ),
        headerActions: [
          FIconButton(
            icon: FOutlinedIcons.clock_circle,
            backgroundColor: FColors.transparent,
            color: FColors.grey9,
            size: FIconButtonSize.size48,
            onPressed: () {
              CoreRoutes.instance.navigateTo(RouteNames.PRESENTATION_HISTORY,
                  arguments: widget.classInfo.id);
            },
          ),
          FIconButton(
            icon: FOutlinedIcons.hat,
            backgroundColor: FColors.transparent,
            color: FColors.grey9,
            size: FIconButtonSize.size48,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListStudentScreen(students ?? [])));
            },
          ),
        ],
      ),
      body: isLoadding
          ? TopicLoading()
          : RefreshIndicator(
              onRefresh: () async {
                await loadData();
              },
              child: Consumer<PresentationProvider>(
                builder: (context, provider, child) => Stack(
                  alignment: Alignment.center,
                  children: [
                    provider.presents.isEmpty
                        ? Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [FEffect.elevation1],
                                color: FColors.grey1,
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const FText(
                                'Chưa có dữ liệu',
                                style: FTextStyle.titleModules4,
                              ),
                            ),
                          )
                        : ListView.builder(
                            controller: _controller,
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: provider.presents.length,
                            itemBuilder: (context, index) {
                              final present = provider.presents[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(16.h),
                                    width: 382.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FText(
                                          present.name,
                                          style: FTextStyle.titleModules3,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            FText(
                                              '${present.statusName}',
                                              style: FTextStyle.subtitle2,
                                              color: FColors.blue6,
                                            ),
                                            if (present.status == 2)
                                              !present.isSaving
                                                  ? GestureDetector(
                                                      onTap: () async {
                                                        await finishPresent(
                                                            present, provider);
                                                      },
                                                      child: FText(
                                                        'Kết thúc',
                                                        style: FTextStyle
                                                            .subtitle2,
                                                        color: FColors.blue6,
                                                      ),
                                                    )
                                                  : Container(
                                                      width: 16,
                                                      height: 16,
                                                      child:
                                                          CircularProgressIndicator())
                                          ],
                                        ),
                                        FSpacer.space8px,
                                        if (present.totalItems > 0)
                                          LinearProgressIndicator(
                                            value: present
                                                    .questionScanedIds.length /
                                                present.totalItems,
                                            backgroundColor: FColors.grey4,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    FColors.blue6),
                                          )
                                      ],
                                    ),
                                  ),
                                  present.items == null
                                      ? Container()
                                      : ListPresentation<PresentationProvider>(
                                          present,
                                          topic: topic,
                                          client: client),
                                  FDivider(
                                    space: 24,
                                  ),
                                ],
                              );
                            }),
                    if (isLoadmore)
                      Positioned(
                        bottom: 4.0,
                        width: 30,
                        height: 30.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 3.0,
                        ),
                      )
                  ],
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    client.disconnect();

    super.dispose();
  }

  Future getTopic() async {
    final subcriptionActive = await storage.read(key: 'subscriptionActive');
    final userJson = await storage.read(key: 'userInfo');
    final userStore = UserItem.fromJson(json.decode(userJson));
    topic = '$subcriptionActive/${userStore.id}';
  }

  void onSubscribed(String topic) {
    Utils.console('EXAMPLE::Subscription confirmed for topic $topic');
  }

  Future connect() async {
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
    client.onSubscribed = onSubscribed;
    client.autoReconnect = true;
    client.logging(on: false);

    try {
      await client.connect();
    } on Exception catch (e) {
      Utils.console('EXAMPLE::client exception - $e');
      client.disconnect();
    }

    client.subscribe(topic, MqttQos.atLeastOnce);
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage message = c[0].payload;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);

      Utils.console('Received message:$payload from topic: ${c[0].topic}>');
    });

    /// Check we are connected
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      Utils.console('EXAMPLE::Mosquitto client connected');
    } else {
      // ignore: lines_longer_than_80_chars
      Utils.console('EXAMPLE::ERROR'
          'Mosquitto client connection failed - disconnecting,'
          'state is ${client.connectionStatus.state}');
      client.disconnect();
    }
  }
}

class TopicLoading extends StatelessWidget {
  const TopicLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (_, __) => Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 4),
                        height: 20,
                        width: 160,
                        color: Colors.white,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 4),
                        height: 12,
                        width: 120,
                        color: Colors.white,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        height: 8,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      Container(
                        height: 184,
                        margin: EdgeInsets.only(bottom: 12),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 2,
                          itemBuilder: (_, __) => Container(
                            height: 180,
                            width: 342.w,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      FDivider(
                        space: 24,
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
