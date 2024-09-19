import 'package:flutter/material.dart';

class MainboardIpoModal {
  MainboardIpoModal({
    this.active,
    this.listed,
    this.closed,
    this.upcoming,
  });

  MainboardIpoModal.fromJson(dynamic json) {
    try {
      if (json['ACTIVE'] != null) {
        active = [];
        json['ACTIVE'].forEach((v) {
          active?.add(Active.fromJson(v));
        });
      }
      if (json['LISTED'] != null) {
        listed = [];
        json['LISTED'].forEach((v) {
          listed?.add(Listed.fromJson(v));
        });
      }
      if (json['CLOSED'] != null) {
        closed = [];
        json['CLOSED'].forEach((v) {
          closed?.add(Closed.fromJson(v));
        });
      }
      if (json['UPCOMING'] != null) {
        upcoming = [];
        json['UPCOMING'].forEach((v) {
          upcoming?.add(Upcoming.fromJson(v));
        });
      }
    } catch (e) {
      debugPrint("MainBoard Model: $e");
    }
  }
  List<Active>? active;
  List<Listed>? listed;
  List<Closed>? closed;
  List<Upcoming>? upcoming;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (active != null) {
      map['ACTIVE'] = active?.map((v) => v.toJson()).toList();
    }
    if (listed != null) {
      map['LISTED'] = listed?.map((v) => v.toJson()).toList();
    }
    if (closed != null) {
      map['CLOSED'] = closed?.map((v) => v.toJson()).toList();
    }
    if (upcoming != null) {
      map['UPCOMING'] = upcoming?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Upcoming {
  Upcoming({
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
  });

  Upcoming.fromJson(dynamic json) {
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
  }
  String? additionalTxt;
  bool? isSme;
  String? searchId;
  String? symbol;
  String? growwShortName;
  String? biddingStartDate;
  String? dailyStartTime;
  String? listingDate;
  num? minPrice;
  num? maxPrice;
  String? documentUrl;

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
    return map;
  }
}

class Closed {
  Closed({
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
  });

  Closed.fromJson(dynamic json) {
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
  }
  String? additionalTxt;
  bool? isSme;
  String? searchId;
  String? symbol;
  String? growwShortName;
  String? biddingStartDate;
  String? dailyStartTime;
  String? listingDate;
  num? minPrice;
  num? maxPrice;
  String? documentUrl;

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
    return map;
  }
}

class Listed {
  Listed({
    this.additionalTxt,
    this.isSme,
    this.logoUrl,
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
  });

  Listed.fromJson(dynamic json) {
    additionalTxt = json['additionalTxt'];
    isSme = json['isSme'];
    isSme = json['logoUrl'];
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
  }
  String? additionalTxt;
  bool? isSme;
  String? logoUrl;
  String? searchId;
  String? symbol;
  String? growwShortName;
  String? biddingStartDate;
  String? dailyStartTime;
  String? listingDate;
  num? minPrice;
  num? maxPrice;
  String? documentUrl;
  num? issuePrice;
  num? listingGains;
  num? listingPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['additionalTxt'] = additionalTxt;
    map['isSme'] = isSme;
    map['logoUrl'] = isSme;
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
    this.tickSize,
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
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    isin = json['isin'];
    lotSize = json['lotSize'];
    minBidQuantity = json['minBidQuantity'];
    tickSize = json['tickSize'];
  }
  String? additionalTxt;
  bool? isSme;
  String? searchId;
  String? symbol;
  String? growwShortName;
  String? biddingStartDate;
  String? biddingEndDate;
  String? lastBidPlaceTime;
  num? minPrice;
  num? maxPrice;
  bool? preApplyOpen;
  List<Categories>? categories;
  String? isin;
  num? lotSize;
  num? minBidQuantity;
  num? tickSize;

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
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    map['isin'] = isin;
    map['lotSize'] = lotSize;
    map['minBidQuantity'] = minBidQuantity;
    map['tickSize'] = tickSize;
    return map;
  }
}

class Categories {
  Categories({
    this.category,
    this.categoryLabel,
    this.categorySubText,
    this.lotSize,
    this.minBidQuantity,
    this.minPrice,
    this.maxPrice,
    this.subscriptionRate,
    this.state,
    this.categoryDiscount,
    this.isCategoryActive,
    this.cutOffTime,
    this.categoryDetails,
  });

  Categories.fromJson(dynamic json) {
    category = json['category'];
    categoryLabel = json['categoryLabel'];
    categorySubText = json['categorySubText'];
    lotSize = json['lotSize'];
    minBidQuantity = json['minBidQuantity'];
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];
    subscriptionRate = json['subscriptionRate'];
    state = json['state'];
    categoryDiscount = json['categoryDiscount'];
    isCategoryActive = json['isCategoryActive'];
    cutOffTime = json['cutOffTime'];
    categoryDetails =
        json['categoryDetails'] != null ? CategoryDetails.fromJson(json['categoryDetails']) : null;
  }
  String? category;
  String? categoryLabel;
  String? categorySubText;
  num? lotSize;
  num? minBidQuantity;
  num? minPrice;
  num? maxPrice;
  dynamic subscriptionRate;
  String? state;
  num? categoryDiscount;
  bool? isCategoryActive;
  String? cutOffTime;
  CategoryDetails? categoryDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category'] = category;
    map['categoryLabel'] = categoryLabel;
    map['categorySubText'] = categorySubText;
    map['lotSize'] = lotSize;
    map['minBidQuantity'] = minBidQuantity;
    map['minPrice'] = minPrice;
    map['maxPrice'] = maxPrice;
    map['subscriptionRate'] = subscriptionRate;
    map['state'] = state;
    map['categoryDiscount'] = categoryDiscount;
    map['isCategoryActive'] = isCategoryActive;
    map['cutOffTime'] = cutOffTime;
    if (categoryDetails != null) {
      map['categoryDetails'] = categoryDetails?.toJson();
    }
    return map;
  }
}

class CategoryDetails {
  CategoryDetails({
    this.categoryLabel,
    this.categoryInfo,
  });

  CategoryDetails.fromJson(dynamic json) {
    categoryLabel = json['categoryLabel'];
    categoryInfo = json['categoryInfo'] != null ? json['categoryInfo'].cast<String>() : [];
  }
  String? categoryLabel;
  List<String>? categoryInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryLabel'] = categoryLabel;
    map['categoryInfo'] = categoryInfo;
    return map;
  }
}
