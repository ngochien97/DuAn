import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/material.dart';

class FBoundingBox extends StatelessWidget {
  final FBoxSize size;
  final Widget child;
  final Widget topItems;
  final Widget bottomItems;
  final FBoundingBoxType type;
  final Color backgroundColor;

  FBoundingBox({
    this.size = FBoxSize.size24x24,
    @required this.child,
    this.backgroundColor = FColors.grey4,
    this.type = FBoundingBoxType.round,
    this.topItems,
    this.bottomItems,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> boxState;
    double maxWidth = double.maxFinite;

    switch (size) {
      case FBoxSize.size8x8:
        boxState = {
          'value': 8.0,
          'type': 'size8x8',
        };
        break;
      case FBoxSize.size16x16:
        boxState = {
          'value': 16.0,
          'type': 'size16x16',
        };
        break;
      case FBoxSize.size20x20:
        boxState = {
          'value': 20.0,
          'type': 'size20x20',
        };
        break;
      case FBoxSize.size24x24:
        boxState = {
          'value': 24.0,
          'type': 'size24x24',
        };
        break;
      case FBoxSize.size32x32:
        boxState = {
          'value': 32.0,
          'type': 'size32x32',
        };
        break;
      case FBoxSize.size40x40:
        boxState = {
          'value': 40.0,
          'type': 'size40x40',
        };
        break;
      case FBoxSize.size48x48:
        boxState = {
          'value': 48.0,
          'type': 'size48x48',
        };
        break;
      case FBoxSize.size56x56:
        boxState = {
          'value': 56.0,
          'type': 'size56x56',
        };
        break;
      case FBoxSize.size64x64:
        boxState = {
          'value': 64.0,
          'type': 'size64x64',
        };
        break;
      case FBoxSize.size72x72:
        boxState = {
          'value': 72.0,
          'type': 'size72x72',
        };
        break;
      case FBoxSize.size80x80:
        boxState = {
          'value': 80.0,
          'type': 'size80x80',
        };
        break;
      case FBoxSize.size88x88:
        boxState = {
          'value': 88.0,
          'type': 'size88x88',
        };
        break;
      case FBoxSize.size96x96:
        boxState = {
          'value': 96.0,
          'type': 'size96x96',
        };
        break;
      case FBoxSize.size104x104:
        boxState = {
          'value': 104.0,
          'type': 'size104x104',
        };
        break;
      case FBoxSize.auto_square:
        boxState = {
          'value': maxWidth,
          'type': 'auto_square',
        };
        break;
      case FBoxSize.auto_rectangle:
        boxState = {
          'value': maxWidth,
          'type': 'auto_rectangle',
        };
        break;
      case FBoxSize.auto_rectangle_special:
        boxState = {
          'value': maxWidth,
          'type': 'auto_rectangle_special',
        };
        break;
    }
    switch (type) {
      case FBoundingBoxType.circle:
        boxState['borderRadius'] = {
          'size8x8': 4.0,
          'size16x16': 8.0,
          'size20x20': 10.0,
          'size24x24': 12.0,
          'size32x32': 16.0,
          'size40x40': 20.0,
          'size48x48': 24.0,
          'size56x56': 28.0,
          'size64x64': 32.0,
          'size72x72': 36.0,
          'size80x80': 40.0,
          'size88x88': 44.0,
          'size96x96': 48.0,
          'size104x104': 52.0,
          'auto_square': 12.0,
          'auto_rectangle': 12.0,
          'auto_rectangle_special': 12.0,
        };
        break;
      case FBoundingBoxType.square:
        boxState['borderRadius'] = {
          'size8x8': 0.0,
          'size16x16': 0.0,
          'size20x20': 0.0,
          'size24x24': 0.0,
          'size32x32': 0.0,
          'size40x40': 0.0,
          'size48x48': 0.0,
          'size56x56': 0.0,
          'size64x64': 0.0,
          'size72x72': 0.0,
          'size80x80': 0.0,
          'size88x88': 0.0,
          'size96x96': 0.0,
          'size104x104': 0.0,
          'auto_square': 12.0,
          'auto_rectangle': 12.0,
          'auto_rectangle_special': 12.0,
        };
        break;
      case FBoundingBoxType.round:
        boxState['borderRadius'] = {
          'size8x8': 2.0,
          'size16x16': 4.0,
          'size20x20': 4.0,
          'size24x24': 8.0,
          'size32x32': 8.0,
          'size40x40': 12.0,
          'size48x48': 12.0,
          'size56x56': 12.0,
          'size64x64': 12.0,
          'size72x72': 12.0,
          'size80x80': 12.0,
          'size88x88': 12.0,
          'size96x96': 12.0,
          'size104x104': 12.0,
          'auto_square': 12.0,
          'auto_rectangle': 12.0,
          'auto_rectangle_special': 12.0,
        };
        break;
    }
    double borderRadius = boxState['borderRadius'][boxState['type']];
    List<FBoxSize> sp = [
      FBoxSize.auto_rectangle,
      FBoxSize.auto_rectangle_special,
      FBoxSize.auto_square,
    ];

    return child == null
        ? SizedBox()
        : !sp.contains(size)
            ? Container(
                width: boxState['value'],
                height: boxState['value'],
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        child,
                        topItems != null
                            ? Positioned(
                                child: topItems,
                                top: 0,
                                right: 0,
                              )
                            : Container(),
                        bottomItems != null
                            ? Positioned(
                                child: bottomItems,
                                bottom: 0,
                                right: 0,
                              )
                            : Container(),
                      ],
                    ),
                    alignment: Alignment.center,
                  ),
                ),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              )
            : AspectRatio(
                aspectRatio: size == FBoxSize.auto_rectangle
                    ? 4 / 3
                    : size == FBoxSize.auto_rectangle_special ? 2 / 1 : 1 / 1,
                child: Container(
                  width: boxState['value'],
                  height: boxState['value'],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          child,
                          topItems != null
                              ? Positioned(
                                  child: topItems,
                                  top: 0,
                                  right: 0,
                                )
                              : Container(),
                          bottomItems != null
                              ? Positioned(
                                  child: bottomItems,
                                  right: 0,
                                  bottom: 0,
                                )
                              : Container(),
                        ],
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                  color: FColors.transparent,
                ),
              );
  }
}

enum FBoxSize {
  size8x8,
  size16x16,
  size20x20,
  size24x24,
  size32x32,
  size40x40,
  size48x48,
  size56x56,
  size64x64,
  size72x72,
  size80x80,
  size88x88,
  size96x96,
  size104x104,
  auto_square,
  auto_rectangle,
  auto_rectangle_special,
}

enum FBoundingBoxType {
  circle,
  square,
  round,
}
