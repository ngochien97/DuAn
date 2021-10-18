// FOR PAINTING CIRCLES
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../Answer.dart';
import '../Question.dart';

class DrawMarker extends CustomPainter {
  // double x;
  // double y;
  int wImage;
  int hImage;
  List<Answer> answers;
  Map<int, String> studentCard;
  Question question;

  DrawMarker(
      {this.wImage,
      this.hImage,
      this.answers,
      this.studentCard,
      this.question});
  @override
  void paint(Canvas canvas, Size size) {
    if (wImage != 0) {
      final isIOS = !Platform.isAndroid;
      canvas.save();
      for (final answer in answers) {
        final yProjection = size.height / (wImage);
        final xProjection = size.width / (hImage);
        answer.drawCanvas(canvas, xProjection, yProjection,
            studentCard[answer.id] ?? '${answer.id}');
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  String connvertNumberToCharAnswer(String char) {
    switch (char) {
      case '1':
        return 'A';
      case '2':
        return 'B';
      case '3':
        return 'C';
      case '4':
        return 'D';
      default:
        return null;
    }
  }
}
