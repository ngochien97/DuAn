import 'package:Framework/FIS.SYS/Modules/BaseSimple.dart';

class ProductHomeItems extends BaseItem {
  //product
  String image;
  String price;
  String rating;
  String location;
  String like;
  String address;
  String speed;
  String rank;

  ProductHomeItems({
    id,
    name,
    this.image,
    this.price,
    this.location,
    this.rating,
    this.like,
    this.address,
    this.speed,
    this.rank,
  }) : super(id: id, name: name);
}
