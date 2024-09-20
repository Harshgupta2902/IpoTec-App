class SearchModel {
  SearchModel({
      this.content,});

  SearchModel.fromJson(dynamic json) {
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
      this.analyticsLabel, 
      this.title, 
      this.nseScripCode, 
      this.searchId, 
      this.bseScripCode, 
      this.id, 
      this.isin, 
      this.expiry, 
      this.underlyingSearchId, 
      this.entityType,});

  Content.fromJson(dynamic json) {
    analyticsLabel = json['analytics_label'];
    title = json['title'];
    nseScripCode = json['nse_scrip_code'];
    searchId = json['search_id'];
    bseScripCode = json['bse_scrip_code'];
    id = json['id'];
    isin = json['isin'];
    expiry = json['expiry'];
    underlyingSearchId = json['underlying_search_id'];
    entityType = json['entity_type'];
  }
  String? analyticsLabel;
  String? title;
  dynamic nseScripCode;
  String? searchId;
  dynamic bseScripCode;
  String? id;
  dynamic isin;
  dynamic expiry;
  dynamic underlyingSearchId;
  String? entityType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['analytics_label'] = analyticsLabel;
    map['title'] = title;
    map['nse_scrip_code'] = nseScripCode;
    map['search_id'] = searchId;
    map['bse_scrip_code'] = bseScripCode;
    map['id'] = id;
    map['isin'] = isin;
    map['expiry'] = expiry;
    map['underlying_search_id'] = underlyingSearchId;
    map['entity_type'] = entityType;
    return map;
  }

}