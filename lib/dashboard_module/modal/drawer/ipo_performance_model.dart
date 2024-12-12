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
      this.companyName, 
      this.listedOn, 
      this.issuePrice, 
      this.listingDayClose, 
      this.listingDayGain, 
      this.currentPrice, 
      this.profitLoss,});

  Data.fromJson(dynamic json) {
    companyName = json['companyName'];
    listedOn = json['listedOn'];
    issuePrice = json['issuePrice'];
    listingDayClose = json['listingDayClose'];
    listingDayGain = json['listingDayGain'];
    currentPrice = json['currentPrice'];
    profitLoss = json['profitLoss'];
  }
  String? companyName;
  String? listedOn;
  String? issuePrice;
  String? listingDayClose;
  String? listingDayGain;
  String? currentPrice;
  String? profitLoss;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['companyName'] = companyName;
    map['listedOn'] = listedOn;
    map['issuePrice'] = issuePrice;
    map['listingDayClose'] = listingDayClose;
    map['listingDayGain'] = listingDayGain;
    map['currentPrice'] = currentPrice;
    map['profitLoss'] = profitLoss;
    return map;
  }

}