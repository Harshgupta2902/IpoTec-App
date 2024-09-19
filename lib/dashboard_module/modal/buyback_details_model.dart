class BuybackDetailsModel {
  BuybackDetailsModel({
    this.mainData,
    this.searchId,
    this.symnolData,
  });

  BuybackDetailsModel.fromJson(dynamic json) {
    mainData = json['mainData'] != null ? MainData.fromJson(json['mainData']) : null;
    searchId = json['searchId'];
    symnolData = json['symnolData'] != null ? SymnolData.fromJson(json['symnolData']) : null;
  }
  MainData? mainData;
  String? searchId;
  SymnolData? symnolData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (mainData != null) {
      map['mainData'] = mainData?.toJson();
    }
    map['searchId'] = searchId;
    if (symnolData != null) {
      map['symnolData'] = symnolData?.toJson();
    }
    return map;
  }
}

class SymnolData {
  SymnolData({
    this.header,
    this.details,
    this.stats,
    this.fundamentals,
    this.priceData,
    this.similarAssets,
  });

  SymnolData.fromJson(dynamic json) {
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    details = json['details'] != null ? Details.fromJson(json['details']) : null;
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
    if (json['fundamentals'] != null) {
      fundamentals = [];
      json['fundamentals'].forEach((v) {
        fundamentals?.add(Fundamentals.fromJson(v));
      });
    }
    priceData = json['priceData'] != null ? PriceData.fromJson(json['priceData']) : null;
    similarAssets =
        json['similarAssets'] != null ? SimilarAssets.fromJson(json['similarAssets']) : null;
  }
  Header? header;
  Details? details;
  Stats? stats;
  List<Fundamentals>? fundamentals;
  PriceData? priceData;
  SimilarAssets? similarAssets;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (header != null) {
      map['header'] = header?.toJson();
    }
    if (details != null) {
      map['details'] = details?.toJson();
    }
    if (stats != null) {
      map['stats'] = stats?.toJson();
    }
    if (fundamentals != null) {
      map['fundamentals'] = fundamentals?.map((v) => v.toJson()).toList();
    }
    if (priceData != null) {
      map['priceData'] = priceData?.toJson();
    }
    if (similarAssets != null) {
      map['similarAssets'] = similarAssets?.toJson();
    }
    return map;
  }
}

class SimilarAssets {
  SimilarAssets({
    this.type,
    this.size,
    this.peerList,
  });

  SimilarAssets.fromJson(dynamic json) {
    type = json['type'];
    size = json['size'];
    if (json['peerList'] != null) {
      peerList = [];
      json['peerList'].forEach((v) {
        peerList?.add(PeerList.fromJson(v));
      });
    }
  }
  String? type;
  num? size;
  List<PeerList>? peerList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['size'] = size;
    if (peerList != null) {
      map['peerList'] = peerList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class PeerList {
  PeerList({
    this.companyHeader,
    this.nseYearLow,
    this.nseYearHigh,
    this.bseYearLow,
    this.bseYearHigh,
    this.marketCap,
    this.peRatio,
    this.pbRatio,
  });

  PeerList.fromJson(dynamic json) {
    companyHeader =
        json['companyHeader'] != null ? CompanyHeader.fromJson(json['companyHeader']) : null;
    nseYearLow = json['nseYearLow'];
    nseYearHigh = json['nseYearHigh'];
    bseYearLow = json['bseYearLow'];
    bseYearHigh = json['bseYearHigh'];
    marketCap = json['marketCap'];
    peRatio = json['peRatio'];
    pbRatio = json['pbRatio'];
  }
  CompanyHeader? companyHeader;
  num? nseYearLow;
  num? nseYearHigh;
  num? bseYearLow;
  num? bseYearHigh;
  num? marketCap;
  num? peRatio;
  num? pbRatio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (companyHeader != null) {
      map['companyHeader'] = companyHeader?.toJson();
    }
    map['nseYearLow'] = nseYearLow;
    map['nseYearHigh'] = nseYearHigh;
    map['bseYearLow'] = bseYearLow;
    map['bseYearHigh'] = bseYearHigh;
    map['marketCap'] = marketCap;
    map['peRatio'] = peRatio;
    map['pbRatio'] = pbRatio;
    return map;
  }
}

class CompanyHeader {
  CompanyHeader({
    this.searchId,
    this.growwCompanyId,
    this.isin,
    this.industryId,
    this.displayName,
    this.shortName,
    this.nseScriptCode,
    this.bseScriptCode,
    this.nseTradingSymbol,
    this.bseTradingSymbol,
    this.isBseTradable,
    this.isNseTradable,
    this.logoUrl,
    this.isBseFnoEnabled,
    this.isNseFnoEnabled,
  });

