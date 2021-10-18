import 'package:flutter/material.dart';

class SlideShowScreen extends StatefulWidget {
  @override
  _SlideShowScreenState createState() => _SlideShowScreenState();
}

class _SlideShowScreenState extends State<SlideShowScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Text('Màn hình trình chiếu'),
        ),
      );
}
