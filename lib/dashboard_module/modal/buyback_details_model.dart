class BuybackDetailsModel {
  BuybackDetailsModel({
      this.mainData, 
      this.searchId, 
      this.symnolData,});

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
      this.brandDtos, 
      this.stats, 
      this.fundamentals, 
      this.shareHoldingPattern, 
      this.fundsInvested, 
      this.priceData, 
      this.financialStatement, 
      this.similarAssets,});

  SymnolData.fromJson(dynamic json) {
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    details = json['details'] != null ? Details.fromJson(json['details']) : null;
    if (json['brandDtos'] != null) {
      brandDtos = [];
      json['brandDtos'].forEach((v) {
        brandDtos?.add(Dynamic.fromJson(v));
      });
    }
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
    if (json['fundamentals'] != null) {
      fundamentals = [];
      json['fundamentals'].forEach((v) {
        fundamentals?.add(Fundamentals.fromJson(v));
      });
    }
    shareHoldingPattern = json['shareHoldingPattern'] != null ? ShareHoldingPattern.fromJson(json['shareHoldingPattern']) : null;
    if (json['fundsInvested'] != null) {
      fundsInvested = [];
      json['fundsInvested'].forEach((v) {
        fundsInvested?.add(Dynamic.fromJson(v));
      });
    }
    priceData = json['priceData'] != null ? PriceData.fromJson(json['priceData']) : null;
    if (json['financialStatement'] != null) {
      financialStatement = [];
      json['financialStatement'].forEach((v) {
        financialStatement?.add(FinancialStatement.fromJson(v));
      });
    }
    similarAssets = json['similarAssets'] != null ? SimilarAssets.fromJson(json['similarAssets']) : null;
  }
  Header? header;
  Details? details;
  List<dynamic>? brandDtos;
  Stats? stats;
  List<Fundamentals>? fundamentals;
  ShareHoldingPattern? shareHoldingPattern;
  List<dynamic>? fundsInvested;
  PriceData? priceData;
  List<FinancialStatement>? financialStatement;
  SimilarAssets? similarAssets;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (header != null) {
      map['header'] = header?.toJson();
    }
    if (details != null) {
      map['details'] = details?.toJson();
    }
    if (brandDtos != null) {
      map['brandDtos'] = brandDtos?.map((v) => v.toJson()).toList();
    }
    if (stats != null) {
      map['stats'] = stats?.toJson();
    }
    if (fundamentals != null) {
      map['fundamentals'] = fundamentals?.map((v) => v.toJson()).toList();
    }
    if (shareHoldingPattern != null) {
      map['shareHoldingPattern'] = shareHoldingPattern?.toJson();
    }
    if (fundsInvested != null) {
      map['fundsInvested'] = fundsInvested?.map((v) => v.toJson()).toList();
    }
    if (priceData != null) {
      map['priceData'] = priceData?.toJson();
    }
    if (financialStatement != null) {
      map['financialStatement'] = financialStatement?.map((v) => v.toJson()).toList();
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
      this.peerList,});

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
      this.pbRatio,});

  PeerList.fromJson(dynamic json) {
    companyHeader = json['companyHeader'] != null ? CompanyHeader.fromJson(json['companyHeader']) : null;
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
      this.isNseFnoEnabled,});

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

class FinancialStatement {
  FinancialStatement({
      this.title, 
      this.yearly, 
      this.quarterly,});

  FinancialStatement.fromJson(dynamic json) {
    title = json['title'];
    yearly = json['yearly'] != null ? Yearly.fromJson(json['yearly']) : null;
    quarterly = json['quarterly'] != null ? Quarterly.fromJson(json['quarterly']) : null;
  }
  String? title;
  Yearly? yearly;
  Quarterly? quarterly;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    if (yearly != null) {
      map['yearly'] = yearly?.toJson();
    }
    if (quarterly != null) {
      map['quarterly'] = quarterly?.toJson();
    }
    return map;
  }

}

class Quarterly {
  Quarterly({
      this.jun23, 
      this.sep23, 
      this.dec23, 
      this.mar24, 
      this.jun24,});

