class IpoGmpModel {
  IpoGmpModel({
    this.gmp,
  });

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
    this.companyName,
    this.link,
    this.type,
    this.ipoGmp,
    this.price,
    this.gain,
    this.date,
    this.slug,
    this.listingGain,
  });

  Gmp.fromJson(dynamic json) {
    companyName = json['company_name'];
    link = json['link'];
    type = json['type'];
    ipoGmp = json['ipo_gmp'];
    price = json['price'];
    gain = json['gain'];
    date = json['date'];
    slug = json['slug'];
    listingGain = json['listing_gain'];
  }
  String? companyName;
  String? link;
  String? type;
  String? ipoGmp;
  String? price;
  String? gain;
  String? date;
  String? slug;
  String? listingGain;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['company_name'] = companyName;
    map['link'] = link;
    map['type'] = type;
    map['ipo_gmp'] = ipoGmp;
    map['price'] = price;
    map['gain'] = gain;
    map['date'] = date;
    map['slug'] = slug;
    map['listing_gain'] = listingGain;
    return map;
  }
}
