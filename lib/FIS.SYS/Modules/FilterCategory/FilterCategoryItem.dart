import 'package:Framework/FIS.SYS/Modules/BaseSimple.dart';

class FilterCategoryItem extends BaseItem {
  String icon;
  String check;
  FilterCategoryItem({
    id,
    name,
    this.icon,
    this.check,
  }) : super(id: id, name: name);
}
