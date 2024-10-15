class DefaultModel {
  DefaultModel({
    this.forceUpdate,
    this.softUpdate,
    this.buildNo,
    this.iosBuildNo,
    this.title,
    this.message,
    this.showAd,
    this.menuItems,
  });

  DefaultModel.fromJson(dynamic json) {
    forceUpdate = json['force_update'];
    softUpdate = json['soft_update'];
    buildNo = json['build_no'];
    iosBuildNo = json['ios_build_no'];
    title = json['title'];
    message = json['message'];
    showAd = json['show_ad'];
    if (json['menu_items'] != null) {
      menuItems = [];
      json['menu_items'].forEach((v) {
        menuItems?.add(MenuItems.fromJson(v));
      });
    }
  }
  num? forceUpdate;
  num? softUpdate;
  num? buildNo;
  num? iosBuildNo;
  String? title;
  String? message;
  bool? showAd;
  List<MenuItems>? menuItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['force_update'] = forceUpdate;
    map['soft_update'] = softUpdate;
    map['build_no'] = buildNo;
    map['ios_build_no'] = iosBuildNo;
    map['title'] = title;
    map['message'] = message;
    map['show_ad'] = showAd;
    if (menuItems != null) {
      map['menu_items'] = menuItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class MenuItems {
  MenuItems({
    this.key,
    this.path,
  });

  MenuItems.fromJson(dynamic json) {
    key = json['key'];
    path = json['path'];
  }
  String? key;
  String? path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['path'] = path;
    return map;
  }
}
