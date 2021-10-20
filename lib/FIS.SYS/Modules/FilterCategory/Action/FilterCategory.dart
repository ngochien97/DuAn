import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Modules/FilterCategory/FilterCategoryItem.dart';
import 'package:Framework/FIS.SYS/Components/Text.dart';
import 'package:Framework/FIS.SYS/Styles/Colors.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:flutter/material.dart';

class FilterCategory extends StatefulWidget {
  @override
  _FilterCategoryState createState() => _FilterCategoryState();
}

class _FilterCategoryState extends State<FilterCategory> {
  List<FilterCategoryItem> data = [
    FilterCategoryItem(
      icon: FOutlinedIcons.alipay,
      name: 'Thời trang (10)',
    ),
    FilterCategoryItem(
      icon: FOutlinedIcons.amazon,
      name: 'Máy tính (0)',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, indext) {
            return Container(
              child: Row(
                children: [
                  for (var item in data) FIconButton(icon: item.icon),
                  // FText(item.name)
                ],
              ),
            );
          }),
    );
  }
}