  Quarterly.fromJson(dynamic json) {
    jun23 = json['Jun '23'];
    sep23 = json['Sep '23'];
    dec23 = json['Dec '23'];
    mar24 = json['Mar '24'];
    jun24 = json['Jun '24'];
  }
  num? jun23;
  num? sep23;
  num? dec23;
  num? mar24;
  num? jun24;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Jun '23'] = jun23;
    map['Sep '23'] = sep23;
    map['Dec '23'] = dec23;
    map['Mar '24'] = mar24;
    map['Jun '24'] = jun24;
    return map;
  }

}

class Yearly {
  Yearly({
      this., 
      this., 
      this., 
      this., 
      this.,});

  Yearly.fromJson(dynamic json) {
     = json['2020'];
     = json['2021'];
     = json['2022'];
     = json['2023'];
     = json['2024'];
  }
  num? ;
  num? ;
  num? ;
  num? ;
  num? ;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['2020'] = ;
    map['2021'] = ;
    map['2022'] = ;
    map['2023'] = ;
    map['2024'] = ;
    return map;
  }

}

class PriceData {
  PriceData({
      this.nse, 
      this.bse,});

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
      this.yearHighPrice,});

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
      this.yearHighPrice,});

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

class ShareHoldingPattern {
  ShareHoldingPattern({
      this.jun23, 
      this.sep23, 
      this.dec23, 
      this.mar24, 
      this.jun24,});

  ShareHoldingPattern.fromJson(dynamic json) {
    jun23 = json['Jun '23'] != null ? Jun'23.fromJson(json['Jun '23']) : null;
    sep23 = json['Sep '23'] != null ? Sep'23.fromJson(json['Sep '23']) : null;
    dec23 = json['Dec '23'] != null ? Dec'23.fromJson(json['Dec '23']) : null;
    mar24 = json['Mar '24'] != null ? Mar'24.fromJson(json['Mar '24']) : null;
    jun24 = json['Jun '24'] != null ? Jun'24.fromJson(json['Jun '24']) : null;
  }
  Jun'23? jun23;
  Sep'23? sep23;
  Dec'23? dec23;
  Mar'24? mar24;
  Jun'24? jun24;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (jun23 != null) {
      map['Jun '23'] = jun23?.toJson();
    }
    if (sep23 != null) {
      map['Sep '23'] = sep23?.toJson();
    }
    if (dec23 != null) {
      map['Dec '23'] = dec23?.toJson();
    }
    if (mar24 != null) {
      map['Mar '24'] = mar24?.toJson();
    }
    if (jun24 != null) {
      map['Jun '24'] = jun24?.toJson();
    }
    return map;
  }

}

class Jun'24 {
  Jun'24({
      this.promoters, 
      this.mutualFunds, 
      this.otherDomesticInstitutions, 
      this.foreignInstitutions, 
      this.retailAndOthers,});

  Jun'24.fromJson(dynamic json) {
    promoters = json['promoters'] != null ? Promoters.fromJson(json['promoters']) : null;
    mutualFunds = json['mutualFunds'] != null ? MutualFunds.fromJson(json['mutualFunds']) : null;
    otherDomesticInstitutions = json['otherDomesticInstitutions'] != null ? OtherDomesticInstitutions.fromJson(json['otherDomesticInstitutions']) : null;
    foreignInstitutions = json['foreignInstitutions'] != null ? ForeignInstitutions.fromJson(json['foreignInstitutions']) : null;
    retailAndOthers = json['retailAndOthers'] != null ? RetailAndOthers.fromJson(json['retailAndOthers']) : null;
  }
  Promoters? promoters;
  MutualFunds? mutualFunds;
  OtherDomesticInstitutions? otherDomesticInstitutions;
  ForeignInstitutions? foreignInstitutions;
  RetailAndOthers? retailAndOthers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (promoters != null) {
      map['promoters'] = promoters?.toJson();
    }
    if (mutualFunds != null) {
      map['mutualFunds'] = mutualFunds?.toJson();
    }
    if (otherDomesticInstitutions != null) {
      map['otherDomesticInstitutions'] = otherDomesticInstitutions?.toJson();
    }
    if (foreignInstitutions != null) {
      map['foreignInstitutions'] = foreignInstitutions?.toJson();
    }
    if (retailAndOthers != null) {
      map['retailAndOthers'] = retailAndOthers?.toJson();
    }
    return map;
  }

}

class RetailAndOthers {
  RetailAndOthers({
      this.percent,});

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
      this.percent,});

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
      this.otherFirms,});

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
      this.percent,});

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
      this.percent,});

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
      this.percent,});

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
      this.corporation,});

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
      this.percent,});

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
      this.percent,});

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
      this.percent,});

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

