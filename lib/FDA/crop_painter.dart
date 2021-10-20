import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CropPainter extends CustomPainter {
  Offset tl, tr, bl, br;
  CropPainter(this.tl, this.tr, this.bl, this.br);
  Paint painter = Paint()
    ..color = FColors.grey1
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.fill;
  Paint border = Paint()
    ..color = FColors.orange6
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;
  Paint painter1 = Paint()
    ..color = FColors.orange6
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.round;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(tl, 8, painter);
    canvas.drawCircle(tr, 8, painter);
    canvas.drawCircle(bl, 8, painter);
    canvas.drawCircle(br, 8, painter);
    canvas.drawCircle(tl, 10, border);
    canvas.drawCircle(tr, 10, border);
    canvas.drawCircle(bl, 10, border);
    canvas.drawCircle(br, 10, border);
    canvas.drawLine(tl, tr, painter1);
    canvas.drawLine(tr, br, painter1);
    canvas.drawLine(br, bl, painter1);
    canvas.drawLine(bl, tl, painter1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
