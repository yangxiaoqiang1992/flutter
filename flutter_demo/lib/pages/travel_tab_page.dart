import 'package:flutter/material.dart';
import 'package:flutter_demo/dao/travel.dart';
import 'package:flutter_demo/model/travel_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const PAGE_SIZE = 10;
var pageIndex = 1;

class TravelTabPage extends StatefulWidget {
  final String url;
  final String groupChannelCode;
  TravelTabPage({Key key, this.url, this.groupChannelCode}) : super(key: key);

  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  List<TravelArticle> resultList = [];
  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
            child: new StaggeredGridView.countBuilder(
              controller: _scrollController,
              primary: false,
              crossAxisCount: 4,
              itemCount: resultList?.length,
              itemBuilder: (BuildContext context, int index) =>
                  _TravelItem(index: index, item: resultList[index]),
              staggeredTileBuilder: (index) => StaggeredTile.fit(2),
              // staggeredTileBuilder: (int index) =>
              //     new StaggeredTile.count(2, index.isEven ? 2 : 1),
            ),
            onRefresh: _refreshHandler));
  }

  void _loadData({loadMore = false}) {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    TravelDao.fetch(
            pageIndex: pageIndex,
            pageSize: PAGE_SIZE,
            groupChannelCode: widget.groupChannelCode)
        .then((TravelModel model) {
      setState(() {
        if (pageIndex != 1) {
          resultList.addAll(model.resultList);
        } else {
          resultList = model.resultList;
        }
      });
    });
  }

  Future<void> _refreshHandler() async {
    _loadData();
  }

  @override
  bool get wantKeepAlive => true;
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
                ),
                Container(
                    padding: EdgeInsets.all(5),
                    child: _authorInfo(item.article))
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

  _authorInfo(Article article) {
    final author = article.author;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Row(children: <Widget>[
            PhysicalModel(
              color: Colors.transparent,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(20),
              child: Image.network(author.coverImage.dynamicUrl,
                  width: 20, height: 20),
            ),
            LimitedBox(
                maxWidth: 100,
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(author.nickName,
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1),
                ))
          ]),
        ),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.thumb_up, color: Colors.grey, size: 16),
              Padding(
                  padding: EdgeInsets.only(left: 3),
                  child: Text(article.likeCount.toString(),
                      style: TextStyle(color: Colors.black87, fontSize: 11)))
            ],
          ),
        )
      ],
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
