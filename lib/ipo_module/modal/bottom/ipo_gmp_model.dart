class IpoGmpModel {
  IpoGmpModel({
    this.success,
    this.data,
  });

  IpoGmpModel.fromJson(dynamic json) {
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
    this.price,
    this.gmp,
    this.estListing,
    this.ipoSize,
    this.lot,
    this.open,
    this.close,
    this.boaDate,
    this.listing,
    this.updatedAt,
    this.href,
  });

  Data.fromJson(dynamic json) {
    companyName = json['companyName'];
    price = json['price'];
    gmp = json['gmp'];
    estListing = json['estListing'];
    ipoSize = json['ipoSize'];
    lot = json['lot'];
    open = json['open'];
    close = json['close'];
    boaDate = json['boaDate'];
    listing = json['listing'];
    updatedAt = json['updatedAt'];
    href = json['href'];
  }
  String? companyName;
  String? price;
  String? gmp;
  String? estListing;
  String? ipoSize;
  String? lot;
  String? open;
  String? close;
  String? boaDate;
  String? listing;
  String? updatedAt;
  String? href;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['companyName'] = companyName;
    map['price'] = price;
    map['gmp'] = gmp;
    map['estListing'] = estListing;
    map['ipoSize'] = ipoSize;
    map['lot'] = lot;
    map['open'] = open;
    map['close'] = close;
    map['boaDate'] = boaDate;
    map['listing'] = listing;
    map['updatedAt'] = updatedAt;
    map['href'] = href;
    return map;
  }
}
