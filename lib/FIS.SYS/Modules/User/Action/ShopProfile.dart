import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';

class ShopProfile extends StatefulWidget {
  ShopProfile({Key key}) : super(key: key);

  @override
  _ShopProfileState createState() => _ShopProfileState();
}

class _ShopProfileState extends State<ShopProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            FBoundingBox(
              size: FBoxSize.auto_rectangle_special,
              child: Image.asset(
                'lib/G-Store/Assets/coverImage.png',
                fit: BoxFit.cover,
              ),
              topItems: Container(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).size.width / 8),
                child: FIconButton(
                  icon: FFilledIcons.camera,
                  onPressed: () {},
                  backgroundColor: FColors.grey10.withOpacity(0.4),
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.width / 2.5),
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: FColors.grey1),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: FBoundingBox(
                  size: FBoxSize.size80x80,
                  type: FBoundingBoxType.circle,
                  child: Image.asset('lib/G-Store/Assets/avatar.png'),
                  topItems: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 8),
                    child: FIconButton(
                      icon: FFilledIcons.camera,
                      onPressed: () {},
                      backgroundColor: FColors.grey10.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
