class TravelTabModel {
  final String url;
  final List<Tabs> tabs;
  TravelTabModel({this.url, this.tabs});

  factory TravelTabModel.fromJson(Map<String, dynamic> json) {
    var tabsList = json['tabs'] as List;
    List<Tabs> tabs = tabsList.map((i) => Tabs.fromJson(i)).toList();
    return TravelTabModel(url: json['url'], tabs: tabs);
  }
}

class Tabs {
  final String labelName;
  final String groupChannelCode;
  Tabs({this.labelName, this.groupChannelCode});
  factory Tabs.fromJson(Map<String, dynamic> json) {
    return Tabs(
        labelName: json['labelName'],
        groupChannelCode: json['groupChannelCode']);
  }
}
