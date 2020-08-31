class BannerModel {
  final String icon;
  final String url;

  BannerModel({this.icon, this.url});
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(icon: json['icon'], url: json['url']);
  }
}
