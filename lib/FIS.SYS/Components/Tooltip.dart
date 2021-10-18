// ignore: file_names
import 'package:flutter/material.dart';
import 'package:khao_thi_gv/F.Utils/Utils.dart';

import '../Styles/Colors.dart';
import 'Text.dart';

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
  final Duration durationEnd;
  final bool onLongPress;
  @override
  // ignore: overridden_fields
  final GlobalKey key = GlobalKey();

  FTooltip({
    @required this.message,
    this.child,
    this.height,
    this.durationEnd,
    this.width,
    this.arrowPosition = FTooltipArrowPosition.center,
    this.backgroundColor = FColors.blue6,
    this.color = FColors.grey1,
    this.direction = FTooltipDirection.arrowTop,
    this.onLongPress = false,
  });

  OverlayEntry overlayEntryGlobal;
  OverlayEntry createOverlayEntry(BuildContext context) {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final type = {
      'arrowTop': {
        'top': offset.dy + size.height + 4.0,
        'left': offset.dx + size.width / 2 - message.length * 4.5,
      },
      'arrowRight': {
        'top': offset.dy + size.height / 2 - 16,
        'left': offset.dx - (width ?? 90),
      },
      'arrowBottom': {
        'top': offset.dy - 36,
        'left': offset.dx + size.width / 2 - message.length * 4.5,
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
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
            child: Wrap(
              children: [
                FText(
                  message,
                  color: color,
                  decoration: TextDecoration.none,
                ),
              ],
            ),
          ),
        );

    Widget messageDirection() {
      final directionName = direction.getDirection;
      switch (directionName) {
        case 'arrowTop':
          return Container(
            child: Column(
              crossAxisAlignment: arrowPosition.getPosition,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    child: CustomPaint(
                      painter: DrawTriangle(strokeColor: backgroundColor),
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
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
          return const SizedBox(
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
  Widget build(BuildContext context) => GestureDetector(
        onTap: onLongPress
            ? null
            : () {
                try {
                  final overlayEntry = createOverlayEntry(context);
                  Overlay.of(context).insert(overlayEntry);
                  Future.delayed(durationEnd ?? const Duration(seconds: 1),
                      overlayEntry.remove);
                  // ignore: avoid_catches_without_on_clauses
                } catch (e) {
                  Utils.console(e);
                }
              },
        onLongPressStart: onLongPress
            ? (start) {
                overlayEntryGlobal = createOverlayEntry(context);
                Overlay.of(context).insert(overlayEntryGlobal);
              }
            : null,
        onLongPressEnd: onLongPress
            ? (end) => Future.delayed(durationEnd ?? const Duration(seconds: 1),
                () => overlayEntryGlobal.remove())
            : null,
        child: child,
      );
}

enum FTooltipDirection {
  arrowTop,
  arrowRight,
  arrowBottom,
  arrowLeft,
}

extension FTooltipDirectionExtension on FTooltipDirection {
  static Map<FTooltipDirection, String> direction = {
    FTooltipDirection.arrowTop: 'arrowTop',
    FTooltipDirection.arrowRight: 'arrowRight',
    FTooltipDirection.arrowBottom: 'arrowBottom',
    FTooltipDirection.arrowLeft: 'arrowLeft',
  };

  String get getDirection => direction[this];
}

enum FTooltipArrowPosition {
  start,
  center,
  end,
}

extension FTooltipArrowPositionExtension on FTooltipArrowPosition {
  static Map<FTooltipArrowPosition, CrossAxisAlignment> position = {
    FTooltipArrowPosition.start: CrossAxisAlignment.start,
    FTooltipArrowPosition.center: CrossAxisAlignment.center,
    FTooltipArrowPosition.end: CrossAxisAlignment.end,
  };
  CrossAxisAlignment get getPosition => position[this];
}

class DrawTriangle extends CustomPainter {
  final Color strokeColor;
  final String direction;
  DrawTriangle({this.strokeColor = FColors.blue6, this.direction = 'up'});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
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
  bool shouldRepaint(DrawTriangle oldDelegate) =>
      oldDelegate.strokeColor != strokeColor;
}
