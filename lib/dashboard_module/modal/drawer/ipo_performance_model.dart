class IpoPerformanceModel {
  IpoPerformanceModel({
      this.status, 
      this.data,});

  IpoPerformanceModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? status;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.companyName, 
      this.faceValue, 
      this.issuePrice, 
      this.href, 
      this.listingDate, 
      this.bseScriptCode, 
      this.nseScriptSymbol, 
      this.closePrice, 
      this.bseClose, 
      this.bsePrevClose, 
      this.bseOpen, 
      this.bseHigh, 
      this.bseLow, 
      this.bseShares, 
      this.nseClose, 
      this.nsePrevClose, 
      this.nseOpen, 
      this.nseHigh, 
      this.nseLow, 
      this.changeToday, 
      this.changePercentageToday, 
      this.changePercentageListingDay, 
      this.profitLoss, 
      this.issueSizeAmount,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    companyName = json['companyName'];
    faceValue = json['faceValue'];
    issuePrice = json['issuePrice'];
    href = json['href'];
    listingDate = json['listingDate'];
    bseScriptCode = json['bseScriptCode'];
    nseScriptSymbol = json['nseScriptSymbol'];
    closePrice = json['closePrice'];
    bseClose = json['bseClose'];
    bsePrevClose = json['bsePrevClose'];
    bseOpen = json['bseOpen'];
    bseHigh = json['bseHigh'];
    bseLow = json['bseLow'];
    bseShares = json['bseShares'];
    nseClose = json['nseClose'];
    nsePrevClose = json['nsePrevClose'];
    nseOpen = json['nseOpen'];
    nseHigh = json['nseHigh'];
    nseLow = json['nseLow'];
    changeToday = json['changeToday'];
    changePercentageToday = json['changePercentageToday'];
    changePercentageListingDay = json['changePercentageListingDay'];
    profitLoss = json['profitLoss'];
    issueSizeAmount = json['issueSizeAmount'];
  }
  String? id;
  String? companyName;
  String? faceValue;
  String? issuePrice;
  String? href;
  String? listingDate;
  String? bseScriptCode;
  String? nseScriptSymbol;
  String? closePrice;
  String? bseClose;
  String? bsePrevClose;
  String? bseOpen;
  String? bseHigh;
  String? bseLow;
  String? bseShares;
  String? nseClose;
  String? nsePrevClose;
  String? nseOpen;
  String? nseHigh;
  String? nseLow;
  String? changeToday;
  String? changePercentageToday;
  String? changePercentageListingDay;
  String? profitLoss;
  String? issueSizeAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['companyName'] = companyName;
    map['faceValue'] = faceValue;
    map['issuePrice'] = issuePrice;
    map['href'] = href;
    map['listingDate'] = listingDate;
    map['bseScriptCode'] = bseScriptCode;
    map['nseScriptSymbol'] = nseScriptSymbol;
    map['closePrice'] = closePrice;
    map['bseClose'] = bseClose;
    map['bsePrevClose'] = bsePrevClose;
    map['bseOpen'] = bseOpen;
    map['bseHigh'] = bseHigh;
    map['bseLow'] = bseLow;
    map['bseShares'] = bseShares;
    map['nseClose'] = nseClose;
    map['nsePrevClose'] = nsePrevClose;
    map['nseOpen'] = nseOpen;
    map['nseHigh'] = nseHigh;
    map['nseLow'] = nseLow;
    map['changeToday'] = changeToday;
    map['changePercentageToday'] = changePercentageToday;
    map['changePercentageListingDay'] = changePercentageListingDay;
    map['profitLoss'] = profitLoss;
    map['issueSizeAmount'] = issueSizeAmount;
    return map;
  }

}