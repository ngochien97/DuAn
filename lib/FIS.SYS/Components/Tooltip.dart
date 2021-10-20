import 'package:Framework/FIS.SYS/Components/Text.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FTooltip extends StatelessWidget {
  final String message;
  final Widget child;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color color;
  final FTooltipDirection direction;
  final FTooltipArrowPosition arrowPosition;
  final int durationEnd;
  final GlobalKey key = GlobalKey();

  FTooltip({
    this.child,
    @required this.message,
    this.height,
    this.durationEnd = 1,
    this.width,
    this.arrowPosition = FTooltipArrowPosition.center,
    this.backgroundColor = FColors.blue6,
    this.color = FColors.grey1,
    this.direction = FTooltipDirection.arrowTop,
  });

  OverlayEntry overlayEntry;
  OverlayEntry createOverlayEntry(BuildContext context) {
    RenderBox renderBox = key.currentContext.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    var type = {
      'arrowTop': {
        'top': offset.dy + size.height + 4.0,
        'left': offset.dx + size.width / 2 - 38,
      },
      'arrowRight': {
        'top': offset.dy + size.height / 2 - 16,
        'left': offset.dx - (width != null ? width : 90),
      },
      'arrowBottom': {
        'top': offset.dy - 36,
        'left': offset.dx + size.width / 2 - 38.0,
      },
      'arrowLeft': {
        'top': offset.dy + size.height / 2 - 16,
        'left': offset.dx + size.width + 4.0,
      }
    };

    Widget messageContainer() => Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
            child: Wrap(
              children: [
                FText(
                  message,
                  style: FTextStyle.bodyText2,
                  color: color,
                  decoration: TextDecoration.none,
                ),
              ],
            ),
          ),
        );

    Widget messageDirection() {
      var directionName = direction.getDirection;
      switch (directionName) {
        case 'arrowTop':
          return Container(
            child: Column(
              crossAxisAlignment: arrowPosition.getPosition,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    child: CustomPaint(
                      painter: DrawTriangle(
                          strokeColor: backgroundColor, direction: 'up'),
                      child: Container(
                        height: 7,
                        width: 16,
                      ),
                    ),
                  ),
                ),
                messageContainer(),
              ],
            ),
          );
          break;
        case 'arrowBottom':
          return Column(
            crossAxisAlignment: arrowPosition.getPosition,
            mainAxisSize: MainAxisSize.min,
            children: [
              messageContainer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  child: CustomPaint(
                    painter: DrawTriangle(
                        strokeColor: backgroundColor, direction: 'down'),
                    child: Container(
                      height: 7,
                      width: 16,
                    ),
                  ),
                ),
              ),
            ],
          );
          break;
        case 'arrowRight':
          return Row(
            crossAxisAlignment: arrowPosition.getPosition,
            children: [
              messageContainer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  child: CustomPaint(
                    painter: DrawTriangle(
                        strokeColor: backgroundColor, direction: 'right'),
                    child: Container(
                      height: 13,
                      width: 6.5,
                    ),
                  ),
                ),
              ),
            ],
          );
          break;
        case 'arrowLeft':
          return Row(
            crossAxisAlignment: arrowPosition.getPosition,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  child: CustomPaint(
                    painter: DrawTriangle(
                        strokeColor: backgroundColor, direction: 'left'),
                    child: Container(
                      height: 13,
                      width: 6,
                    ),
                  ),
                ),
              ),
              messageContainer(),
            ],
          );
          break;
        default:
          return SizedBox(
            width: 1,
          );
      }
    }

    return OverlayEntry(
        builder: (context) => Positioned(
              top: type[direction.getDirection]['top'],
              left: type[direction.getDirection]['left'],
              child: messageDirection(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (start) {
        overlayEntry = createOverlayEntry(context);
        Overlay.of(context).insert(overlayEntry);
      },
      onLongPressEnd: (end) {
        return new Future.delayed(
            Duration(seconds: durationEnd), () => overlayEntry.remove());
      },
      child: child,
    );
  }
}

enum FTooltipDirection {
  arrowTop,
  arrowRight,
  arrowBottom,
  arrowLeft,
}

extension FTooltipDirectionExtension on FTooltipDirection {
  static var direction = {
    FTooltipDirection.arrowTop: 'arrowTop',
    FTooltipDirection.arrowRight: 'arrowRight',
    FTooltipDirection.arrowBottom: 'arrowBottom',
    FTooltipDirection.arrowLeft: 'arrowLeft',
  };

  get getDirection => direction[this];
}

enum FTooltipArrowPosition {
  start,
  center,
  end,
}

extension FTooltipArrowPositionExtension on FTooltipArrowPosition {
  static var position = {
    FTooltipArrowPosition.start: CrossAxisAlignment.start,
    FTooltipArrowPosition.center: CrossAxisAlignment.center,
    FTooltipArrowPosition.end: CrossAxisAlignment.end,
  };
  get getPosition => position[this];
}

class DrawTriangle extends CustomPainter {
  final Color strokeColor;
  final String direction;
  DrawTriangle({this.strokeColor = FColors.blue6, this.direction = 'up'});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    switch (direction) {
      case 'up':
        return Path()
          ..moveTo(0, y)
          ..lineTo(x / 2, 0)
          ..lineTo(x, y)
          ..lineTo(0, y);
        break;
      case 'down':
        return Path()
          ..moveTo(0, 0)
          ..lineTo(x, 0)
          ..lineTo(x / 2, y)
          ..lineTo(0, 0);
        break;
      case 'right':
        return Path()
          ..moveTo(0, 0)
          ..lineTo(x, y / 2)
          ..lineTo(0, y)
          ..lineTo(0, 0);
        break;
      case 'left':
        return Path()
          ..moveTo(0, y / 2)
          ..lineTo(x, 0)
          ..lineTo(x, y)
          ..lineTo(0, y / 2);
        break;
      default:
        return Path()
          ..moveTo(0, y)
          ..lineTo(x / 2, 0)
          ..lineTo(x, y)
          ..lineTo(0, y);
        break;
    }
  }

  @override
  bool shouldRepaint(DrawTriangle oldDelegate) {
    return oldDelegate.strokeColor != strokeColor;
  }
}
