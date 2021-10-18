import 'package:flutter/material.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/StyleBase.dart';

class FListTileNew extends StatefulWidget {
  const FListTileNew({
    Key key,
    this.avatar,
    this.title,
    this.subtitle,
    this.action,
    this.size = FListTileSize.size48,
    this.onTap,
    this.backgroundColor = FColors.grey1,
  }) : super(key: key);

  final FListTileSize size;
  final VoidCallback onTap;
  final Widget avatar;
  final Widget title;
  final Widget subtitle;
  final Widget action;
  final Color backgroundColor;

  @override
  _FListTileNewState createState() => _FListTileNewState();
}

class _FListTileNewState extends State<FListTileNew> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onPanUpdate: (details) {
      //   if (details.delta.dx > 0 && details.delta.distance > 8) {
      //     setState(() {
      //       _isShowLeft = true;
      //     });
      //   } else {
      //     setState(() {
      //       _isShowLeft = false;
      //     });
      //   }
      // },
      onTap: widget.onTap,
      child: Container(
        height: widget.size.height,
        padding: EdgeInsets.symmetric(horizontal: 16),
        color: widget.backgroundColor,
        child: Row(
          children: [
            if (widget.avatar != null)
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                child: AspectRatio(aspectRatio: 1, child: widget.avatar),
              ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: DefaultTextStyle(
                        style: FTextStyle.titleModules6.textStyle
                            .copyWith(color: FColors.grey10),
                        child: widget.title,
                      ),
                    ),
                    if (widget.subtitle != null)
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                        child: DefaultTextStyle(
                          style: FTextStyle.subtitle2.textStyle
                              .copyWith(color: FColors.grey7),
                          child: widget.subtitle,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (widget.action != null)
              Container(
                margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                child: widget.action,
              ),
          ],
        ),
      ),
    );
  }
}

class FListTileSize {
  const FListTileSize({
    this.height,
  });

  final double height;

  static const FListTileSize size32 = FListTileSize(
    height: 32,
  );

  static const FListTileSize size40 = FListTileSize(
    height: 40,
  );

  static const FListTileSize size48 = FListTileSize(
    height: 48,
  );

  static const FListTileSize size56 = FListTileSize(
    height: 56,
  );

  static const FListTileSize size64 = FListTileSize(
    height: 64,
  );

  static const FListTileSize size72 = FListTileSize(
    height: 72,
  );

  static const FListTileSize size80 = FListTileSize(
    height: 80,
  );

  static const FListTileSize size88 = FListTileSize(
    height: 88,
  );
}
