class DefaultModel {
  num? forceUpdate;
  num? softUpdate;
  num? buildNo;
  num? iosBuildNo;
  String? title;
  String? message;
  bool? showAd;

  DefaultModel({
    this.forceUpdate,
    this.softUpdate,
    this.buildNo,
    this.iosBuildNo,
    this.title,
    this.message,
    this.showAd,
  });

  DefaultModel.fromJson(dynamic json) {
    forceUpdate = _toNum(json['force_update']);
    softUpdate = _toNum(json['soft_update']);
    buildNo = _toNum(json['build_no']);
    iosBuildNo = _toNum(json['ios_build_no']);
    title = json['title']?.toString();
    message = json['message']?.toString();
    showAd = json['show_ad'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['force_update'] = forceUpdate;
    map['soft_update'] = softUpdate;
    map['build_no'] = buildNo;
    map['ios_build_no'] = iosBuildNo;
    map['title'] = title;
    map['message'] = message;
    map['show_ad'] = showAd;
    return map;
  }

  num? _toNum(dynamic value) {
    if (value is num) {
      return value;
    } else if (value is String) {
      return num.tryParse(value);
    }
    return null;
  }
}
