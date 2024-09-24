class SearchModal {
  SearchModal({
      this.content,});

  SearchModal.fromJson(dynamic json) {
    if (json['content'] != null) {
      content = [];
      json['content'].forEach((v) {
        content?.add(Content.fromJson(v));
      });
    }
  }
  List<Content>? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (content != null) {
      map['content'] = content?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Content {
  Content({
      this.id, 
      this.isin, 
      this.expiry, 
      this.title, 
      this.underlyingSearchId, 
      this.searchId, 
      this.entityType,});

  Content.fromJson(dynamic json) {
    id = json['id'];
    isin = json['isin'];
    expiry = json['expiry'];
    title = json['title'];
    underlyingSearchId = json['underlying_search_id'];
    searchId = json['search_id'];
    entityType = json['entity_type'];
  }
  String? id;
  dynamic isin;
  dynamic expiry;
  String? title;
  dynamic underlyingSearchId;
  String? searchId;
  String? entityType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['isin'] = isin;
    map['expiry'] = expiry;
    map['title'] = title;
    map['underlying_search_id'] = underlyingSearchId;
    map['search_id'] = searchId;
    map['entity_type'] = entityType;
    return map;
  }

}