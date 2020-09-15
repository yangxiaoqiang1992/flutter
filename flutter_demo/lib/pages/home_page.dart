import 'package:flutter/material.dart';
import 'package:flutter_demo/dao/home.dart';
import 'package:flutter_demo/model/banner_model.dart';
import 'package:flutter_demo/model/common_model.dart';
import 'package:flutter_demo/model/grid_nav.dart';
import 'package:flutter_demo/model/home_model.dart';
import 'package:flutter_demo/model/sales_box.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const double APP_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<BannerModel> _banners = [];
  List<CommonModel> _localNavs = [];
  List<CommonModel> _subNavs = [];
  SalesBox _salesBox;
  GridNav _gridNavs;
  double appBarAlpha = 0;
  @override
  void initState() {
    HomeDao.fetch().then((HomeModel model) {
      setState(() {
        _banners = model.bannerList;
        _localNavs = model.localNavList;
        _subNavs = model.subNavList;
        _salesBox = model.salesBox;
        _gridNavs = model.gridNav;
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
              child: Swiper(
                autoplay: true,
                autoplayDelay: 5000,
                duration: 1000,
                itemCount: _banners.length,
                itemBuilder: (context, index) =>
                    Image.network(_banners[index].icon, fit: BoxFit.fill),
                pagination: SwiperPagination(),
              ),
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _localNavs.map((CommonModel item) {
                    return GestureDetector(
                      onTap: () {},
                      child: _localNav(item),
                    );
                  }).toList(),
                )),
            //中间层
            Container(child: _gridNav()),
            Container(
              child: _subRows(),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
            ),
            // 热门活动
            Container(
              // padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Color(0xffe4e4e4), width: 0.8))),
              child: Column(
                children: <Widget>[
                  Container(
                    //标题头
                    height: 48,
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xffe4e4e4), width: 0.8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.network(
                          _salesBox.icon,
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(12, 2, 5, 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 3),
                                    blurRadius: 4)
                              ],
                              gradient: LinearGradient(colors: [
                                Color(0xffff4e63),
                                Color(0xffff6cc9)
                              ])),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '获取更多服务',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 13,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Image.network(_salesBox.bigCard1.icon),
                        flex: 1,
                      ),
                      Flexible(
                        child: Image.network(_salesBox.bigCard2.icon),
                        flex: 1,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Image.network(_salesBox.smallCard1.icon),
                        flex: 1,
                      ),
                      Flexible(
                        child: Image.network(_salesBox.smallCard2.icon),
                        flex: 1,
                      )
                    ],
                  )
                ],
              ),
            )
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

  _localNav(CommonModel item) {
    return Column(
      children: <Widget>[
        Image.network(
          item.icon,
          width: 45,
          height: 45,
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            item.title,
            style: TextStyle(fontSize: 13),
          ),
        )
      ],
    );
  }

  _subNav(CommonModel item) {
    return Expanded(
        child: Column(
          children: <Widget>[
            Image.network(item.icon, width: 20, height: 20),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                item.title,
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
        flex: 1);
  }

  _subRows() {
    int seperate = (_subNavs.length / 2 + 0.5).toInt();
    List<Widget> sublist = [];
    _subNavs.forEach((item) {
      sublist.add(_subNav(item));
    });
    return Column(children: <Widget>[
      Row(children: sublist.sublist(0, seperate)),
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: Row(children: sublist.sublist(seperate)),
      )
    ]);
  }

  _gridNav() {
    return PhysicalModel(
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              // Container(
              //   decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //           colors: [Color()])),
              // )
            ],
          )
        ],
      ),
    );
  }
}
