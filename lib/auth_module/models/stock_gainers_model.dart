class StockGainersModel {
  StockGainersModel({
      this.success, 
      this.data, 
      this.message,});

  StockGainersModel.fromJson(dynamic json) {
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
      this.sid, 
      this.name, 
      this.slug, 
      this.sector, 
      this.ticker, 
      this.marketCap, 
      this.price, 
      this.change,});

  Data.fromJson(dynamic json) {
    sid = json['sid'];
    name = json['name'];
    slug = json['slug'];
    sector = json['sector'];
    ticker = json['ticker'];
    marketCap = json['marketCap'];
    price = json['price'];
    change = json['change'];
  }
  String? sid;
  String? name;
  String? slug;
  String? sector;
  String? ticker;
  String? marketCap;
  num? price;
  num? change;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sid'] = sid;
    map['name'] = name;
    map['slug'] = slug;
    map['sector'] = sector;
    map['ticker'] = ticker;
    map['marketCap'] = marketCap;
    map['price'] = price;
    map['change'] = change;
    return map;
  }

}