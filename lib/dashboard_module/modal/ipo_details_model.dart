class IpoDetailsModel {
  IpoDetailsModel({
    this.success,
    this.data,
  });

  IpoDetailsModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.logo,
    this.summary,
    this.about,
    this.docLinks,
    this.ipoDetails,
    this.promoterHolding,
    this.financialData,
    this.address,
    this.registrar,
    this.subscription,
    this.gmpData,
    this.news,
  });

  Data.fromJson(dynamic json) {
    logo = json['logo'];
    summary = json['summary'] != null ? json['summary'].cast<String>() : [];
    about = json['about'] != null ? json['about'].cast<String>() : [];
    if (json['docLinks'] != null) {
      docLinks = [];
      json['docLinks'].forEach((v) {
        docLinks?.add(DocLinks.fromJson(v));
      });
    }
    if (json['ipoDetails'] != null) {
      ipoDetails = [];
      json['ipoDetails'].forEach((v) {
        ipoDetails?.add(IpoDetails.fromJson(v));
      });
    }
    if (json['promoterHolding'] != null) {
      promoterHolding = [];
      json['promoterHolding'].forEach((v) {
        promoterHolding?.add(PromoterHolding.fromJson(v));
      });
    }
    if (json['financialData'] != null) {
      financialData = [];
      json['financialData'].forEach((v) {
        financialData?.add(FinancialData.fromJson(v));
      });
    }
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    registrar = json['registrar'] != null ? Registrar.fromJson(json['registrar']) : null;
    subscription =
        json['subscription'] != null ? Subscription.fromJson(json['subscription']) : null;
    if (json['gmpData'] != null) {
      gmpData = [];
      json['gmpData'].forEach((v) {
        gmpData?.add(GmpData.fromJson(v));
      });
    }
    if (json['news'] != null) {
      news = [];
      json['news'].forEach((v) {
        news?.add(News.fromJson(v));
      });
    }
  }
  String? logo;
  List<String>? summary;
  List<String>? about;
  List<DocLinks>? docLinks;
  List<IpoDetails>? ipoDetails;
  List<PromoterHolding>? promoterHolding;
  List<FinancialData>? financialData;
  Address? address;
  Registrar? registrar;
  Subscription? subscription;
  List<GmpData>? gmpData;
  List<News>? news;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['logo'] = logo;
    map['summary'] = summary;
    map['about'] = about;
    if (docLinks != null) {
      map['docLinks'] = docLinks?.map((v) => v.toJson()).toList();
    }
    if (ipoDetails != null) {
      map['ipoDetails'] = ipoDetails?.map((v) => v.toJson()).toList();
    }
    if (promoterHolding != null) {
      map['promoterHolding'] = promoterHolding?.map((v) => v.toJson()).toList();
    }
    if (financialData != null) {
      map['financialData'] = financialData?.map((v) => v.toJson()).toList();
    }
    if (address != null) {
      map['address'] = address?.toJson();
    }
    if (registrar != null) {
      map['registrar'] = registrar?.toJson();
    }
    if (subscription != null) {
      map['subscription'] = subscription?.toJson();
    }
    if (gmpData != null) {
      map['gmpData'] = gmpData?.map((v) => v.toJson()).toList();
    }
    if (news != null) {
      map['news'] = news?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class News {
  News({
    this.title,
    this.url,
    this.timestamp,
    this.subtitle,
    this.publishedBy,
  });

  News.fromJson(dynamic json) {
    title = json['title'];
    url = json['url'];
    timestamp = json['timestamp'];
    subtitle = json['subtitle'];
    publishedBy = json['publishedBy'];
  }
  String? title;
  String? url;
  String? timestamp;
  String? subtitle;
  String? publishedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['url'] = url;
    map['timestamp'] = timestamp;
    map['subtitle'] = subtitle;
    map['publishedBy'] = publishedBy;
    return map;
  }
}

class GmpData {
  GmpData({
    this.gmpDate,
    this.ipoPrice,
    this.gmp,
    this.sub2Sauda,
    this.estimatedListingPrice,
    this.lastUpdated,
    this.badge,
    this.status,
  });

