class SearchModel {
  SearchModel({
      this.success, 
      this.data, 
      this.message,});

  SearchModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }
  bool? success;
  List<Data>? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }

}

class Data {
  Data({
      this.marketCap, 
      this.ticker, 
      this.name, 
      this.type, 
      this.sector, 
      this.slug, 
      this.sid, 
      this.match, 
      this.quote,});

  Data.fromJson(dynamic json) {
    marketCap = json['marketCap'];
    ticker = json['ticker'];
    name = json['name'];
    type = json['type'];
    sector = json['sector'];
    slug = json['slug'];
    sid = json['sid'];
    match = json['match'];
    quote = json['quote'] != null ? Quote.fromJson(json['quote']) : null;
  }
  num? marketCap;
  String? ticker;
  String? name;
  String? type;
  String? sector;
  String? slug;
  String? sid;
  String? match;
  Quote? quote;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['marketCap'] = marketCap;
    map['ticker'] = ticker;
    map['name'] = name;
    map['type'] = type;
    map['sector'] = sector;
    map['slug'] = slug;
    map['sid'] = sid;
    map['match'] = match;
    if (quote != null) {
      map['quote'] = quote?.toJson();
    }
    return map;
  }

}

class Quote {
  Quote({
      this.sid, 
      this.price, 
      this.close, 
      this.change, 
      this.high, 
      this.low, 
      this.volume, 
      this.date,});

  Quote.fromJson(dynamic json) {
    sid = json['sid'];
    price = json['price'];
    close = json['close'];
    change = json['change'];
    high = json['high'];
    low = json['low'];
    volume = json['volume'];
    date = json['date'];
  }
  String? sid;
  num? price;
  num? close;
  num? change;
  num? high;
  num? low;
  num? volume;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sid'] = sid;
    map['price'] = price;
    map['close'] = close;
    map['change'] = change;
    map['high'] = high;
    map['low'] = low;
    map['volume'] = volume;
    map['date'] = date;
    return map;
  }

}