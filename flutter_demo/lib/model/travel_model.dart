class TravelModel {
  final int totalCount;
  final List<TravelArticle> resultList;
  TravelModel({this.totalCount, this.resultList});
  factory TravelModel.fromJson(Map<String, dynamic> json) {
    var results = json['resultList'] as List;
    List<TravelArticle> resultList =
        results.map((item) => TravelArticle.fromJson(item)).toList();
    return TravelModel(totalCount: json['totalCount'], resultList: resultList);
  }
}

class TravelArticle {
  final int type;
  final Article article;
  TravelArticle({this.type, this.article});
  factory TravelArticle.fromJson(Map<String, dynamic> json) {
    return TravelArticle(
        type: json['type'], article: Article.fromJson(json['article']));
  }
}

class Article {
  final int articleId;
  final int productType;
  final int sourceType;
  final String articleTitle;
  final String articleDesc;
  final String content;
  final Author author;
  final List<Images> images;
  final bool hasVideo;
  final int readCount;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final List<Urls> urls;
  final List<Pois> pois;
  Article(
      {this.images,
      this.hasVideo,
      this.readCount,
      this.likeCount,
      this.commentCount,
      this.shareCount,
      this.urls,
      this.productType,
      this.articleTitle,
      this.content,
      this.sourceType,
      this.author,
      this.articleDesc,
      this.articleId,
      this.pois});
  factory Article.fromJson(Map<String, dynamic> json) {
    var imagesList = json['images'] as List;
    var urlsList = json['urls'] as List;
    var poisList = json['pois'] as List;
    List<Images> images =
        imagesList.map((item) => Images.fromJson(item)).toList();
    List<Urls> urls = urlsList.map((item) => Urls.fromJson(item)).toList();
    List<Pois> pois = poisList.map((item) => Pois.fromJson(item)).toList();
    return Article(
        articleId: json['articleId'],
        productType: json['productType'],
        sourceType: json['sourceType'],
        articleTitle: json['articleTitle'],
        articleDesc: json['articleDesc'],
        content: json['content'],
        author: Author.fromJson(json['author']),
        images: images,
        hasVideo: json['hasVideo'],
        readCount: json['readCount'],
        likeCount: json['likeCount'],
        commentCount: json['commentCount'],
        shareCount: json['shareCount'],
        urls: urls,
        pois: pois);
  }
}

class Author {
  final int authorId;
  final String nickName;
  final String clientAuth;
  final String userUrl;
  final String jumpUrl;
  final CoverImage coverImage;
  final int identityType;
  final String identityTypeName;
  final String tag;
  final List<UserTags> userTags;

  Author(
      {this.authorId,
      this.nickName,
      this.clientAuth,
      this.userUrl,
      this.jumpUrl,
      this.coverImage,
      this.identityType,
      this.identityTypeName,
      this.tag,
      this.userTags});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
        authorId: json['authorId'],
        nickName: json['nickName'],
        clientAuth: json['clientAuth'],
        userUrl: json['userUrl'],
        jumpUrl: json['jumpUrl'],
        coverImage: CoverImage.fromJson(json['coverImage']),
        identityType: json['identityType'],
        identityTypeName: json['identityTypeName'],
        tag: json['tag']);
  }
}

class CoverImage {
  final String dynamicUrl;
  final String originalUrl;
  CoverImage({this.dynamicUrl, this.originalUrl});
  factory CoverImage.fromJson(Map<String, dynamic> json) {
    return CoverImage(
        dynamicUrl: json['dynamicUrl'], originalUrl: json['originalUrl']);
  }
}

class Images {
  final int imageId;
  final String dynamicUrl;
  final String originalUrl;
  final double width;
  final double height;

  Images(
      {this.imageId,
      this.dynamicUrl,
      this.originalUrl,
      this.width,
      this.height});
  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
        imageId: json['imageId'],
        dynamicUrl: json['dynamicUrl'],
        originalUrl: json['originalUrl'],
        width: json['width'],
        height: json['height']);
  }
}

class Urls {
  final String version;
  final String appUrl;
  final String h5Url;
  final String wxUrl;
  Urls({this.version, this.appUrl, this.h5Url, this.wxUrl});
  factory Urls.fromJson(Map<String, dynamic> json) {
    return Urls(
        version: json['version'],
        appUrl: json['appUrl'],
        h5Url: json['h5Url'],
        wxUrl: json['wxUrl']);
  }
}

class UserTags {
  final int tagType;
  final String tagName;
  final String tagDesc;
  final String appUrl;
  final String h5Url;
  final String wxUrl;
  UserTags(
      {this.tagType,
      this.tagName,
      this.tagDesc,
      this.appUrl,
      this.h5Url,
      this.wxUrl});
  factory UserTags.fromJson(Map<String, dynamic> json) {
    return UserTags(
        tagType: json['tagType'],
        tagName: json['tagName'],
        tagDesc: json['tagDesc'],
        appUrl: json['appUrl'],
        h5Url: json['h5Url'],
        wxUrl: json['wxUrl']);
  }
}

class Pois {
  final String poiName;
  final PoiExt poiExt;

  Pois({this.poiName, this.poiExt});
  factory Pois.fromJson(Map<String, dynamic> json) {
    return Pois(
        poiName: json['poiName'], poiExt: PoiExt.fromJson(json['poiExt']));
  }
}

class PoiExt {
  final String h5Url;
  final String appUrl;

  PoiExt({this.h5Url, this.appUrl});
  factory PoiExt.fromJson(Map<String, dynamic> json) {
    return PoiExt(h5Url: json['h5Url'], appUrl: json['appUrl']);
  }
}
