import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _pageController = new PageController();
  var activePage = 0;
  List<Map<String, dynamic>> listItem = [
    {
      "image": 'lib/G-Store/Assets/Splash1.svg',
      "text":
          'Tham gia cộng đồng G-STORE để giao lưu, chia sẻ và \n nhận các thông báo về tin tức kinh tế, thị trường trao \n đổi mua bán hàng hóa, dịch vụ.',
    },
    {
      "image": 'lib/G-Store/Assets/Splash2.svg',
      "text":
          'Đắm chìm vào các dịch vụ giải trí chất lượng được \n cộng đồng chọn lọc chia sẻ.',
    },
    {
      "image": 'lib/G-Store/Assets/Splash3.svg',
      "text":
          'Cùng nhau chia sẻ, trao tặng những giá trị của cuộc \n sống, từ hàng hóa, các dịch vụ mua sắm, trải nghiệm...',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FColors.grey1,
      child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
            child: SvgPicture.asset('lib/G-Store/Assets/Logo1.svg'),
          ),
          FText(
            'Tech company',
            style: FTextStyle.subtitle2,
            decoration: TextDecoration.none,
          ),
          Expanded(
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  activePage = value;
                });
              },
              controller: _pageController,
              children: [
                ...List.generate(
                  listItem.length,
                  (index) => Column(
                    children: [
                      SvgPicture.asset(listItem[index]['image']),
                      Container(
                        alignment: Alignment.center,
                        height: 100,
                        child: FText(
                          listItem[index]['text'],
                          decoration: TextDecoration.none,
                          fontFamily: 'Roboto',
                          textAlign: TextAlign.center,
                          style: FTextStyle.bodyText2,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Opacity(
                  opacity: activePage == 0 ? 0 : 1,
                  child: FButton(
                    backgroundColor: FColors.grey1,
                    color: FColors.grey9,
                    title: 'Back',
                    leftIcon: FOutlinedIcons.left,
                    onPressed: () {
                      _pageController.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                  ),
                ),
                Container(
                  width: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var item in listItem)
                        FBoundingBox(
                          type: FBoundingBoxType.circle,
                          child: FIconButton(
                            icon: FOutlinedIcons.alert,
                            color: FColors.green6,
                            backgroundColor:
                                activePage == listItem.indexOf(item)
                                    ? FColors.green6
                                    : FColors.grey4,
                            onPressed: () {},
                          ),
                          size: FBoxSize.size8x8,
                        ),
                    ],
                  ),
                ),
                FButton(
                  backgroundColor: FColors.grey1,
                  color: FColors.grey9,
                  title: 'Next',
                  rightIcon: FOutlinedIcons.right,
                  onPressed: () {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
