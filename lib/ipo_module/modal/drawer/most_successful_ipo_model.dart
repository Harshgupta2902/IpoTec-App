class MostSuccessfulIpoModel {
  MostSuccessfulIpoModel({
    this.head,
    this.body,
    this.isNextPage,
    this.totalCount,
  });

  MostSuccessfulIpoModel.fromJson(dynamic json) {
    head = json['head'] != null ? Head.fromJson(json['head']) : null;
    if (json['body'] != null) {
      body = [];
      json['body'].forEach((v) {
        body?.add(Body.fromJson(v));
      });
    }
    isNextPage = json['isNextPage'];
    totalCount = json['totalCount'];
  }
  Head? head;
  List<Body>? body;
  bool? isNextPage;
  num? totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (head != null) {
      map['head'] = head?.toJson();
    }
    if (body != null) {
      map['body'] = body?.map((v) => v.toJson()).toList();
    }
    map['isNextPage'] = isNextPage;
    map['totalCount'] = totalCount;
    return map;
  }
}

class Body {
  Body({
    this.companyName,
    this.ipoId,
    this.companySlugName,
    this.stockPageUrl,
    this.stockCode,
    this.isin,
    this.listingDate,
    this.issueSize,
    this.issuePrice,
    this.qib,
    this.hni,
    this.retail,
    this.totalSubscription,
    this.listingOpenPrice,
    this.listingClosePrice,
    this.listingGainP,
    this.currentPrice,
    this.currentGainP,
    this.isSme,
    this.mcapQ,
  });

  Body.fromJson(dynamic json) {
    companyName = json['company_name'];
    ipoId = json['ipo_id'];
    companySlugName = json['company_slug_name'];
    stockPageUrl = json['stock_page_url'];
    stockCode = json['stock_code'];
    isin = json['isin'];
    listingDate = json['listing_date'];
    issueSize = json['issue_size'];
    issuePrice = json['issue_price'];
    qib = json['qib'];
    hni = json['hni'];
    retail = json['retail'];
    totalSubscription = json['total_subscription'];
    listingOpenPrice = json['listing_open_price'];
    listingClosePrice = json['listing_close_price'];
    listingGainP = json['listing_gainP'];
    currentPrice = json['current_price'];
    currentGainP = json['current_gainP'];
    isSme = json['is_sme'];
    mcapQ = json['mcap_q'];
  }
  String? companyName;
  num? ipoId;
  String? companySlugName;
  String? stockPageUrl;
  String? stockCode;
  String? isin;
  String? listingDate;
  num? issueSize;
  num? issuePrice;
  dynamic qib;
  num? hni;
  num? retail;
  num? totalSubscription;
  num? listingOpenPrice;
  num? listingClosePrice;
  num? listingGainP;
  num? currentPrice;
  num? currentGainP;
  bool? isSme;
  num? mcapQ;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['company_name'] = companyName;
    map['ipo_id'] = ipoId;
    map['company_slug_name'] = companySlugName;
    map['stock_page_url'] = stockPageUrl;
    map['stock_code'] = stockCode;
    map['isin'] = isin;
    map['listing_date'] = listingDate;
    map['issue_size'] = issueSize;
    map['issue_price'] = issuePrice;
    map['qib'] = qib;
    map['hni'] = hni;
    map['retail'] = retail;
    map['total_subscription'] = totalSubscription;
    map['listing_open_price'] = listingOpenPrice;
    map['listing_close_price'] = listingClosePrice;
    map['listing_gainP'] = listingGainP;
    map['current_price'] = currentPrice;
    map['current_gainP'] = currentGainP;
    map['is_sme'] = isSme;
    map['mcap_q'] = mcapQ;
    return map;
  }
}

class Head {
  Head({
    this.status,
    this.statusDescription,
    this.thisPageNumber,
    this.responseCode,
  });

  Head.fromJson(dynamic json) {
    status = json['status'];
    statusDescription = json['statusDescription'];
    thisPageNumber = json['thisPageNumber'];
    responseCode = json['responseCode'];
  }
  num? status;
  String? statusDescription;
  num? thisPageNumber;
  dynamic responseCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['statusDescription'] = statusDescription;
    map['thisPageNumber'] = thisPageNumber;
    map['responseCode'] = responseCode;
    return map;
  }
}
