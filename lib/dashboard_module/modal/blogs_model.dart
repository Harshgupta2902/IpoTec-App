class BlogsModel {
  BlogsModel({
    this.data,
    this.count,
  });

  BlogsModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    count = json['count'];
  }
  List<Data>? data;
  num? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['count'] = count;
    return map;
  }
}

class Data {
  Data({
    this.title,
    this.slug,
    this.publishedDateLegacy,
    this.modifiedDateLegacy,
    this.featuredMediaLegacy,
    this.publishedAt,
    this.updatedAt,
    this.featuredMedia,
    this.category,
    this.readingTime,
  });

  Data.fromJson(dynamic json) {
    title = json['title'];
    slug = json['slug'];
    publishedDateLegacy = json['published_date_legacy'];
    modifiedDateLegacy = json['modified_date_legacy'];
    featuredMediaLegacy = json['featured_media_legacy'];
    publishedAt = json['published_at'];
    updatedAt = json['updated_at'];
    featuredMedia = json['featured_media'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    readingTime = json['reading_time'];
  }
  String? title;
  String? slug;
  String? publishedDateLegacy;
  String? modifiedDateLegacy;
  String? featuredMediaLegacy;
  String? publishedAt;
  String? updatedAt;
  dynamic featuredMedia;
  Category? category;
  num? readingTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['slug'] = slug;
    map['published_date_legacy'] = publishedDateLegacy;
    map['modified_date_legacy'] = modifiedDateLegacy;
    map['featured_media_legacy'] = featuredMediaLegacy;
    map['published_at'] = publishedAt;
    map['updated_at'] = updatedAt;
    map['featured_media'] = featuredMedia;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    map['reading_time'] = readingTime;
    return map;
  }
}

class Category {
  Category({
    this.name,
    this.slug,
  });

  Category.fromJson(dynamic json) {
    name = json['name'];
    slug = json['slug'];
  }
  String? name;
  String? slug;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['slug'] = slug;
    return map;
  }
}
