class IpoFormsModel {
  IpoFormsModel({
    this.forms,
  });

  IpoFormsModel.fromJson(dynamic json) {
    if (json['forms'] != null) {
      forms = [];
      json['forms'].forEach((v) {
        forms?.add(Forms.fromJson(v));
      });
    }
  }
  List<Forms>? forms;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (forms != null) {
      map['forms'] = forms?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Forms {
  Forms({
    this.companyName,
    this.date,
    this.dateLink,
    this.bse,
    this.bseLink,
    this.nse,
    this.nseLink,
    this.link,
    this.slug,
  });

  Forms.fromJson(dynamic json) {
    companyName = json['company_name'];
    date = json['date'];
    dateLink = json['date_link'];
    bse = json['bse'];
    bseLink = json['bse_link'];
    nse = json['nse'];
    nseLink = json['nse_link'];
    link = json['link'];
    slug = json['slug'];
  }
  String? companyName;
  String? date;
  dynamic dateLink;
  String? bse;
  String? bseLink;
  String? nse;
  String? nseLink;
  String? link;
  String? slug;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['company_name'] = companyName;
    map['date'] = date;
    map['date_link'] = dateLink;
    map['bse'] = bse;
    map['bse_link'] = bseLink;
    map['nse'] = nse;
    map['nse_link'] = nseLink;
    map['link'] = link;
    map['slug'] = slug;
    return map;
  }
}