  CompanyHeader.fromJson(dynamic json) {
    searchId = json['searchId'];
    growwCompanyId = json['growwCompanyId'];
    isin = json['isin'];
    industryId = json['industryId'];
    displayName = json['displayName'];
    shortName = json['shortName'];
    nseScriptCode = json['nseScriptCode'];
    bseScriptCode = json['bseScriptCode'];
    nseTradingSymbol = json['nseTradingSymbol'];
    bseTradingSymbol = json['bseTradingSymbol'];
    isBseTradable = json['isBseTradable'];
    isNseTradable = json['isNseTradable'];
    logoUrl = json['logoUrl'];
    isBseFnoEnabled = json['isBseFnoEnabled'];
    isNseFnoEnabled = json['isNseFnoEnabled'];
  }
  String? searchId;
  String? growwCompanyId;
  String? isin;
  num? industryId;
  String? displayName;
  String? shortName;
  String? nseScriptCode;
  String? bseScriptCode;
  String? nseTradingSymbol;
  String? bseTradingSymbol;
  bool? isBseTradable;
  bool? isNseTradable;
  String? logoUrl;
  bool? isBseFnoEnabled;
  bool? isNseFnoEnabled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['searchId'] = searchId;
    map['growwCompanyId'] = growwCompanyId;
    map['isin'] = isin;
    map['industryId'] = industryId;
    map['displayName'] = displayName;
    map['shortName'] = shortName;
    map['nseScriptCode'] = nseScriptCode;
    map['bseScriptCode'] = bseScriptCode;
    map['nseTradingSymbol'] = nseTradingSymbol;
    map['bseTradingSymbol'] = bseTradingSymbol;
    map['isBseTradable'] = isBseTradable;
    map['isNseTradable'] = isNseTradable;
    map['logoUrl'] = logoUrl;
    map['isBseFnoEnabled'] = isBseFnoEnabled;
    map['isNseFnoEnabled'] = isNseFnoEnabled;
    return map;
  }
}

class PriceData {
  PriceData({
    this.nse,
    this.bse,
  });

  PriceData.fromJson(dynamic json) {
    nse = json['nse'] != null ? Nse.fromJson(json['nse']) : null;
    bse = json['bse'] != null ? Bse.fromJson(json['bse']) : null;
  }
  Nse? nse;
  Bse? bse;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (nse != null) {
      map['nse'] = nse?.toJson();
    }
    if (bse != null) {
      map['bse'] = bse?.toJson();
    }
    return map;
  }
}

class Bse {
  Bse({
    this.yearLowPrice,
    this.yearHighPrice,
  });

  Bse.fromJson(dynamic json) {
    yearLowPrice = json['yearLowPrice'];
    yearHighPrice = json['yearHighPrice'];
  }
  num? yearLowPrice;
  num? yearHighPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['yearLowPrice'] = yearLowPrice;
    map['yearHighPrice'] = yearHighPrice;
    return map;
  }
}

class Nse {
  Nse({
    this.yearLowPrice,
    this.yearHighPrice,
  });

  Nse.fromJson(dynamic json) {
    yearLowPrice = json['yearLowPrice'];
    yearHighPrice = json['yearHighPrice'];
  }
  num? yearLowPrice;
  num? yearHighPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['yearLowPrice'] = yearLowPrice;
    map['yearHighPrice'] = yearHighPrice;
    return map;
  }
}

class RetailAndOthers {
  RetailAndOthers({
    this.percent,
  });

  RetailAndOthers.fromJson(dynamic json) {
    percent = json['percent'];
  }
  num? percent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['percent'] = percent;
    return map;
  }
}

class ForeignInstitutions {
  ForeignInstitutions({
    this.percent,
  });

