class BuybackIpoModel {
  BuybackIpoModel({
    this.expired,
    this.closed,
    this.active,
    this.cancelled,
    this.upcoming,
  });

  BuybackIpoModel.fromJson(dynamic json) {
    if (json['EXPIRED'] != null) {
      expired = [];
      json['EXPIRED'].forEach((v) {
        expired?.add(Data.fromJson(v));
      });
    }
    if (json['CLOSED'] != null) {
      closed = [];
      json['CLOSED'].forEach((v) {
        closed?.add(Data.fromJson(v));
      });
    }
    if (json['ACTIVE'] != null) {
      active = [];
      json['ACTIVE'].forEach((v) {
        active?.add(Data.fromJson(v));
      });
    }
    if (json['CANCELLED'] != null) {
      cancelled = [];
      json['CANCELLED'].forEach((v) {
        cancelled?.add(Data.fromJson(v));
      });
    }
    if (json['UPCOMING'] != null) {
      upcoming = [];
      json['UPCOMING'].forEach((v) {
        upcoming?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? expired;
  List<Data>? closed;
  List<Data>? active;
  List<Data>? cancelled;
  List<Data>? upcoming;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (expired != null) {
      map['EXPIRED'] = expired?.map((v) => v.toJson()).toList();
    }
    if (closed != null) {
      map['CLOSED'] = closed?.map((v) => v.toJson()).toList();
    }
    if (active != null) {
      map['ACTIVE'] = active?.map((v) => v.toJson()).toList();
    }
    if (cancelled != null) {
      map['CANCELLED'] = cancelled?.map((v) => v.toJson()).toList();
    }
    if (upcoming != null) {
      map['UPCOMING'] = upcoming?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.buyBackId,
    this.symbolIsin,
    this.recordDate,
    this.startDate,
    this.endDate,
    this.offerPrice,
    this.status,
    this.exchange,
    this.issuedAmount,
    this.issuedShares,
    this.companyName,
    this.companyShortName,
    this.companyLogo,
    this.searchId,
    this.settlementNumber,
    this.settlementId,
    this.clearingMember,
    this.settlementDate,
    this.message,
    this.companySymbol,
    this.scripCode,
  });

  Data.fromJson(dynamic json) {
    buyBackId = json['buyBackId'];
    symbolIsin = json['symbolIsin'];
    recordDate = json['recordDate'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    offerPrice = json['offerPrice'];
    status = json['status'];
    exchange = json['exchange'];
    issuedAmount = json['issuedAmount'];
    issuedShares = json['issuedShares'];
    companyName = json['companyName'];
    companyShortName = json['companyShortName'];
    companyLogo = json['companyLogo'];
    searchId = json['searchId'];
    settlementNumber = json['settlementNumber'];
    settlementId = json['settlementId'];
    clearingMember = json['clearingMember'];
    settlementDate = json['settlementDate'];
    message = json['message'];
    companySymbol = json['companySymbol'];
    scripCode = json['scripCode'];
  }
  String? buyBackId;
  String? symbolIsin;
  String? recordDate;
  String? startDate;
  String? endDate;
  num? offerPrice;
  String? status;
  String? exchange;
  String? issuedAmount;
  String? issuedShares;
  String? companyName;
  String? companyShortName;
  String? companyLogo;
  String? searchId;
  String? settlementNumber;
  String? settlementId;
  String? clearingMember;
  String? settlementDate;
  dynamic message;
  dynamic companySymbol;
  dynamic scripCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['buyBackId'] = buyBackId;
    map['symbolIsin'] = symbolIsin;
    map['recordDate'] = recordDate;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['offerPrice'] = offerPrice;
    map['status'] = status;
    map['exchange'] = exchange;
    map['issuedAmount'] = issuedAmount;
    map['issuedShares'] = issuedShares;
    map['companyName'] = companyName;
    map['companyShortName'] = companyShortName;
    map['companyLogo'] = companyLogo;
    map['searchId'] = searchId;
    map['settlementNumber'] = settlementNumber;
    map['settlementId'] = settlementId;
    map['clearingMember'] = clearingMember;
    map['settlementDate'] = settlementDate;
    map['message'] = message;
    map['companySymbol'] = companySymbol;
    map['scripCode'] = scripCode;
    return map;
  }
}
