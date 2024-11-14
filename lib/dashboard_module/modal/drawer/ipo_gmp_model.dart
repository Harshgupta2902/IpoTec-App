class IpoGmpModel {
  IpoGmpModel({
      this.gmp,});

  IpoGmpModel.fromJson(dynamic json) {
    if (json['gmp'] != null) {
      gmp = [];
      json['gmp'].forEach((v) {
        gmp?.add(Gmp.fromJson(v));
      });
    }
  }
  List<Gmp>? gmp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (gmp != null) {
      map['gmp'] = gmp?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Gmp {
  Gmp({
      this.ipoName, 
      this.badge, 
      this.ipoPrice, 
      this.gmp, 
      this.listing, 
      this.ipoSize, 
      this.lotSize, 
      this.lot, 
      this.open, 
      this.close, 
      this.updatedOn,});

  Gmp.fromJson(dynamic json) {
    ipoName = json['ipo_name'];
    badge = json['badge'];
    ipoPrice = json['ipo_price'];
    gmp = json['gmp'];
    listing = json['listing'];
    ipoSize = json['ipo_size'];
    lotSize = json['lot_size'];
    lot = json['lot'];
    open = json['open'];
    close = json['close'];
    updatedOn = json['updated_on'];
  }
  String? ipoName;
  String? badge;
  String? ipoPrice;
  String? gmp;
  String? listing;
  String? ipoSize;
  String? lotSize;
  String? lot;
  String? open;
  String? close;
  String? updatedOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ipo_name'] = ipoName;
    map['badge'] = badge;
    map['ipo_price'] = ipoPrice;
    map['gmp'] = gmp;
    map['listing'] = listing;
    map['ipo_size'] = ipoSize;
    map['lot_size'] = lotSize;
    map['lot'] = lot;
    map['open'] = open;
    map['close'] = close;
    map['updated_on'] = updatedOn;
    return map;
  }

}