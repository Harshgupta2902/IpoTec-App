class IpoDetailsModel {
  IpoDetailsModel({
    this.data,
    this.financials,
  });

  IpoDetailsModel.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['financials'] != null) {
      financials = [];
      json['financials'].forEach((v) {
        financials?.add(Financials.fromJson(v));
      });
    }
  }
  Data? data;
  List<Financials>? financials;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (financials != null) {
      map['financials'] = financials?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Financials {
  Financials({
    this.title,
    this.yearly,
  });

  Financials.fromJson(dynamic json) {
    title = json['title'];
    if (json['yearly'] != null) {
      yearly = [];
      json['yearly'].forEach((v) {
        yearly?.add(Yearly.fromJson(v));
      });
    }
  }
  String? title;
  List<Yearly>? yearly;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    if (yearly != null) {
      map['yearly'] = yearly?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Yearly {
  Yearly({
    this.year,
    this.value,
  });

  Yearly.fromJson(dynamic json) {
    year = json['year'];
    value = json['value'];
  }
  num? year;
  num? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['year'] = year;
    map['value'] = value;
    return map;
  }
}

class Data {
  Data({
    this.categories,
    this.symbol,
    this.bannerText,
    this.aboutCompany,
    this.companyName,
    this.companyShortName,
    this.pros,
    this.cons,
    this.lotSize,
    this.minPrice,
    this.maxPrice,
    this.startDate,
    this.endDate,
    this.minBidQty,
    this.issueSize,
    this.listing,
    this.issuePrice,
    this.parentSearchId,
    this.subscriptionUpdatedAt,
    this.documentUrl,
    this.logoUrl,
    this.videoId,
    this.videoName,
    this.subscriptionRates,
    this.sector,
    this.faqs,
    this.listingDate,
    this.faceValue,
    this.tickSize,
    this.cutOffPrice,
    this.isin,
    this.registrar,
    this.t1ModStartDate,
    this.t1ModEndDate,
    this.t1ModStartTime,
    this.t1ModEndTime,
    this.issueType,
    this.status,
    this.dailyStartTime,
    this.dailyEndTime,
    this.lastBidPlaceTime,
    this.applicationDetails,
    this.peerList,
    this.ppContent,
    this.rtaLink,
    this.isAllotmentAnnounced,
    this.preApplyOpen,
    this.minBidQuantity,
    this.growwShortName,
  });

  Data.fromJson(dynamic json) {
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
    symbol = json['symbol'];
    bannerText = json['bannerText'];
    aboutCompany =
        json['aboutCompany'] != null ? AboutCompany.fromJson(json['aboutCompany']) : null;
    companyName = json['companyName'];
    companyShortName = json['companyShortName'];
    pros = json['pros'] != null ? json['pros'].cast<String>() : [];
    cons = json['cons'] != null ? json['cons'].cast<String>() : [];
    lotSize = json['lotSize'];
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    minBidQty = json['minBidQty'];
    issueSize = json['issueSize'];
    listing = Listing.fromJson(json['listing']);
    issuePrice = json['issuePrice'];
    parentSearchId = json['parentSearchId'];
    subscriptionUpdatedAt = json['subscriptionUpdatedAt'];
    documentUrl = json['documentUrl'];
    logoUrl = json['logoUrl'];
    videoId = json['videoId'];
    videoName = json['videoName'];
    subscriptionRates = json['subscriptionRates'];
    sector = json['sector'];
    if (json['faqs'] != null) {
      faqs = [];
      json['faqs'].forEach((v) {
        faqs?.add(Faqs.fromJson(v));
      });
    }
    listingDate = json['listingDate'];
    faceValue = json['faceValue'];
    tickSize = json['tickSize'];
    cutOffPrice = json['cutOffPrice'];
    isin = json['isin'];
    registrar = json['registrar'];
    t1ModStartDate = json['t1ModStartDate'];
    t1ModEndDate = json['t1ModEndDate'];
    t1ModStartTime = json['t1ModStartTime'];
    t1ModEndTime = json['t1ModEndTime'];
    issueType = json['issueType'];
    status = json['status'];
    dailyStartTime = json['dailyStartTime'];
    dailyEndTime = json['dailyEndTime'];
    lastBidPlaceTime = json['lastBidPlaceTime'];
    applicationDetails = json['applicationDetails'];
    peerList = json['peerList'];
    ppContent = json['ppContent'];
    rtaLink = json['rtaLink'];
    isAllotmentAnnounced = json['isAllotmentAnnounced'];
    preApplyOpen = json['preApplyOpen'];
    minBidQuantity = json['minBidQuantity'];
    growwShortName = json['growwShortName'];
  }
  List<Categories>? categories;
  String? symbol;
  String? bannerText;
  AboutCompany? aboutCompany;
  String? companyName;
  String? companyShortName;
  List<String>? pros;
  List<String>? cons;
  num? lotSize;
  num? minPrice;
  num? maxPrice;
  String? startDate;
  String? endDate;
  num? minBidQty;
  num? issueSize;
  Listing? listing;
  num? issuePrice;
  dynamic parentSearchId;
  dynamic subscriptionUpdatedAt;
  String? documentUrl;
  dynamic logoUrl;
  String? videoId;
  dynamic videoName;
  dynamic subscriptionRates;
  String? sector;
  List<Faqs>? faqs;
  String? listingDate;
  num? faceValue;
  num? tickSize;
  dynamic cutOffPrice;
  String? isin;
  String? registrar;
  dynamic t1ModStartDate;
  dynamic t1ModEndDate;
  dynamic t1ModStartTime;
  dynamic t1ModEndTime;
  String? issueType;
  String? status;
  String? dailyStartTime;
  String? dailyEndTime;
  String? lastBidPlaceTime;
  String? applicationDetails;
  dynamic peerList;
  dynamic ppContent;
  String? rtaLink;
  bool? isAllotmentAnnounced;
  bool? preApplyOpen;
  num? minBidQuantity;
  String? growwShortName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    map['symbol'] = symbol;
    map['bannerText'] = bannerText;
    if (aboutCompany != null) {
      map['aboutCompany'] = aboutCompany?.toJson();
    }
    map['companyName'] = companyName;
    map['companyShortName'] = companyShortName;
    map['pros'] = pros;
    map['cons'] = cons;
    map['lotSize'] = lotSize;
    map['minPrice'] = minPrice;
    map['maxPrice'] = maxPrice;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['minBidQty'] = minBidQty;
    map['issueSize'] = issueSize;
    map['listing'] = listing;
    map['issuePrice'] = issuePrice;
    map['parentSearchId'] = parentSearchId;
    map['subscriptionUpdatedAt'] = subscriptionUpdatedAt;
    map['documentUrl'] = documentUrl;
    map['logoUrl'] = logoUrl;
    map['videoId'] = videoId;
    map['videoName'] = videoName;
    map['subscriptionRates'] = subscriptionRates;
    map['sector'] = sector;
    if (faqs != null) {
      map['faqs'] = faqs?.map((v) => v.toJson()).toList();
    }
    map['listingDate'] = listingDate;
    map['faceValue'] = faceValue;
    map['tickSize'] = tickSize;
    map['cutOffPrice'] = cutOffPrice;
    map['isin'] = isin;
    map['registrar'] = registrar;
    map['t1ModStartDate'] = t1ModStartDate;
    map['t1ModEndDate'] = t1ModEndDate;
    map['t1ModStartTime'] = t1ModStartTime;
    map['t1ModEndTime'] = t1ModEndTime;
    map['issueType'] = issueType;
    map['status'] = status;
    map['dailyStartTime'] = dailyStartTime;
    map['dailyEndTime'] = dailyEndTime;
    map['lastBidPlaceTime'] = lastBidPlaceTime;
    map['applicationDetails'] = applicationDetails;
    map['peerList'] = peerList;
    map['ppContent'] = ppContent;
    map['rtaLink'] = rtaLink;
    map['isAllotmentAnnounced'] = isAllotmentAnnounced;
    map['preApplyOpen'] = preApplyOpen;
    map['minBidQuantity'] = minBidQuantity;
    map['growwShortName'] = growwShortName;
    return map;
  }
}

class Faqs {
  Faqs({
    this.question,
    this.answer,
  });

  Faqs.fromJson(dynamic json) {
    question = json['question'];
    answer = json['answer'];
  }
  String? question;
  String? answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = question;
    map['answer'] = answer;
    return map;
  }
}

