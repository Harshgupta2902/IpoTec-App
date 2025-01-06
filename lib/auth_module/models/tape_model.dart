class TapeModel {
  TapeModel({
      this.success, 
      this.data,});

  TapeModel.fromJson(dynamic json) {
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
      this.price, 
      this.symbol, 
      this.dayChange, 
      this.dayChangePerc,});

  Data.fromJson(dynamic json) {
    price = json['price'];
    symbol = json['symbol'];
    dayChange = json['dayChange'];
    dayChangePerc = json['dayChangePerc'];
  }
  num? price;
  String? symbol;
  num? dayChange;
  num? dayChangePerc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = price;
    map['symbol'] = symbol;
    map['dayChange'] = dayChange;
    map['dayChangePerc'] = dayChangePerc;
    return map;
  }

}