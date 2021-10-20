import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildingScreen extends StatelessWidget {
  const BuildingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FState(
        picture: SvgPicture.asset('lib/FIS.SYS/Assets/images/Building.svg'),
        noticeText: 'Tính năng này đang trong quá trình xây dựng',
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
