import 'package:flutter/material.dart';

class HeaderBodyLayout extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final Widget body;

  HeaderBodyLayout({
    Key key,
    this.appBar,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }
}
