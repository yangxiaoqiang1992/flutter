import 'package:flutter/material.dart';
import 'package:flutter_demo/dao/travel.dart';
import 'package:flutter_demo/model/travel_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const PAGE_SIZE = 10;

class TravelTabPage extends StatefulWidget {
  final String url;
  final String groupChannelCode;
  TravelTabPage({Key key, this.url, this.groupChannelCode}) : super(key: key);

  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage> {
  List<TravelArticle> resultList = [];
  @override
  void initState() {
    TravelDao.fetch(pageIndex: 1, pageSize: 10, groupChannelCode: 'ycy422')
        .then((TravelModel model) {
      setState(() {
        resultList = model.resultList;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new StaggeredGridView.countBuilder(
      primary: false,
      crossAxisCount: 4,
      itemCount: resultList?.length,
      itemBuilder: (BuildContext context, int index) =>
          _TravelItem(index: index, item: resultList[index]),
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      // staggeredTileBuilder: (int index) =>
      //     new StaggeredTile.count(2, index.isEven ? 2 : 1),
    ));
  }
}

class _TravelItem extends StatelessWidget {
  final int index;
  final TravelArticle item;
  const _TravelItem({Key key, this.index, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Card(
          child: PhysicalModel(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ArticleImage(article: item.article),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    item.article.articleTitle,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () => {
          //todo:跳转详情页面
        },
      ),
    );
  }
}

class ArticleImage extends StatelessWidget {
  final Article article;
  const ArticleImage({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.network(article.images[0]?.dynamicUrl, fit: BoxFit.cover),
        Positioned(
            bottom: 8,
            left: 8,
            child: Container(
                padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.location_on, size: 14, color: Colors.white60),
                    LimitedBox(
                        maxWidth: 130,
                        child: Text(
                          _poisName(),
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white60, fontSize: 12),
                        ))
                  ],
                )))
      ],
    );
  }

  String _poisName() {
    return article.pois == null || article.pois.length == 0
        ? '未知'
        : article.pois[0]?.poiName ?? '未知';
  }
}
