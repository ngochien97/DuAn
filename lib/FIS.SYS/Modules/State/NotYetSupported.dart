import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotYetSupport extends StatelessWidget {
  const NotYetSupport({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FState(
        picture: SvgPicture.asset('lib/FIS.SYS/Assets/images/NotFound.svg'),
        noticeText: 'Tính năng này hiện chưa được hỗ trợ trên điện thoại',
        subtitleText: 'Vui lòng quay lại sau nhé',
        buttonTitle: 'Quay lại',
        onPressButtonEvent: () {
          Navigator.pop(context);
        },
        iconButton: false,
        backgroundColor: FColors.grey1,
      ),
    );
  }
}
