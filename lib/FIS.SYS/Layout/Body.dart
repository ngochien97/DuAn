import 'package:flutter/material.dart';

class BodyLayout extends StatelessWidget {
  final Widget body;

  BodyLayout({
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body);
  }
}
