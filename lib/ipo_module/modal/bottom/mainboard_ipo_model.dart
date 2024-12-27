class MainboardIpoModel {
  MainboardIpoModel({
    this.success,
    this.data,
  });

  MainboardIpoModel.fromJson(dynamic json) {
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
    this.companyName,
    this.href,
    this.open,
    this.close,
    this.listing,
    this.price,
    this.size,
    this.lot,
    this.exchange,
  });

  Data.fromJson(dynamic json) {
    companyName = json['companyName'];
    href = json['href'];
    open = json['open'];
    close = json['close'];
    listing = json['listing'];
    price = json['price'];
    size = json['size'];
    lot = json['lot'];
    exchange = json['exchange'] != null ? json['exchange'].cast<String>() : [];
  }
  String? companyName;
  String? href;
  String? open;
  String? close;
  String? listing;
  String? price;
  String? size;
  String? lot;
  List<String>? exchange;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['companyName'] = companyName;
    map['href'] = href;
    map['open'] = open;
    map['close'] = close;
    map['listing'] = listing;
    map['price'] = price;
    map['size'] = size;
    map['lot'] = lot;
    map['exchange'] = exchange;
    return map;
  }
}