class Mar'24 {
  Mar'24({
      this.promoters, 
      this.mutualFunds, 
      this.otherDomesticInstitutions, 
      this.foreignInstitutions, 
      this.retailAndOthers,});

  Mar'24.fromJson(dynamic json) {
    promoters = json['promoters'] != null ? Promoters.fromJson(json['promoters']) : null;
    mutualFunds = json['mutualFunds'] != null ? MutualFunds.fromJson(json['mutualFunds']) : null;
    otherDomesticInstitutions = json['otherDomesticInstitutions'] != null ? OtherDomesticInstitutions.fromJson(json['otherDomesticInstitutions']) : null;
    foreignInstitutions = json['foreignInstitutions'] != null ? ForeignInstitutions.fromJson(json['foreignInstitutions']) : null;
    retailAndOthers = json['retailAndOthers'] != null ? RetailAndOthers.fromJson(json['retailAndOthers']) : null;
  }
  Promoters? promoters;
  MutualFunds? mutualFunds;
  OtherDomesticInstitutions? otherDomesticInstitutions;
  ForeignInstitutions? foreignInstitutions;
  RetailAndOthers? retailAndOthers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (promoters != null) {
      map['promoters'] = promoters?.toJson();
    }
    if (mutualFunds != null) {
      map['mutualFunds'] = mutualFunds?.toJson();
    }
    if (otherDomesticInstitutions != null) {
      map['otherDomesticInstitutions'] = otherDomesticInstitutions?.toJson();
    }
    if (foreignInstitutions != null) {
      map['foreignInstitutions'] = foreignInstitutions?.toJson();
    }
    if (retailAndOthers != null) {
      map['retailAndOthers'] = retailAndOthers?.toJson();
    }
    return map;
  }

}

class RetailAndOthers {
  RetailAndOthers({
      this.percent,});

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
      this.percent,});

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
      this.otherFirms,});

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
      this.percent,});

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
      this.percent,});

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
      this.percent,});

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
      this.corporation,});

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
      this.percent,});

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
      this.percent,});

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
      this.percent,});

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

class Dec'23 {
  Dec'23({
      this.promoters, 
      this.mutualFunds, 
      this.otherDomesticInstitutions, 
      this.foreignInstitutions, 
      this.retailAndOthers,});

  Dec'23.fromJson(dynamic json) {
    promoters = json['promoters'] != null ? Promoters.fromJson(json['promoters']) : null;
    mutualFunds = json['mutualFunds'] != null ? MutualFunds.fromJson(json['mutualFunds']) : null;
    otherDomesticInstitutions = json['otherDomesticInstitutions'] != null ? OtherDomesticInstitutions.fromJson(json['otherDomesticInstitutions']) : null;
    foreignInstitutions = json['foreignInstitutions'] != null ? ForeignInstitutions.fromJson(json['foreignInstitutions']) : null;
    retailAndOthers = json['retailAndOthers'] != null ? RetailAndOthers.fromJson(json['retailAndOthers']) : null;
  }
  Promoters? promoters;
  MutualFunds? mutualFunds;
  OtherDomesticInstitutions? otherDomesticInstitutions;
  ForeignInstitutions? foreignInstitutions;
  RetailAndOthers? retailAndOthers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (promoters != null) {
      map['promoters'] = promoters?.toJson();
    }
    if (mutualFunds != null) {
      map['mutualFunds'] = mutualFunds?.toJson();
    }
    if (otherDomesticInstitutions != null) {
      map['otherDomesticInstitutions'] = otherDomesticInstitutions?.toJson();
    }
    if (foreignInstitutions != null) {
      map['foreignInstitutions'] = foreignInstitutions?.toJson();
    }
    if (retailAndOthers != null) {
      map['retailAndOthers'] = retailAndOthers?.toJson();
    }
    return map;
  }

}

class RetailAndOthers {
  RetailAndOthers({
      this.percent,});

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
      this.percent,});

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
      this.otherFirms,});

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
      this.percent,});

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
      this.percent,});

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
      this.percent,});

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
      this.corporation,});

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
      this.percent,});

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
      this.percent,});

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
      this.percent,});

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

