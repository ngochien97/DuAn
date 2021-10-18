import 'package:flutter/cupertino.dart';
import '../../Styles/Colors.dart';

class Answer {
  double x;
  double y;
  String answer;
  int id;
  bool isCorrect = false;
  String choice;
  int totalSelected = 0;

  Answer(
      {this.x, this.y, this.answer, this.id, this.choice, this.totalSelected});

  void drawCanvas(
    Canvas canvas,
    double xProjection,
    double yProjection,
    String studentName,
  ) {
    final textStyle = TextStyle(
      color: FColors.grey1,
      fontSize: 12,
    );

    final textSpan = TextSpan(
      text: '$studentName - ${connvertNumberToCharAnswer(answer)}',
      style: textStyle,
    );
    final textPainter = TextPainter(
        text: textSpan,
        // maxLines: 1,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.left);

    final drawPosition = Offset(x * xProjection, y * yProjection);

    final paint1 = Paint()
      ..color = isCorrect ? FColors.green6 : FColors.red6
      ..style = PaintingStyle.fill;

    //a circle
    canvas.drawCircle(drawPosition, 4, paint1);
    textPainter.layout();
    textPainter.paint(canvas, Offset(x * xProjection + 5, y * yProjection - 8));
  }

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
      x: json['x'], y: json['y'], id: json['id'], answer: json['answer']);

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
