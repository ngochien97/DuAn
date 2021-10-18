import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';

import '../../../../F.Utils/Utils.dart';
import '../../../Components/ComponentsBase.dart';
import '../../../Styles/StyleBase.dart';
import '../../Students/StudentItem.dart';
import '../Providers/PresentProvider.dart';
import '../Providers/ScanProvider.dart';
import 'Scan.dart';

class StartPresentationScreen extends StatefulWidget {
  final List<StudentItem> students;

  final MqttServerClient client;

  const StartPresentationScreen(this.students, this.client);
  @override
  _StartPresentationScreenState createState() =>
      _StartPresentationScreenState();
}

class _StartPresentationScreenState extends State<StartPresentationScreen> {
  // Future<void> _initialVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PresentProvider>(context, listen: true);
    final question = provider.currentQuestion;
    final present = provider.present;

    return Container(
      color: FColors.transparent,
      margin: EdgeInsets.only(top: 32.0),
      child: FBottomSheet(
        header: FModal(
          title: Container(),
          textAction: Container(
            width: 48.0,
            child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: '${provider.currentIdex + 1}',
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                        color: FColors.grey9)),
                TextSpan(
                    text: ' / ${present.items.length}',
                    style: TextStyle(fontSize: 17.0, color: FColors.grey4))
              ]),
            ),
          ),
        ),
        body: Expanded(
            child: Scaffold(
          backgroundColor: FColors.grey1,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Html(
                      style: {
                        'html': Style(
                            fontFamily: 'Roboto',
                            textAlign: TextAlign.left,
                            margin: EdgeInsets.all(0)),
                        'img': Style(),
                      },
                      data: question.dataBodyHtml,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    alignment: Alignment.topLeft,
                    child: Column(children: [
                      for (final element in question.choices)
                        FListTitle(
                          backgroundColor: FColors.transparent,
                          avatar: FBoundingBox(
                            size: FBoxSize.size32x32,
                            backgroundColor: question.dataResponse == element.id
                                ? FColors.green6
                                : FColors.grey5,
                            type: FBoundingBoxType.circle,
                            child: FText(
                              '${Utils.connvertNumberToCharAnswer(element.id)}',
                              color: FColors.grey1,
                            ),
                          ),
                          title: Html(
                            data: '${element.choiceName}',
                          ),
                        )
                    ]),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: FTabBar(
              elevation: 6,
              floatingButtonAction: FFloatingButtonAction(
                  icon: FFilledIcons.video_camera,
                  onPressed: () async {
                    await Provider.of<ScanProvider>(context, listen: false)
                        .init(present, question, widget.students);

                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScanAnserApp(
                                widget.students, question, present.id,
                                client: widget.client)));
                  }),
              floatingButtonActionPosition:
                  FFloatingButtonActionPosition.center,
              children: [
                FTabBarItem(
                  icon: FFilledIcons.step_backward,
                  color: provider.currentIdex == 0
                      ? FColors.transparent
                      : FColors.grey6,
                  onTap: (index) async {
                    if (provider.currentIdex != 0) {
                      await changeSlide(provider.currentIdex - 1, provider);
                    }
                  },
                ),
                FTabBarItem(
                  icon: FFilledIcons.step_forward,
                  color: provider.currentIdex < present.items.length - 1
                      ? FColors.grey6
                      : FColors.transparent,
                  onTap: (index) async {
                    if (provider.currentIdex < present.items.length - 1) {
                      await changeSlide(provider.currentIdex + 1, provider);
                    }
                  },
                ),
              ]),
        )),
      ),
    );
  }

  Future<void> changeSlide(int index, PresentProvider provider) async {
    final builder = MqttClientPayloadBuilder();

    builder.addString(
        '{"command": "change_slide","presentation_id":${provider.present.id}, "slide_num":$index,"device_id":"${await Utils.getDeviceId()}"}');
    provider.changeQuestion(index);
    widget.client
        .publishMessage(provider.topic, MqttQos.atLeastOnce, builder.payload);
  }
}
