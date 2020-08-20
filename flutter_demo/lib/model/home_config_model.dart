class HomeConfigModel {
  final String searchUrl;
  HomeConfigModel({this.searchUrl});
  factory HomeConfigModel.fromJson(Map<String, dynamic> json) {
    return HomeConfigModel(searchUrl: json['searchUrl']);
  }
}
