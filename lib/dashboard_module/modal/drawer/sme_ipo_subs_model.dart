class SmeIpoSubsModel {
  SmeIpoSubsModel({
      this.success, 
      this.data,});

  SmeIpoSubsModel.fromJson(dynamic json) {
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
      this.open, 
      this.close, 
      this.size, 
      this.qib, 
      this.nii, 
      this.retail, 
      this.total, 
      this.applications,});

  Data.fromJson(dynamic json) {
    companyName = json['companyName'];
    href = json['href'];
    open = json['open'];
    close = json['close'];
    size = json['size'];
    qib = json['qib'];
    nii = json['nii'];
    retail = json['retail'];
    total = json['total'];
    applications = json['applications'];
  }
  String? companyName;
  String? href;
  String? open;
  String? close;
  String? size;
  String? qib;
  String? nii;
  String? retail;
  String? total;
  String? applications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['companyName'] = companyName;
    map['href'] = href;
    map['open'] = open;
    map['close'] = close;
    map['size'] = size;
    map['qib'] = qib;
    map['nii'] = nii;
    map['retail'] = retail;
    map['total'] = total;
    map['applications'] = applications;
    return map;
  }

}