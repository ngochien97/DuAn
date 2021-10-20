import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/Voucher/VoucherItems.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/FIS.SYS/Styles/Spacer.dart';
import 'package:flutter/material.dart';

class ShopVoucher extends StatefulWidget {
  ShopVoucher({Key key}) : super(key: key);

  @override
  _ShopVoucherState createState() => _ShopVoucherState();
}

class _ShopVoucherState extends State<ShopVoucher> {
  List<VoucherItems> data = [
    VoucherItems(
        icon: "FFilledIcons.coupon",
        title: "Nhập “G-STORE”, giảm 15k trên phí vận chuyển"),
    VoucherItems(
        icon: "FFilledIcons.delivery",
        title: "Miễn phí vận chuyển cho đơn hàng trên 200,000đ"),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
      child: Column(
        children: [
          for (var item in data)
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: FListTitle(
                      height: 48,
                      avatar: FBoundingBox(
                        backgroundColor: FColors.transparent,
                        child: FIcon(
                          icon: FFilledIcons.coupon,
                          color: [FColors.volcano6],
                        ),
                      ),
                      title: FText(
                        item.title,
                        style: FTextStyle.bodyText2,
                      ),
                    ),
                  ),
                  FSpacer.space8px,
                ],
              ),
            ),
        ],
      ),
    );
    // return Row(
    //   children: [
    //     for (var voucher in data)
    //       FListTitle(
    //         height: 48,
    //         avatar: FBoundingBox(
    //           backgroundColor: FColors.transparent,
    //           child: FIcon(
    //             icon: voucher.icon,
    //             color: [FColors.volcano6],
    //           ),
    //         ),
    //         title: FText(
    //           voucher.title,
    //           style: FTextStyle.bodyText2,
    //         ),
    //       )
    //   ],
    // );
  }
}