  ForeignInstitutions.fromJson(dynamic json) {
    percent = json['percent'];
  }
  num? percent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['percent'] = percent;
    return map;
  }
}

class OtherDomesticInstitutions {
  OtherDomesticInstitutions({
    this.insurance,
    this.otherFirms,
  });

  OtherDomesticInstitutions.fromJson(dynamic json) {
    insurance = json['insurance'] != null ? Insurance.fromJson(json['insurance']) : null;
    otherFirms = json['otherFirms'] != null ? OtherFirms.fromJson(json['otherFirms']) : null;
  }
  Insurance? insurance;
  OtherFirms? otherFirms;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (insurance != null) {
      map['insurance'] = insurance?.toJson();
    }
    if (otherFirms != null) {
      map['otherFirms'] = otherFirms?.toJson();
    }
    return map;
  }
}

class OtherFirms {
  OtherFirms({
    this.percent,
  });

  OtherFirms.fromJson(dynamic json) {
    percent = json['percent'];
  }
  num? percent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['percent'] = percent;
    return map;
  }
}

class Insurance {
  Insurance({
    this.percent,
  });

  Insurance.fromJson(dynamic json) {
    percent = json['percent'];
  }
  num? percent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['percent'] = percent;
    return map;
  }
}

class MutualFunds {
  MutualFunds({
    this.percent,
  });

  MutualFunds.fromJson(dynamic json) {
    percent = json['percent'];
  }
  num? percent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['percent'] = percent;
    return map;
  }
}

class Promoters {
  Promoters({
    this.individual,
    this.government,
    this.corporation,
  });

  Promoters.fromJson(dynamic json) {
    individual = json['individual'] != null ? Individual.fromJson(json['individual']) : null;
    government = json['government'] != null ? Government.fromJson(json['government']) : null;
    corporation = json['corporation'] != null ? Corporation.fromJson(json['corporation']) : null;
  }
  Individual? individual;
  Government? government;
  Corporation? corporation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (individual != null) {
      map['individual'] = individual?.toJson();
    }
    if (government != null) {
      map['government'] = government?.toJson();
    }
    if (corporation != null) {
      map['corporation'] = corporation?.toJson();
    }
    return map;
  }
}

class Corporation {
  Corporation({
    this.percent,
  });

  Corporation.fromJson(dynamic json) {
    percent = json['percent'];
  }
  num? percent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['percent'] = percent;
    return map;
  }
}

class Government {
  Government({
    this.percent,
  });

  Government.fromJson(dynamic json) {
    percent = json['percent'];
  }
  num? percent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['percent'] = percent;
    return map;
  }
}

class Individual {
  Individual({
    this.percent,
  });

  Individual.fromJson(dynamic json) {
    percent = json['percent'];
  }
  num? percent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['percent'] = percent;
    return map;
  }
}

class Fundamentals {
  Fundamentals({
    this.name,
    this.shortName,
    this.value,
  });

  Fundamentals.fromJson(dynamic json) {
    name = json['name'];
    shortName = json['shortName'];
    value = json['value'];
  }
  String? name;
  String? shortName;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['shortName'] = shortName;
    map['value'] = value;
    return map;
  }
}

class Stats {
  Stats({
    this.marketCap,
    this.pbRatio,
    this.peRatio,
    this.divYield,
    this.bookValue,
    this.epsTtm,
    this.roe,
    this.industryPe,
    this.cappedType,
    this.dividendYieldInPercent,
    this.faceValue,
    this.debtToEquity,
    this.returnOnAssets,
    this.returnOnEquity,
    this.operatingProfitMargin,
    this.netProfitMargin,
    this.quickRatio,
    this.cashRatio,
    this.debtToAsset,
    this.evToSales,
    this.evToEbitda,
    this.earningsYield,
    this.sectorPb,
    this.sectorDivYield,
    this.sectorRoe,
    this.sectorRoce,
    this.priceToOcf,
    this.priceToFcf,
    this.roic,
    this.pePremiumVsSector,
    this.pbPremiumVsSector,
    this.divYieldVsSector,
    this.currentRatio,
    this.sectorPe,
    this.priceToSales,
    this.pegRatio,
  });

