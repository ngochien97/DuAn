import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FTableCell extends StatefulWidget {
  final Widget child;
  final AlignmentGeometry alignment;

  FTableCell({
    Key key,
    this.alignment = Alignment.centerLeft,
    this.child,
  }) : super(key: key);

  @override
  _FTableCellState createState() => _FTableCellState();
}

class _FTableCellState extends State<FTableCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 40,
      ),
      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 12),
      alignment: widget.alignment,
      child: widget.child,
    );
  }
}
