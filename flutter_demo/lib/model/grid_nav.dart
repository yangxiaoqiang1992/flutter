import 'package:flutter_demo/model/common_model.dart';

class GridNav {
  final GridNavItemModel hotel;
  final GridNavItemModel flight;
  final GridNavItemModel travel;
  GridNav({this.hotel, this.flight, this.travel});
  factory GridNav.fromJson(Map<String, dynamic> json) {
    return GridNav(
        hotel: GridNavItemModel.fromJson(json['hotel']),
        flight: GridNavItemModel.fromJson(json['flight']),
        travel: GridNavItemModel.fromJson(json['travel']));
  }
}

class GridNavItemModel {
  final int startColor;
  final int endColor;
  final CommonModel mainItem;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;
  GridNavItemModel(
      {this.startColor,
      this.endColor,
      this.mainItem,
      this.item1,
      this.item2,
      this.item3,
      this.item4});
  factory GridNavItemModel.fromJson(Map<String, dynamic> json) {
    return GridNavItemModel(
      startColor: int.parse('0xff' + json['startColor']),
      endColor: int.parse('0xff' + json['endColor']),
      mainItem: CommonModel.fromJson(json['mainItem']),
      item1: CommonModel.fromJson(json['item1']),
      item2: CommonModel.fromJson(json['item2']),
      item3: CommonModel.fromJson(json['item3']),
      item4: CommonModel.fromJson(json['item4']),
    );
  }
}