  Stats.fromJson(dynamic json) {
    marketCap = json['marketCap'];
    pbRatio = json['pbRatio'];
    peRatio = json['peRatio'];
    divYield = json['divYield'];
    bookValue = json['bookValue'];
    epsTtm = json['epsTtm'];
    roe = json['roe'];
    industryPe = json['industryPe'];
    cappedType = json['cappedType'];
    dividendYieldInPercent = json['dividendYieldInPercent'];
    faceValue = json['faceValue'];
    debtToEquity = json['debtToEquity'];
    returnOnAssets = json['returnOnAssets'];
    returnOnEquity = json['returnOnEquity'];
    operatingProfitMargin = json['operatingProfitMargin'];
    netProfitMargin = json['netProfitMargin'];
    quickRatio = json['quickRatio'];
    cashRatio = json['cashRatio'];
    debtToAsset = json['debtToAsset'];
    evToSales = json['evToSales'];
    evToEbitda = json['evToEbitda'];
    earningsYield = json['earningsYield'];
    sectorPb = json['sectorPb'];
    sectorDivYield = json['sectorDivYield'];
    sectorRoe = json['sectorRoe'];
    sectorRoce = json['sectorRoce'];
    priceToOcf = json['priceToOcf'];
    priceToFcf = json['priceToFcf'];
    roic = json['roic'];
    pePremiumVsSector = json['pePremiumVsSector'];
    pbPremiumVsSector = json['pbPremiumVsSector'];
    divYieldVsSector = json['divYieldVsSector'];
    currentRatio = json['currentRatio'];
    sectorPe = json['sectorPe'];
    priceToSales = json['priceToSales'];
    pegRatio = json['pegRatio'];
  }
  num? marketCap;
  num? pbRatio;
  num? peRatio;
  num? divYield;
  num? bookValue;
  num? epsTtm;
  num? roe;
  num? industryPe;
  String? cappedType;
  num? dividendYieldInPercent;
  num? faceValue;
  num? debtToEquity;
  num? returnOnAssets;
  num? returnOnEquity;
  num? operatingProfitMargin;
  num? netProfitMargin;
  num? quickRatio;
  num? cashRatio;
  num? debtToAsset;
  num? evToSales;
  num? evToEbitda;
  num? earningsYield;
  num? sectorPb;
  num? sectorDivYield;
  num? sectorRoe;
  num? sectorRoce;
  num? priceToOcf;
  num? priceToFcf;
  num? roic;
  num? pePremiumVsSector;
  num? pbPremiumVsSector;
  num? divYieldVsSector;
  num? currentRatio;
  num? sectorPe;
  num? priceToSales;
  num? pegRatio;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['marketCap'] = marketCap;
    map['pbRatio'] = pbRatio;
    map['peRatio'] = peRatio;
    map['divYield'] = divYield;
    map['bookValue'] = bookValue;
    map['epsTtm'] = epsTtm;
    map['roe'] = roe;
    map['industryPe'] = industryPe;
    map['cappedType'] = cappedType;
    map['dividendYieldInPercent'] = dividendYieldInPercent;
    map['faceValue'] = faceValue;
    map['debtToEquity'] = debtToEquity;
    map['returnOnAssets'] = returnOnAssets;
    map['returnOnEquity'] = returnOnEquity;
    map['operatingProfitMargin'] = operatingProfitMargin;
    map['netProfitMargin'] = netProfitMargin;
    map['quickRatio'] = quickRatio;
    map['cashRatio'] = cashRatio;
    map['debtToAsset'] = debtToAsset;
    map['evToSales'] = evToSales;
    map['evToEbitda'] = evToEbitda;
    map['earningsYield'] = earningsYield;
    map['sectorPb'] = sectorPb;
    map['sectorDivYield'] = sectorDivYield;
    map['sectorRoe'] = sectorRoe;
    map['sectorRoce'] = sectorRoce;
    map['priceToOcf'] = priceToOcf;
    map['priceToFcf'] = priceToFcf;
    map['roic'] = roic;
    map['pePremiumVsSector'] = pePremiumVsSector;
    map['pbPremiumVsSector'] = pbPremiumVsSector;
    map['divYieldVsSector'] = divYieldVsSector;
    map['currentRatio'] = currentRatio;
    map['sectorPe'] = sectorPe;
    map['priceToSales'] = priceToSales;
    map['pegRatio'] = pegRatio;
    return map;
  }
}

