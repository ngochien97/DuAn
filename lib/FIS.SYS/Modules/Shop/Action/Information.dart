import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/Product/Actions/Product.dart';
import 'package:Framework/FIS.SYS/Modules/Shop/Action/SimilarStore.dart';
import 'package:Framework/FIS.SYS/Modules/Voucher/Actions/Voucher.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';

class ShopDetails extends StatefulWidget {
  ShopDetails({Key key}) : super(key: key);

  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: ShopVoucher(),
          ),
          Container(
            // color: FColors.grey1,
            color: FColors.transparent,

            child: Column(
              children: [
                Container(
                  child: FListTitle(
                    title: FText(
                      'Sản phẩm đang bán',
                      style: FTextStyle.titleModules4,
                    ),
                    action: [
                      GestureDetector(
                        child: FText(
                          "Tất cả",
                          color: FColors.blue6,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                ShopProduct(),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                FListTitle(
                  backgroundColor: FColors.transparent,
                  title: FText(
                    'Cửa hàng tương tự',
                    style: FTextStyle.titleModules4,
                  ),
                  action: [
                    GestureDetector(
                      child: FText(
                        "Tất cả",
                        color: FColors.blue6,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
                Container(
                  color: FColors.grey1,
                  child: SimilarStore(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
