import 'package:flutter/material.dart';
import 'package:flutter_demo/dao/home.dart';
import 'package:flutter_demo/model/banner_model.dart';
import 'package:flutter_demo/model/home_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const double APP_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<BannerModel> _banners = [];
  double appBarAlpha = 0;
  @override
  void initState() {
    HomeDao.fetch().then((HomeModel model) {
      setState(() {
        _banners = model.bannerList;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification &&
                scrollNotification.depth == 0) {
              //deep =0 排除其他滚动因素
              _onscroll(scrollNotification.metrics.pixels);
            }
          },
          child: ListView(children: <Widget>[
            Container(
              height: 180,
              child: Stack(children: <Widget>[
                Swiper(
                  autoplay: true,
                  autoplayDelay: 5000,
                  duration: 1000,
                  itemCount: _banners.length,
                  itemBuilder: (context, index) =>
                      Image.network(_banners[index].icon, fit: BoxFit.fill),
                  pagination: SwiperPagination(),
                ),
              ]),
            ),
            Container(height: 800, child: ListTile(title: Text('测试滚动'))),
          ]),
        ),
        Opacity(
          opacity: appBarAlpha,
          child: Container(
            height: 50,
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              children: <Widget>[
                Text('hhh'),
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(hintText: 'hhh'),
                ))
              ],
            ),
          ),
        ),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _onscroll(offset) {
    double alpha = offset / APP_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print(appBarAlpha);
  }
}
