import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';

class ShopHomeHeader extends StatefulWidget with PreferredSizeWidget {
  @override
  _AppbarSYSState createState() => _AppbarSYSState();

  @override
  Size get preferredSize => Size.fromHeight(136);
}

class _AppbarSYSState extends State<ShopHomeHeader> {
  TextEditingController _controller = TextEditingController();
  String searchValue = "";
  String sessions = "";
  var hour = DateTime.now().hour;

  @override
  void initState() {
    if (hour > 12) {
      setState(() {
        sessions = "chiều";
      });
    } else
      setState(() {
        sessions = "sáng";
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          GestureDetector(
            child: Container(
              height: 136,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 16),
              child: Image.asset(
                'lib/G-Store/Assets/default_header.png',
                fit: BoxFit.cover,
              ),
            ),
            onTap: () {
              print(MediaQuery.of(context).size.width);
            },
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(bottom: 48, left: 16, right: 16),
            child: FText(
              "Chào buổi $sessions, Hưng",
              style: FTextStyle.bodyText2,
              color: FColors.grey1,
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: FTextField(
              hasBoder: false,
              controller: _controller,
              size: FTextFieldSize.size40,
              leftIcon: FOutlinedIcons.search,
              label: "Bạn muốn tìm gì?",
              value: searchValue,
              onChanged: () {},
            ),
          ),
        ],
      ),
    );
  }
}
