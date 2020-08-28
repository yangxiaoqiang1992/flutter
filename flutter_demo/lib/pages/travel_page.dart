import 'package:flutter/material.dart';
import 'package:flutter_demo/dao/travel_tab.dart';
import 'package:flutter_demo/model/travel_tab_model.dart';
import 'package:flutter_demo/pages/travel_tab_page.dart';

const URL = 'https://www.devio.org/io/flutter_app/json/travel_page.json';

class TravelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  TabController _controller;
  List<Tabs> tabs = [];
  TravelTabModel travelTabModel;

  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel model) {
      //this.tabs = res;
      _controller = TabController(length: model.tabs.length, vsync: this);
      setState(() {
        tabs = model.tabs;
        travelTabModel = model;
      });
    });
    
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          height: 50,
          child: TabBar(
            tabs: tabs.map((Tabs tab) => Tab(text: tab.labelName)).toList(),
            controller: _controller,
            isScrollable: true,
            labelColor: Colors.blue,
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.blue, width: 2),
                insets: EdgeInsets.only(bottom: 2)),
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.green,
            indicatorWeight: 2,
          ),
        ),
        Flexible(
            child: TabBarView(
                controller: _controller,
                children: tabs.map((Tabs tab) => TravelTabPage()).toList()))
      ],
    ));
  }
}