  GmpData.fromJson(dynamic json) {
    gmpDate = json['gmpDate'];
    ipoPrice = json['ipoPrice'];
    gmp = json['gmp'];
    sub2Sauda = json['sub2Sauda'];
    estimatedListingPrice = json['estimatedListingPrice'];
    lastUpdated = json['lastUpdated'];
    badge = json['badge'];
    status = json['status'];
  }
  String? gmpDate;
  String? ipoPrice;
  String? gmp;
  String? sub2Sauda;
  String? estimatedListingPrice;
  String? lastUpdated;
  String? badge;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gmpDate'] = gmpDate;
    map['ipoPrice'] = ipoPrice;
    map['gmp'] = gmp;
    map['sub2Sauda'] = sub2Sauda;
    map['estimatedListingPrice'] = estimatedListingPrice;
    map['lastUpdated'] = lastUpdated;
    map['badge'] = badge;
    map['status'] = status;
    return map;
  }
}

class Subscription {
  Subscription({
    this.subscriptionData,
  });

  Subscription.fromJson(dynamic json) {
    if (json['subscriptionData'] != null) {
      subscriptionData = [];
      json['subscriptionData'].forEach((v) {
        subscriptionData?.add(SubscriptionData.fromJson(v));
      });
    }
  }
  List<SubscriptionData>? subscriptionData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (subscriptionData != null) {
      map['subscriptionData'] = subscriptionData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class SubscriptionData {
  SubscriptionData({
    this.investorCategory,
    this.subscriptionTimes,
    this.sharesOffered,
    this.sharesBidFor,
  });

  SubscriptionData.fromJson(dynamic json) {
    investorCategory = json['investorCategory'];
    subscriptionTimes = json['subscriptionTimes'];
    sharesOffered = json['sharesOffered'];
    sharesBidFor = json['sharesBidFor'];
  }
  String? investorCategory;
  String? subscriptionTimes;
  String? sharesOffered;
  String? sharesBidFor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['investorCategory'] = investorCategory;
    map['subscriptionTimes'] = subscriptionTimes;
    map['sharesOffered'] = sharesOffered;
    map['sharesBidFor'] = sharesBidFor;
    return map;
  }
}

class Registrar {
  Registrar({
    this.name,
    this.phone,
    this.email,
    this.website,
  });

  Registrar.fromJson(dynamic json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
  }
  String? name;
  String? phone;
  String? email;
  String? website;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    map['website'] = website;
    return map;
  }
}

class Address {
  Address({
    this.name,
    this.address,
    this.phone,
    this.email,
    this.website,
  });

  Address.fromJson(dynamic json) {
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
  }
  String? name;
  String? address;
  String? phone;
  String? email;
  String? website;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['address'] = address;
    map['phone'] = phone;
    map['email'] = email;
    map['website'] = website;
    return map;
  }
}

class FinancialData {
  FinancialData({
    this.key,
    this.values,
  });

  FinancialData.fromJson(dynamic json) {
    key = json['key'];
    values = json['values'] != null ? json['values'].cast<String>() : [];
  }
  String? key;
  List<String>? values;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['values'] = values;
    return map;
  }
}

class PromoterHolding {
  PromoterHolding({
    this.key,
    this.value,
  });

  PromoterHolding.fromJson(dynamic json) {
    key = json['key'];
    value = json['value'];
  }
  String? key;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['value'] = value;
    return map;
  }
}

class IpoDetails {
  IpoDetails({
    this.key,
    this.value,
  });

  IpoDetails.fromJson(dynamic json) {
    key = json['key'];
    value = json['value'];
  }
  String? key;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['value'] = value;
    return map;
  }
}

class DocLinks {
  DocLinks({
    this.name,
    this.link,
  });

  DocLinks.fromJson(dynamic json) {
    name = json['name'];
    link = json['link'];
  }
  String? name;
  String? link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['link'] = link;
    return map;
  }
}