class Listing {
  Listing({
    this.listingPrice,
    this.listedOn,
    this.bseScripCode,
    this.nseScripCode,
  });

  Listing.fromJson(dynamic json) {
    listingPrice = json['listingPrice'];
    listedOn = json['listedOn'] != null ? json['listedOn'].cast<String>() : [];
    bseScripCode = json['bseScripCode'];
    nseScripCode = json['nseScripCode'];
  }
  dynamic listingPrice;
  List<String>? listedOn;
  dynamic bseScripCode;
  dynamic nseScripCode;
}

// class Listing {
//   Listing({
//     this.listingPrice,
//     this.listedOn,
//     this.bseScripCode,
//     this.nseScripCode,
//   });
//
//   Listing.fromJson(dynamic json) {
//     listingPrice = json['listingPrice'];
//     if (json['listedOn'] != null) {
//       listedOn = [];
//       json['listedOn'].forEach((v) {
//         listedOn?.add(Dynamic.fromJson(v));
//       });
//     }
//     bseScripCode = json['bseScripCode'];
//     nseScripCode = json['nseScripCode'];
//   }
//   dynamic listingPrice;
//   List<String>? listedOn;
//   dynamic bseScripCode;
//   dynamic nseScripCode;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['listingPrice'] = listingPrice;
//     if (listedOn != null) {
//       map['listedOn'] = listedOn?.map((v) => v.toJson()).toList();
//     }
//     map['bseScripCode'] = bseScripCode;
//     map['nseScripCode'] = nseScripCode;
//     return map;
//   }
// }

class AboutCompany {
  AboutCompany({
    this.yearFounded,
    this.managingDirector,
    this.aboutCompany,
  });

  AboutCompany.fromJson(dynamic json) {
    yearFounded = json['yearFounded'];
    managingDirector = json['managingDirector'];
    aboutCompany = json['aboutCompany'];
  }
  String? yearFounded;
  String? managingDirector;
  String? aboutCompany;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['yearFounded'] = yearFounded;
    map['managingDirector'] = managingDirector;
    map['aboutCompany'] = aboutCompany;
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
