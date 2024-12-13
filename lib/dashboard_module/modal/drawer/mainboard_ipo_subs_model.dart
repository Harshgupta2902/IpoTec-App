class MainboardIpoSubsModel {
  MainboardIpoSubsModel({
      this.success, 
      this.data,});

  MainboardIpoSubsModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      this.companyName, 
      this.href, 
      this.closeDate, 
      this.size, 
      this.qib, 
      this.snii, 
      this.bnni, 
      this.nii, 
      this.retail, 
      this.employee, 
      this.others, 
      this.total, 
      this.applications,});

  Data.fromJson(dynamic json) {
    companyName = json['companyName'];
    href = json['href'];
    closeDate = json['closeDate'];
    size = json['size'];
    qib = json['qib'];
    snii = json['snii'];
    bnni = json['bnni'];
    nii = json['nii'];
    retail = json['retail'];
    employee = json['employee'];
    others = json['others'];
    total = json['total'];
    applications = json['applications'];
  }
  String? companyName;
  String? href;
  String? closeDate;
  String? size;
  String? qib;
  String? snii;
  String? bnni;
  String? nii;
  String? retail;
  String? employee;
  String? others;
  String? total;
  String? applications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['companyName'] = companyName;
    map['href'] = href;
    map['closeDate'] = closeDate;
    map['size'] = size;
    map['qib'] = qib;
    map['snii'] = snii;
    map['bnni'] = bnni;
    map['nii'] = nii;
    map['retail'] = retail;
    map['employee'] = employee;
    map['others'] = others;
    map['total'] = total;
    map['applications'] = applications;
    return map;
  }

}