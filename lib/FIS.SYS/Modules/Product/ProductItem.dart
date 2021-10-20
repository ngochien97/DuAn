import 'package:Framework/FIS.SYS/Modules/BaseSimple.dart';

class ProductItems extends BaseItem {
  //product
  String image;
  String price;
  String rating;
  String location;

  ProductItems({
    id,
    name,
    this.image,
    this.price,
    this.location,
    this.rating,
  }) : super(id: id, name: name);
}
