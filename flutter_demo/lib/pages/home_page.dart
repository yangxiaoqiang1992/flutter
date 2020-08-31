import 'package:flutter/material.dart';
import 'package:flutter_demo/dao/home.dart';
import 'package:flutter_demo/model/banner_model.dart';
import 'package:flutter_demo/model/home_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<BannerModel> _banners = [];
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
        body: Container(
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
              Opacity(
                opacity: 1,
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
            ])));
  }

  @override
  bool get wantKeepAlive => true;
}
