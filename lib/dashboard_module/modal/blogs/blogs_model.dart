class BlogsModel {
  BlogsModel({
      this.articles,});

  BlogsModel.fromJson(dynamic json) {
    if (json['articles'] != null) {
      articles = [];
      json['articles'].forEach((v) {
        articles?.add(Articles.fromJson(v));
      });
    }
  }
  List<Articles>? articles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (articles != null) {
      map['articles'] = articles?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Articles {
  Articles({
      this.title, 
      this.link, 
      this.image, 
      this.date,});

  Articles.fromJson(dynamic json) {
    title = json['title'];
    link = json['link'];
    image = json['image'];
    date = json['date'];
  }
  String? title;
  String? link;
  String? image;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['link'] = link;
    map['image'] = image;
    map['date'] = date;
    return map;
  }

}