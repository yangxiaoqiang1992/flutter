import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/home_page.dart';
import 'package:flutter_demo/pages/my_page.dart';
import 'package:flutter_demo/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _controller = PageController(initialPage: 0);
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: PageView(
          controller: _controller,
          children: <Widget>[HomePage(), TravelPage(), MyPage()],
          physics: NeverScrollableScrollPhysics()),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: _defaultColor),
                title: Text('首页'),
                activeIcon: Icon(Icons.home, color: _activeColor)),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt, color: _defaultColor),
                title: Text('旅拍'),
                activeIcon: Icon(Icons.camera_alt, color: _activeColor)),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, color: _defaultColor),
                title: Text('我的'),
                activeIcon: Icon(Icons.account_circle, color: _activeColor))
          ]),
    );
  }
}
