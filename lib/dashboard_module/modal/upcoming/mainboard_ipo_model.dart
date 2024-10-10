class MainboardIpoModel {
  MainboardIpoModel({
    this.active,
    this.listed,
  });

  MainboardIpoModel.fromJson(dynamic json) {
    if (json['active'] != null) {
      active = [];
      json['active'].forEach((v) {
        active?.add(Active.fromJson(v));
      });
    }
    if (json['listed'] != null) {
      listed = [];
      json['listed'].forEach((v) {
        listed?.add(Listed.fromJson(v));
      });
    }
  }
  List<Active>? active;
  List<Listed>? listed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (active != null) {
      map['active'] = active?.map((v) => v.toJson()).toList();
    }
    if (listed != null) {
      map['listed'] = listed?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Listed {
  Listed({
    this.additionalTxt,
    this.isSme,
    this.searchId,
    this.symbol,
    this.growwShortName,
    this.biddingStartDate,
    this.dailyStartTime,
    this.listingDate,
    this.minPrice,
    this.maxPrice,
    this.documentUrl,
    this.issuePrice,
    this.listingGains,
    this.listingPrice,
    this.logoUrl,
  });

  Listed.fromJson(dynamic json) {
    additionalTxt = json['additionalTxt'];
    isSme = json['isSme'];
    searchId = json['searchId'];
    symbol = json['symbol'];
    growwShortName = json['growwShortName'];
    biddingStartDate = json['biddingStartDate'];
    dailyStartTime = json['dailyStartTime'];
    listingDate = json['listingDate'];
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];
    documentUrl = json['documentUrl'];
    issuePrice = json['issuePrice'];
    listingGains = json['listingGains'];
    listingPrice = json['listingPrice'];
    logoUrl = json['logoUrl'];
  }
  String? additionalTxt;
  bool? isSme;
  String? searchId;
  String? symbol;
  String? growwShortName;
  String? biddingStartDate;
  String? dailyStartTime;
  String? listingDate;
  String? minPrice;
  String? maxPrice;
  String? documentUrl;
  String? issuePrice;
  String? listingGains;
  String? listingPrice;
  String? logoUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['additionalTxt'] = additionalTxt;
    map['isSme'] = isSme;
    map['searchId'] = searchId;
    map['symbol'] = symbol;
    map['growwShortName'] = growwShortName;
    map['biddingStartDate'] = biddingStartDate;
    map['dailyStartTime'] = dailyStartTime;
    map['listingDate'] = listingDate;
    map['minPrice'] = minPrice;
    map['maxPrice'] = maxPrice;
    map['documentUrl'] = documentUrl;
    map['issuePrice'] = issuePrice;
    map['listingGains'] = listingGains;
    map['listingPrice'] = listingPrice;
    map['logoUrl'] = logoUrl;
    return map;
  }
}

class Active {
  Active({
    this.additionalTxt,
    this.isSme,
    this.searchId,
    this.symbol,
    this.growwShortName,
    this.biddingStartDate,
    this.biddingEndDate,
    this.lastBidPlaceTime,
    this.minPrice,
    this.maxPrice,
    this.preApplyOpen,
    this.categories,
    this.isin,
    this.lotSize,
    this.minBidQuantity,
    this.listingDate,
    this.tickSize,
    this.logoUrl,
  });

  Active.fromJson(dynamic json) {
    additionalTxt = json['additionalTxt'];
    isSme = json['isSme'];
    searchId = json['searchId'];
    symbol = json['symbol'];
    growwShortName = json['growwShortName'];
    biddingStartDate = json['biddingStartDate'];
    biddingEndDate = json['biddingEndDate'];
    lastBidPlaceTime = json['lastBidPlaceTime'];
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];
    preApplyOpen = json['preApplyOpen'];
    categories = json['categories'];
    isin = json['isin'];
    listingDate = json['listingDate'];
    lotSize = json['lotSize'];
    minBidQuantity = json['minBidQuantity'];
    tickSize = json['tickSize'];
    logoUrl = json['logoUrl'];
  }
  String? additionalTxt;
  bool? isSme;
  String? searchId;
  String? symbol;
  String? growwShortName;
  String? biddingStartDate;
  String? biddingEndDate;
  String? lastBidPlaceTime;
  String? minPrice;
  String? maxPrice;
  bool? preApplyOpen;
  String? categories;
  String? isin;
  String? listingDate;
  String? lotSize;
  String? minBidQuantity;
  String? tickSize;
  String? logoUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['additionalTxt'] = additionalTxt;
    map['isSme'] = isSme;
    map['searchId'] = searchId;
    map['symbol'] = symbol;
    map['growwShortName'] = growwShortName;
    map['biddingStartDate'] = biddingStartDate;
    map['biddingEndDate'] = biddingEndDate;
    map['lastBidPlaceTime'] = lastBidPlaceTime;
    map['minPrice'] = minPrice;
    map['maxPrice'] = maxPrice;
    map['preApplyOpen'] = preApplyOpen;
    map['categories'] = categories;
    map['isin'] = isin;
    map['lotSize'] = lotSize;
    map['minBidQuantity'] = minBidQuantity;
    map['tickSize'] = tickSize;
    map['listingDate'] = listingDate;
    map['logoUrl'] = logoUrl;
    return map;
  }
}
