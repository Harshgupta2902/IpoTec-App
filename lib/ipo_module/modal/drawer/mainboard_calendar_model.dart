class MainboardCalendarModel {
  MainboardCalendarModel({
      this.success, 
      this.data,});

  MainboardCalendarModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      this.day, 
      this.events,});

  Data.fromJson(dynamic json) {
    day = json['day'];
    if (json['events'] != null) {
      events = [];
      json['events'].forEach((v) {
        events?.add(Events.fromJson(v));
      });
    }
  }
  String? day;
  List<Events>? events;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    if (events != null) {
      map['events'] = events?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Events {
  Events({
      this.eventText, 
      this.eventLink,});

  Events.fromJson(dynamic json) {
    eventText = json['eventText'];
    eventLink = json['eventLink'];
  }
  String? eventText;
  String? eventLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventText'] = eventText;
    map['eventLink'] = eventLink;
    return map;
  }

}