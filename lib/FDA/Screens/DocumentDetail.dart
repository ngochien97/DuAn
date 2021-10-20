import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:flutter/services.dart';

class DocumentDetailScreen extends StatelessWidget {
  final String image;
  final String heroTag;
  const DocumentDetailScreen({
    Key key,
    this.image,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
          color: FColors.grey10,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Hero(
            tag: heroTag,
            child: Image.memory(
              convert.base64Decode(
                image.replaceFirst("data:image/jpeg;base64,", ""),
              ),
            ),
          ),
        ),
        onPanUpdate: (detail) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
          Navigator.pop(context);
        },
      ),
    );
  }
}
