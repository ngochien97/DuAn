import 'package:flutter/material.dart';

class BodyLayout extends StatelessWidget {
  final List<Widget> body;

  BodyLayout({
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: body,
      ),
    ));
  }
}
