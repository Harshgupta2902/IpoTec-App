class MfGainersModel {
  MfGainersModel({
    this.success,
    this.data,
    this.message,
  });

  MfGainersModel.fromJson(dynamic json) {
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
    this.mfId,
    this.slug,
    this.name,
    this.sector,
    this.option,
    this.amcCode,
    this.ret1y,
    this.subsector,
    this.sid,
    this.isin,
    this.ticker,
    this.wpct,
  });

  Data.fromJson(dynamic json) {
    mfId = json['mfId'];
    slug = json['slug'];
    name = json['name'];
    sector = json['sector'];
    option = json['option'];
    amcCode = json['amcCode'];
    ret1y = json['ret1y'];
    subsector = json['subsector'];

    sid = json['sid'];
    isin = json['isin'];
    ticker = json['ticker'];
    wpct = json['52wpct'];
  }
  String? mfId;
  String? slug;
  String? name;
  String? sector;
  String? option;
  String? amcCode;
  num? ret1y;
  String? subsector;

  String? sid;
  String? isin;
  String? ticker;
  num? wpct;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mfId'] = mfId;
    map['slug'] = slug;
    map['name'] = name;
    map['sector'] = sector;
    map['option'] = option;
    map['amcCode'] = amcCode;
    map['ret1y'] = ret1y;
    map['subsector'] = subsector;

    map['sid'] = sid;
    map['isin'] = isin;
    map['ticker'] = ticker;
    map['52wpct'] = wpct;
    return map;
  }
}
