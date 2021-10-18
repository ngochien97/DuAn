import 'package:flutter/material.dart';

import '../PresentationItem.dart';
import '../Question.dart';

class PresentProvider extends ChangeNotifier {
  PresentationItem present;
  int currentIdex = 0;
  Question currentQuestion;
  String topic;

  void init(PresentationItem present, int currentIdex, String topic) {
    this.present = present;
    this.currentIdex = currentIdex;
    currentQuestion = present.items[currentIdex];
    this.topic = topic;
  }

  void changeQuestion(int index) {
    currentIdex = index;
    currentQuestion = present.items[index];
    notifyListeners();
  }
}
