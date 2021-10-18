import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/SnackBar.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/KhaoThi/SkinColor.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';

import '../../../../F.Utils/SrceenExtensions.dart';
import '../../../../F.Utils/Utils.dart';
import '../../../Components/BoundingBox.dart';
import '../../../Components/Card.dart';
import '../../../Components/Text.dart';
import '../../../Skins/Icon.dart';
import '../../../Styles/Colors.dart';
import '../../../Styles/Icons.dart';
import '../DA/PresentDA.dart';
import '../PresentationItem.dart';
import '../Providers/PresentProvider.dart';
import '../Providers/PresentationProvider.dart';
import 'StartPresentation.dart';

class ListPresentation<T extends PresentationProvider> extends StatefulWidget {
  final PresentationItem present;
  final MqttServerClient client;
  // final List<StudentItem> students;
  final String topic;
  final bool isEnd;

  const ListPresentation(this.present,
      {this.topic, this.client, this.isEnd = false});

  @override
  ListPresentationState createState() => ListPresentationState();
}

class ListPresentationState<T extends PresentationProvider>
    extends State<ListPresentation<T>> {
  final ScrollController _controller = ScrollController();
  bool isLoadding = false;
  bool isSaving = false;
  bool isShowModal = false;
  PresentDA presentDA = PresentDA();

  Future<void> scrollToLoadMore() async {
    if (isLoadding) {
      return;
    }

    if (_controller.position.extentAfter < 342.w - 100) {
      isLoadding = true;
      await loadFullQuestion();

      isLoadding = false;
    }
  }

  Future loadFullQuestion() async {
    if (widget.present.items.length < widget.present.totalItems) {
      final data = await presentDA.getQuestions(widget.present.testFormId);
      widget.present.items = data.items;
      Provider.of<T>(context, listen: false).rebuild();
    }
  }

  @override
  void initState() {
    _controller.addListener(scrollToLoadMore);
    Utils.console('init state');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 184,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.present.items.length,
        controller: _controller,
        itemBuilder: (context, i) => Row(
          children: [
            GestureDetector(
              onTap: () async {
                await startPresentation(
                  context,
                  widget.present,
                  i,
                );
              },
              child: Container(
                width: 342.w,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: FCard(
                  size: FBoxSize.auto_rectangle,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 112,
                        margin: EdgeInsets.only(bottom: 8),
                        child: Html(
                          data: widget.present.items[i].dataBodyHtml,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.present.questionScanedIds
                                  .contains(widget.present.items[i].id)
                              ? FBoundingBox(
                                  backgroundColor: FColors.green6,
                                  type: FBoundingBoxType.circle,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    child: FIcon(
                                      icon: FOutlinedIcons.check,
                                      color: [FColors.grey1],
                                    ),
                                  ),
                                )
                              : Container(),
                          Container(
                            decoration: BoxDecoration(
                                color: FColors.blue6,
                                borderRadius: BorderRadius.circular(4)),
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: FText(
                              '${i + 1} / ${widget.present.totalItems}',
                              color: FColors.grey1,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  // actionChildren: [

                  // ],
                ),
              ),
            ),
            if (i == widget.present.items.length - 1 &&
                widget.present.items.length < widget.present.totalItems)
              Container(
                width: 342.w,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  child: FCard(
                      size: FBoxSize.auto_rectangle,
                      content: Center(
                        child: Text('Loading...'),
                      )),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void showMessage(String message, Color color) {
    showFSnackBar(
        context,
        FSnackBar(
          message: FText(
            '$message',
            color: FColors.grey1,
          ),
          borderRadius: 8.0,
          position: FlushbarPosition.TOP,
          backgroundColor: color,
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ));
  }

  Future<void> startPresentation(
      BuildContext context, PresentationItem present, int index) async {
    if (isShowModal) {
      return;
    }
    isShowModal = true;
    try {
      if (widget.client.connectionStatus.state !=
          MqttConnectionState.connected) {
        return;
      }
      final students = Provider.of<T>(context, listen: false).students;
      if (students == null || students.isEmpty) {
        showMessage('Lớp chưa có học sinh', SkinColor.warning);
        return;
      }

      await loadFullQuestion();
      final provider = Provider.of<PresentProvider>(context, listen: false);
      provider.init(present, index, widget.topic);
      //start trinh chieu
      final builder = MqttClientPayloadBuilder();

      builder.addString(
          '{"command": "start_presentation", "presentation_id": ${present.id}, "slide_num":$index,"device_id":"${await Utils.getDeviceId()}"}');
      widget.client
          .publishMessage(widget.topic, MqttQos.atLeastOnce, builder.payload);

      await presentDA.startPresent(present.id);

      await showModalBottomSheet(
        context: context,
        backgroundColor: FColors.transparent,
        elevation: 0,
        enableDrag: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => StartPresentationScreen(
            students,
            widget.client,
          ),
        ),
      );
    } catch (e) {
      isShowModal = false;
    }
    isShowModal = false;
  }
}
