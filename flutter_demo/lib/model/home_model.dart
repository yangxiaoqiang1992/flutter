import 'package:flutter_demo/model/banner_model.dart';
import 'package:flutter_demo/model/common_model.dart';
import 'package:flutter_demo/model/grid_nav.dart';
import 'package:flutter_demo/model/sales_box.dart';

import 'home_config_model.dart';

class HomeModel {
  final HomeConfigModel config;
  final List<BannerModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final SalesBox salesBox;
  final GridNav gridNav;
  HomeModel(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.subNavList,
      this.salesBox,
      this.gridNav});
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var banners = json['bannerList'] as List;
    var localNavs = json['localNavList'] as List;
    var subNavs = json['subNavList'] as List;
    List<BannerModel> bannerList =
        banners.map((item) => BannerModel.fromJson(item)).toList();
    List<CommonModel> localNavList =
        localNavs.map((item) => CommonModel.fromJson(item)).toList();

    List<CommonModel> subNavList =
        subNavs.map((item) => CommonModel.fromJson(item)).toList();
    return HomeModel(
        config: HomeConfigModel.fromJson(json['config']),
        bannerList: bannerList,
        localNavList: localNavList,
        subNavList: subNavList,
        salesBox: SalesBox.fromJson(json['salesBox']),
        gridNav: GridNav.fromJson(json['gridNav']));
  }
}
