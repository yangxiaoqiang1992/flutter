import 'package:flutter_demo/model/banner_model.dart';

import 'home_config_model.dart';

class HomeModel {
  final HomeConfigModel config;
  final List<BannerModel> bannerList;
  HomeModel({this.config, this.bannerList});
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var banners = json['bannerList'] as List;
    List<BannerModel> bannerList =
        banners.map((item) => BannerModel.fromJson(item)).toList();
    return HomeModel(
        config: HomeConfigModel.fromJson(json['config']),
        bannerList: bannerList);
  }
}
