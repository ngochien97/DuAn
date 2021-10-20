import 'package:flutter/material.dart';

class BodyBottomTabLayout extends StatelessWidget {
  final Widget body;
  final Widget bottom;
  BodyBottomTabLayout({
    Key key,
    this.body,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: bottom,
    );
  }
}
