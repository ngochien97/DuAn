import 'package:Framework/FIS.SYS/Modules/BaseSimple.dart';

class ShopItems extends BaseItem {
  String armorial;
  String rank;
  String address;
  String rating;
  String location;
  String image;
  String type;
  String vote;

  ShopItems({
    id,
    name,
    this.armorial,
    this.rank,
    this.address,
    this.rating,
    this.location,
    this.image,
    this.type,
    this.vote,
  }) : super(id: id, name: name);
}
// ShopItems storeData = new ShopItems(
//   armorial: "Cửa hàng uy tín",
//   rank: "1",
//   name: "Quán Bà Lan - Thiên Hiển",
//   address: "Tầng 1, Vincom Center Phạm Ngọc Thạch, Đống Đa",
//   rating: "4.4(80)",
// );
