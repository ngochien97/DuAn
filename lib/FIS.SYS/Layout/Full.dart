import 'package:flutter/material.dart';

class FullLayout extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final Widget body;
  final Widget bottom;
  final Color backgroundColor;

  FullLayout({
    Key key,
    this.appBar,
    this.body,
    this.bottom,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottom,
    );
  }
}
