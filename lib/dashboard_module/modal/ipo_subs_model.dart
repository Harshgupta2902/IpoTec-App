class IpoSubsModel {
  IpoSubsModel({
    this.ipoSubscriptionData,
    this.smeSubscriptionData,
  });

  IpoSubsModel.fromJson(dynamic json) {
    if (json['ipo_subscription_data'] != null) {
      ipoSubscriptionData = [];
      json['ipo_subscription_data'].forEach((v) {
        ipoSubscriptionData?.add(IpoSubscriptionData.fromJson(v));
      });
    }
    if (json['sme_subscription_data'] != null) {
      smeSubscriptionData = [];
      json['sme_subscription_data'].forEach((v) {
        smeSubscriptionData?.add(SmeSubscriptionData.fromJson(v));
      });
    }
  }
  List<IpoSubscriptionData>? ipoSubscriptionData;
  List<SmeSubscriptionData>? smeSubscriptionData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ipoSubscriptionData != null) {
      map['ipo_subscription_data'] = ipoSubscriptionData?.map((v) => v.toJson()).toList();
    }
    if (smeSubscriptionData != null) {
      map['sme_subscription_data'] = smeSubscriptionData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class SmeSubscriptionData {
  SmeSubscriptionData({
    this.companyName,
    this.open,
    this.close,
    this.sizeRsCr,
    this.qibX,
    this.niiX,
    this.retailX,
    this.totalX,
    this.applications,
  });

  SmeSubscriptionData.fromJson(dynamic json) {
    companyName = json['company_name'];
    open = json['open'];
    close = json['close'];
    sizeRsCr = json['size_rs_cr'];
    qibX = json['qib_x'];
    niiX = json['nii_x'];
    retailX = json['retail_x'];
    totalX = json['total_x'];
    applications = json['applications'];
  }
  String? companyName;
  String? open;
  String? close;
  String? sizeRsCr;
  String? qibX;
  String? niiX;
  String? retailX;
  String? totalX;
  String? applications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['company_name'] = companyName;
    map['open'] = open;
    map['close'] = close;
    map['size_rs_cr'] = sizeRsCr;
    map['qib_x'] = qibX;
    map['nii_x'] = niiX;
    map['retail_x'] = retailX;
    map['total_x'] = totalX;
    map['applications'] = applications;
    return map;
  }
}

class IpoSubscriptionData {
  IpoSubscriptionData({
    this.companyName,
    this.close,
    this.sizeRsCr,
    this.qibX,
    this.niiX,
    this.bniiX,
    this.retailX,
    this.employeeX,
    this.othersX,
    this.totalX,
    this.applications,
  });

  IpoSubscriptionData.fromJson(dynamic json) {
    companyName = json['company_name'];
    close = json['close'];
    sizeRsCr = json['size_rs_cr'];
    qibX = json['qib_x'];
    niiX = json['nii_x'];
    bniiX = json['bnii_x'];
    retailX = json['retail_x'];
    employeeX = json['employee_x'];
    othersX = json['others_x'];
    totalX = json['total_x'];
    applications = json['applications'];
  }
  String? companyName;
  String? close;
  String? sizeRsCr;
  String? qibX;
  String? niiX;
  String? bniiX;
  String? retailX;
  String? employeeX;
  String? othersX;
  String? totalX;
  String? applications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['company_name'] = companyName;
    map['close'] = close;
    map['size_rs_cr'] = sizeRsCr;
    map['qib_x'] = qibX;
    map['nii_x'] = niiX;
    map['bnii_x'] = bniiX;
    map['retail_x'] = retailX;
    map['employee_x'] = employeeX;
    map['others_x'] = othersX;
    map['total_x'] = totalX;
    map['applications'] = applications;
    return map;
  }
}
