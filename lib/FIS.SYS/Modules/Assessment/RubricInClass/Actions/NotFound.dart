import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/BottomSheet.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Button.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/Text.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/TextField.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Icons.dart';

class NotFound extends StatelessWidget {
  const NotFound({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.only(top: 16),
        child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                backgroundColor: FColors.transparent,
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.only(top: 24.0),
                    child: SingleChildScrollView(
                      child: StatefulBuilder(
                          builder: (BuildContext context, StateSetter mystate) {
                        return FBottomSheet(
                          mainAxisSize: MainAxisSize.max,
                          header: FModal(
                            title: FText('Thêm Rubric',
                                style: FTextStyle.titleModules3),
                            textAction: FButton(
                              size: FButtonSize.size40,
                              title: 'xong',
                              color: FColors.blue6,
                              backgroundColor: FColors.grey1,
                              onPressed: () {},
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          body: Container(
                            height: MediaQuery.of(context).size.height,
                            padding: EdgeInsets.all(16),
                            color: FColors.grey1,
                            child: FTextField(
                              label: 'Tìm theo tên/mã Rubric',
                              size: FTextFieldSize.size40,
                              leftIcon: FOutlinedIcons.search,
                              onChanged: () {},
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                },
              );
            },
            child: SvgPicture.asset('lib/FIS.SYS/Assets/images/danhgia.svg')),
      ),
    );
  }
}
