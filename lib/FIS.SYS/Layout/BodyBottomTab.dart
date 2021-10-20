import 'package:flutter/material.dart';

class BodyBottomTabLayout extends StatelessWidget {
  final List<Widget> body;
  final Widget bottom;
  BodyBottomTabLayout({
    Key key,
    this.body,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: body,
        ),
      ),
      bottomNavigationBar: bottom,
    );
  }
}
