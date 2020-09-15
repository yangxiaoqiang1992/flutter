class CommonModel {
  final String title;
  final String icon;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;
  CommonModel(
      {this.title, this.icon, this.url, this.statusBarColor, this.hideAppBar});
  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
        title: json['title'],
        icon: json['icon'],
        url: json['url'],
        statusBarColor: json['statusBarColor'],
        hideAppBar: json['hideAppBar']);
  }
}