class Sep'23 {
  Sep'23({
      this.promoters, 
      this.mutualFunds, 
      this.otherDomesticInstitutions, 
      this.foreignInstitutions, 
      this.retailAndOthers,});

  Sep'23.fromJson(dynamic json) {
    promoters = json['promoters'] != null ? Promoters.fromJson(json['promoters']) : null;
    mutualFunds = json['mutualFunds'] != null ? MutualFunds.fromJson(json['mutualFunds']) : null;
    otherDomesticInstitutions = json['otherDomesticInstitutions'] != null ? OtherDomesticInstitutions.fromJson(json['otherDomesticInstitutions']) : null;
    foreignInstitutions = json['foreignInstitutions'] != null ? ForeignInstitutions.fromJson(json['foreignInstitutions']) : null;
    retailAndOthers = json['retailAndOthers'] != null ? RetailAndOthers.fromJson(json['retailAndOthers']) : null;
  }
  Promoters? promoters;
  MutualFunds? mutualFunds;
  OtherDomesticInstitutions? otherDomesticInstitutions;
  ForeignInstitutions? foreignInstitutions;
  RetailAndOthers? retailAndOthers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (promoters != null) {
      map['promoters'] = promoters?.toJson();
    }
    if (mutualFunds != null) {
      map['mutualFunds'] = mutualFunds?.toJson();
    }
    if (otherDomesticInstitutions != null) {
      map['otherDomesticInstitutions'] = otherDomesticInstitutions?.toJson();
    }
    if (foreignInstitutions != null) {
      map['foreignInstitutions'] = foreignInstitutions?.toJson();
    }
    if (retailAndOthers != null) {
      map['retailAndOthers'] = retailAndOthers?.toJson();
    }
    return map;
  }

}

class RetailAndOthers {
  RetailAndOthers({
      this.percent,});

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
      this.percent,});

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
      this.otherFirms,});

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
      this.percent,});

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
      this.percent,});

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
      this.percent,});

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
      this.corporation,});

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
      this.percent,});

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
      this.percent,});

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
      this.percent,});

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

class Jun'23 {
  Jun'23({
      this.promoters, 
      this.mutualFunds, 
      this.otherDomesticInstitutions, 
      this.foreignInstitutions, 
      this.retailAndOthers,});

  Jun'23.fromJson(dynamic json) {
    promoters = json['promoters'] != null ? Promoters.fromJson(json['promoters']) : null;
    mutualFunds = json['mutualFunds'] != null ? MutualFunds.fromJson(json['mutualFunds']) : null;
    otherDomesticInstitutions = json['otherDomesticInstitutions'] != null ? OtherDomesticInstitutions.fromJson(json['otherDomesticInstitutions']) : null;
    foreignInstitutions = json['foreignInstitutions'] != null ? ForeignInstitutions.fromJson(json['foreignInstitutions']) : null;
    retailAndOthers = json['retailAndOthers'] != null ? RetailAndOthers.fromJson(json['retailAndOthers']) : null;
  }
  Promoters? promoters;
  MutualFunds? mutualFunds;
  OtherDomesticInstitutions? otherDomesticInstitutions;
  ForeignInstitutions? foreignInstitutions;
  RetailAndOthers? retailAndOthers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (promoters != null) {
      map['promoters'] = promoters?.toJson();
    }
    if (mutualFunds != null) {
      map['mutualFunds'] = mutualFunds?.toJson();
    }
    if (otherDomesticInstitutions != null) {
      map['otherDomesticInstitutions'] = otherDomesticInstitutions?.toJson();
    }
    if (foreignInstitutions != null) {
      map['foreignInstitutions'] = foreignInstitutions?.toJson();
    }
    if (retailAndOthers != null) {
      map['retailAndOthers'] = retailAndOthers?.toJson();
    }
    return map;
  }

}

class RetailAndOthers {
  RetailAndOthers({
      this.percent,});

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
      this.percent,});

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
      this.otherFirms,});

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
      this.percent,});

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
      this.percent,});

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
      this.percent,});

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
      this.corporation,});

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
      this.percent,});

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
      this.percent,});

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
      this.percent,});

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
      this.value,});

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
      this.pegRatio,});

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
      this.websiteUrl,});

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
      this.isNseFnoEnabled,});

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
      this.message,});

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
      this.scripCode,});

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