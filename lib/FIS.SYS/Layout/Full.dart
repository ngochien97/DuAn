import 'package:flutter/material.dart';

class FullLayout extends StatelessWidget {
  final PreferredSizeWidget appBar;
  final List<Widget> body;
  final Widget bottom;
  final Color backGround;

  FullLayout({
    Key key,
    this.appBar,
    this.body,
    this.bottom, this.backGround,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: body,
        ),
      ),
      bottomNavigationBar: bottom,
    );
  }
}
