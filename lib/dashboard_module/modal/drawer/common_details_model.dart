class CommonDetailsModel {
  CommonDetailsModel({
    this.ulAfterHeadingsResult,
    this.tables,
  });

  CommonDetailsModel.fromJson(dynamic json) {
    if (json['ulAfterHeadingsResult'] != null) {
      ulAfterHeadingsResult = [];
      json['ulAfterHeadingsResult'].forEach((v) {
        ulAfterHeadingsResult?.add(UlAfterHeadingsResult.fromJson(v));
      });
    }

    if (json['tables'] != null) {
      tables = [];
      json['tables'].forEach((v) {
        List<Tables> temp = [];
        v.forEach((v) {
          temp.add(Tables.fromJson(v));
        });
        tables?.add(temp);
      });
    }
  }
  List<UlAfterHeadingsResult>? ulAfterHeadingsResult;
  List<List<Tables>>? tables;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ulAfterHeadingsResult != null) {
      map['ulAfterHeadingsResult'] = ulAfterHeadingsResult?.map((v) => v.toJson()).toList();
    }
    if (tables != null) {
      map['tables'] = tables?.map((v) => v).toList();
    }
    return map;
  }
}

class Tables {
  Tables({
    this.column1,
    this.column2,
    this.column3,
    this.column4,
    this.column5,
    this.column6,
  });

  Tables.fromJson(dynamic json) {
    column1 = json['column1'];
    column2 = json['column2'];
    column3 = json['column3'];
    column4 = json['column4'];
    column5 = json['column5'];
    column6 = json['column6'];
  }
  String? column1;
  String? column2;
  String? column3;
  String? column4;
  String? column5;
  String? column6;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['column1'] = column1;
    map['column2'] = column2;
    map['column3'] = column3;
    map['column4'] = column4;
    map['column5'] = column5;
    map['column6'] = column6;
    return map;
  }
}

class UlAfterHeadingsResult {
  UlAfterHeadingsResult({
    this.heading,
    this.items,
  });

  UlAfterHeadingsResult.fromJson(dynamic json) {
    heading = json['heading'];
    items = json['items'] != null ? json['items'].cast<String>() : [];
  }
  String? heading;
  List<String>? items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['heading'] = heading;
    map['items'] = items;
    return map;
  }
}
