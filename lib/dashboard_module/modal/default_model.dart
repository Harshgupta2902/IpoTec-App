class DefaultModel {
  DefaultModel({
    this.forceUpdate,
    this.softUpdate,
    this.buildNo,
    this.maintenance,
  });

  DefaultModel.fromJson(dynamic json) {
    forceUpdate = json['force_update'];
    softUpdate = json['soft_update'];
    buildNo = json['build_no'];
    maintenance = json['maintenance'];
  }
  num? forceUpdate;
  num? softUpdate;
  num? buildNo;
  num? maintenance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['force_update'] = forceUpdate;
    map['soft_update'] = softUpdate;
    map['build_no'] = buildNo;
    map['maintenance'] = maintenance;
    return map;
  }
}
