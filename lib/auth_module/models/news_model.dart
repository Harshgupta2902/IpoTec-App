class NewsModel {
  NewsModel({
    this.success,
    this.data,
  });

  NewsModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.type,
    this.title,
    this.desc,
    this.date,
    this.imageUrl,
    this.link,
    this.publisher,
    this.sid,
    this.initialPrice,
    this.price,
    this.close,
    this.slug,
    this.ticker,
    this.tag,
  });

  Data.fromJson(dynamic json) {
    type = json['type'];
    title = json['title'];
    desc = json['desc'];
    date = json['date'];
    imageUrl = json['imageUrl'];
    link = json['link'];
    publisher = json['publisher'];
    sid = json['sid'];
    initialPrice = json['initialPrice'];
    price = json['price'];
    close = json['close'];
    slug = json['slug'];
    ticker = json['ticker'];
    tag = json['tag'];
  }
  String? type;
  String? title;
  String? desc;
  String? date;
  String? imageUrl;
  String? link;
  String? publisher;
  String? sid;
  num? initialPrice;
  num? price;
  num? close;
  String? slug;
  String? ticker;
  String? tag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['title'] = title;
    map['desc'] = desc;
    map['date'] = date;
    map['imageUrl'] = imageUrl;
    map['link'] = link;
    map['publisher'] = publisher;
    map['sid'] = sid;
    map['initialPrice'] = initialPrice;
    map['price'] = price;
    map['close'] = close;
    map['slug'] = slug;
    map['ticker'] = ticker;
    map['tag'] = tag;
    return map;
  }
}