class Details {
  Details({
    this.fullName,
    this.parentCompany,
    this.headquarters,
    this.ceo,
    this.managingDirector,
    this.businessSummary,
    this.websiteUrl,
  });

  Details.fromJson(dynamic json) {
    fullName = json['fullName'];
    parentCompany = json['parentCompany'];
    headquarters = json['headquarters'];
    ceo = json['ceo'];
    managingDirector = json['managingDirector'];
    businessSummary = json['businessSummary'];
    websiteUrl = json['websiteUrl'];
  }
  String? fullName;
  String? parentCompany;
  String? headquarters;
  String? ceo;
  String? managingDirector;
  String? businessSummary;
  String? websiteUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullName'] = fullName;
    map['parentCompany'] = parentCompany;
    map['headquarters'] = headquarters;
    map['ceo'] = ceo;
    map['managingDirector'] = managingDirector;
    map['businessSummary'] = businessSummary;
    map['websiteUrl'] = websiteUrl;
    return map;
  }
}

class Header {
  Header({
    this.searchId,
    this.growwCompanyId,
    this.isin,
    this.industryId,
    this.industryName,
    this.displayName,
    this.shortName,
    this.type,
    this.isFnoEnabled,
    this.nseScriptCode,
    this.bseScriptCode,
    this.nseTradingSymbol,
    this.bseTradingSymbol,
    this.isBseTradable,
    this.isNseTradable,
    this.logoUrl,
    this.floatingShares,
    this.isBseFnoEnabled,
    this.isNseFnoEnabled,
  });

  Header.fromJson(dynamic json) {
    searchId = json['searchId'];
    growwCompanyId = json['growwCompanyId'];
    isin = json['isin'];
    industryId = json['industryId'];
    industryName = json['industryName'];
    displayName = json['displayName'];
    shortName = json['shortName'];
    type = json['type'];
    isFnoEnabled = json['isFnoEnabled'];
    nseScriptCode = json['nseScriptCode'];
    bseScriptCode = json['bseScriptCode'];
    nseTradingSymbol = json['nseTradingSymbol'];
    bseTradingSymbol = json['bseTradingSymbol'];
    isBseTradable = json['isBseTradable'];
    isNseTradable = json['isNseTradable'];
    logoUrl = json['logoUrl'];
    floatingShares = json['floatingShares'];
    isBseFnoEnabled = json['isBseFnoEnabled'];
    isNseFnoEnabled = json['isNseFnoEnabled'];
  }
  String? searchId;
  String? growwCompanyId;
  String? isin;
  num? industryId;
  String? industryName;
  String? displayName;
  String? shortName;
  String? type;
  bool? isFnoEnabled;
  String? nseScriptCode;
  String? bseScriptCode;
  String? nseTradingSymbol;
  String? bseTradingSymbol;
  bool? isBseTradable;
  bool? isNseTradable;
  String? logoUrl;
  num? floatingShares;
  bool? isBseFnoEnabled;
  bool? isNseFnoEnabled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['searchId'] = searchId;
    map['growwCompanyId'] = growwCompanyId;
    map['isin'] = isin;
    map['industryId'] = industryId;
    map['industryName'] = industryName;
    map['displayName'] = displayName;
    map['shortName'] = shortName;
    map['type'] = type;
    map['isFnoEnabled'] = isFnoEnabled;
    map['nseScriptCode'] = nseScriptCode;
    map['bseScriptCode'] = bseScriptCode;
    map['nseTradingSymbol'] = nseTradingSymbol;
    map['bseTradingSymbol'] = bseTradingSymbol;
    map['isBseTradable'] = isBseTradable;
    map['isNseTradable'] = isNseTradable;
    map['logoUrl'] = logoUrl;
    map['floatingShares'] = floatingShares;
    map['isBseFnoEnabled'] = isBseFnoEnabled;
    map['isNseFnoEnabled'] = isNseFnoEnabled;
    return map;
  }
}

class MainData {
  MainData({
    this.data,
    this.message,
  });

  MainData.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }
  Data? data;
  dynamic message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message'] = message;
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
  String? companySymbol;
  String? scripCode;

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
