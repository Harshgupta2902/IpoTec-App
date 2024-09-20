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
          upcoming?.add(Active.fromJson(v));
        });
      }
    } catch (e) {
      debugPrint("MainBoard Model: $e");
    }
  }
  List<Active>? active;
  List<Listed>? listed;
  List<Closed>? closed;
  List<Active>? upcoming;

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
    try {
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
    } on Exception catch (e) {
      debugPrint("MainBoRd ipo model :=> Closed :=> $e");
    }
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
    try {
      additionalTxt = json['additionalTxt'];
      isSme = json['isSme'];
      logoUrl = json['logoUrl'];
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
    } on Exception catch (e) {
      debugPrint("MainBoRd ipo model :=> Listed :=> $e");
    }
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
  num? issuePrice;
  num? listingGains;
  num? listingPrice;
  String? logoUrl;

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
    this.isin,
    this.lotSize,
    this.minBidQuantity,
    this.tickSize,
    this.listingDate,
    this.documentUrl,
    this.logoUrl,
  });

  Active.fromJson(dynamic json) {
    try {
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
      isin = json['isin'];
      lotSize = json['lotSize'];
      minBidQuantity = json['minBidQuantity'];
      tickSize = json['tickSize'];
      documentUrl = json['documentUrl'];
      listingDate = json['listingDate'];
      logoUrl = json['logoUrl'];
    } on Exception catch (e) {
      debugPrint("MainBoRd ipo model :=> Active :=> $e");
    }
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
  String? isin;
  num? lotSize;
  num? minBidQuantity;
  num? tickSize;
  String? documentUrl;
  String? listingDate;
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
    map['isin'] = isin;
    map['lotSize'] = lotSize;
    map['minBidQuantity'] = minBidQuantity;
    map['tickSize'] = tickSize;
    map['listingDate'] = listingDate;
    map['documentUrl'] = documentUrl;
    map['logoUrl'] = logoUrl;

    return map;
  }
}
