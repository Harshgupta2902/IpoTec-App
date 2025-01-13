class MmiModel {
  MmiModel({
      this.success, 
      this.data, 
      this.message,});

  MmiModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }
  bool? success;
  Data? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message'] = message;
    return map;
  }

}

class Data {
  Data({
      this.date, 
      this.fii, 
      this.skew, 
      this.momentum, 
      this.goldOnNifty, 
      this.gold, 
      this.nifty, 
      this.extrema, 
      this.fma, 
      this.sma, 
      this.trin, 
      this.indicator, 
      this.raw, 
      this.vix, 
      this.lastDay, 
      this.lastWeek, 
      this.lastMonth, 
      this.lastYear, 
      this.currentValue, 
      this.daily,});

  Data.fromJson(dynamic json) {
    date = json['date'];
    fii = json['fii'];
    skew = json['skew'];
    momentum = json['momentum'];
    goldOnNifty = json['goldOnNifty'];
    gold = json['gold'];
    nifty = json['nifty'];
    extrema = json['extrema'];
    fma = json['fma'];
    sma = json['sma'];
    trin = json['trin'];
    indicator = json['indicator'];
    raw = json['raw'];
    vix = json['vix'];
    lastDay = json['lastDay'] != null ? LastDay.fromJson(json['lastDay']) : null;
    lastWeek = json['lastWeek'] != null ? LastWeek.fromJson(json['lastWeek']) : null;
    lastMonth = json['lastMonth'] != null ? LastMonth.fromJson(json['lastMonth']) : null;
    lastYear = json['lastYear'] != null ? LastYear.fromJson(json['lastYear']) : null;
    currentValue = json['currentValue'];
    if (json['daily'] != null) {
      daily = [];
      json['daily'].forEach((v) {
        daily?.add(Daily.fromJson(v));
      });
    }
  }
  String? date;
  num? fii;
  num? skew;
  num? momentum;
  num? goldOnNifty;
  num? gold;
  num? nifty;
  num? extrema;
  num? fma;
  num? sma;
  num? trin;
  num? indicator;
  num? raw;
  num? vix;
  LastDay? lastDay;
  LastWeek? lastWeek;
  LastMonth? lastMonth;
  LastYear? lastYear;
  num? currentValue;
  List<Daily>? daily;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['fii'] = fii;
    map['skew'] = skew;
    map['momentum'] = momentum;
    map['goldOnNifty'] = goldOnNifty;
    map['gold'] = gold;
    map['nifty'] = nifty;
    map['extrema'] = extrema;
    map['fma'] = fma;
    map['sma'] = sma;
    map['trin'] = trin;
    map['indicator'] = indicator;
    map['raw'] = raw;
    map['vix'] = vix;
    if (lastDay != null) {
      map['lastDay'] = lastDay?.toJson();
    }
    if (lastWeek != null) {
      map['lastWeek'] = lastWeek?.toJson();
    }
    if (lastMonth != null) {
      map['lastMonth'] = lastMonth?.toJson();
    }
    if (lastYear != null) {
      map['lastYear'] = lastYear?.toJson();
    }
    map['currentValue'] = currentValue;
    if (daily != null) {
      map['daily'] = daily?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Daily {
  Daily({
      this.value, 
      this.date,});

  Daily.fromJson(dynamic json) {
    value = json['value'];
    date = json['date'];
  }
  num? value;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['date'] = date;
    return map;
  }

}

class LastYear {
  LastYear({
      this.fii, 
      this.skew, 
      this.nifty, 
      this.gold, 
      this.goldOnNifty, 
      this.date, 
      this.extrema, 
      this.trin, 
      this.fma, 
      this.sma, 
      this.momentum, 
      this.vix, 
      this.raw, 
      this.indicator,});

  LastYear.fromJson(dynamic json) {
    fii = json['fii'];
    skew = json['skew'];
    nifty = json['nifty'];
    gold = json['gold'];
    goldOnNifty = json['goldOnNifty'];
    date = json['date'];
    extrema = json['extrema'];
    trin = json['trin'];
    fma = json['fma'];
    sma = json['sma'];
    momentum = json['momentum'];
    vix = json['vix'];
    raw = json['raw'];
    indicator = json['indicator'];
  }
  num? fii;
  num? skew;
  num? nifty;
  num? gold;
  num? goldOnNifty;
  String? date;
  num? extrema;
  num? trin;
  num? fma;
  num? sma;
  num? momentum;
  num? vix;
  num? raw;
  num? indicator;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fii'] = fii;
    map['skew'] = skew;
    map['nifty'] = nifty;
    map['gold'] = gold;
    map['goldOnNifty'] = goldOnNifty;
    map['date'] = date;
    map['extrema'] = extrema;
    map['trin'] = trin;
    map['fma'] = fma;
    map['sma'] = sma;
    map['momentum'] = momentum;
    map['vix'] = vix;
    map['raw'] = raw;
    map['indicator'] = indicator;
    return map;
  }

}

class LastMonth {
  LastMonth({
      this.date, 
      this.fii, 
      this.skew, 
      this.momentum, 
      this.goldOnNifty, 
      this.gold, 
      this.nifty, 
      this.extrema, 
      this.fma, 
      this.sma, 
      this.trin, 
      this.indicator, 
      this.raw, 
      this.vix,});

  LastMonth.fromJson(dynamic json) {
    date = json['date'];
    fii = json['fii'];
    skew = json['skew'];
    momentum = json['momentum'];
    goldOnNifty = json['goldOnNifty'];
    gold = json['gold'];
    nifty = json['nifty'];
    extrema = json['extrema'];
    fma = json['fma'];
    sma = json['sma'];
    trin = json['trin'];
    indicator = json['indicator'];
    raw = json['raw'];
    vix = json['vix'];
  }
  String? date;
  num? fii;
  num? skew;
  num? momentum;
  num? goldOnNifty;
  num? gold;
  num? nifty;
  num? extrema;
  num? fma;
  num? sma;
  num? trin;
  num? indicator;
  num? raw;
  num? vix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['fii'] = fii;
    map['skew'] = skew;
    map['momentum'] = momentum;
    map['goldOnNifty'] = goldOnNifty;
    map['gold'] = gold;
    map['nifty'] = nifty;
    map['extrema'] = extrema;
    map['fma'] = fma;
    map['sma'] = sma;
    map['trin'] = trin;
    map['indicator'] = indicator;
    map['raw'] = raw;
    map['vix'] = vix;
    return map;
  }

}

class LastWeek {
  LastWeek({
      this.date, 
      this.fii, 
      this.skew, 
      this.momentum, 
      this.goldOnNifty, 
      this.gold, 
      this.nifty, 
      this.extrema, 
      this.fma, 
      this.sma, 
      this.trin, 
      this.indicator, 
      this.raw, 
      this.vix,});

  LastWeek.fromJson(dynamic json) {
    date = json['date'];
    fii = json['fii'];
    skew = json['skew'];
    momentum = json['momentum'];
    goldOnNifty = json['goldOnNifty'];
    gold = json['gold'];
    nifty = json['nifty'];
    extrema = json['extrema'];
    fma = json['fma'];
    sma = json['sma'];
    trin = json['trin'];
    indicator = json['indicator'];
    raw = json['raw'];
    vix = json['vix'];
  }
  String? date;
  num? fii;
  num? skew;
  num? momentum;
  num? goldOnNifty;
  num? gold;
  num? nifty;
  num? extrema;
  num? fma;
  num? sma;
  num? trin;
  num? indicator;
  num? raw;
  num? vix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['fii'] = fii;
    map['skew'] = skew;
    map['momentum'] = momentum;
    map['goldOnNifty'] = goldOnNifty;
    map['gold'] = gold;
    map['nifty'] = nifty;
    map['extrema'] = extrema;
    map['fma'] = fma;
    map['sma'] = sma;
    map['trin'] = trin;
    map['indicator'] = indicator;
    map['raw'] = raw;
    map['vix'] = vix;
    return map;
  }

}

class LastDay {
  LastDay({
      this.date, 
      this.fii, 
      this.skew, 
      this.momentum, 
      this.goldOnNifty, 
      this.gold, 
      this.nifty, 
      this.extrema, 
      this.fma, 
      this.sma, 
      this.trin, 
      this.indicator, 
      this.raw, 
      this.vix,});

  LastDay.fromJson(dynamic json) {
    date = json['date'];
    fii = json['fii'];
    skew = json['skew'];
    momentum = json['momentum'];
    goldOnNifty = json['goldOnNifty'];
    gold = json['gold'];
    nifty = json['nifty'];
    extrema = json['extrema'];
    fma = json['fma'];
    sma = json['sma'];
    trin = json['trin'];
    indicator = json['indicator'];
    raw = json['raw'];
    vix = json['vix'];
  }
  String? date;
  num? fii;
  num? skew;
  num? momentum;
  num? goldOnNifty;
  num? gold;
  num? nifty;
  num? extrema;
  num? fma;
  num? sma;
  num? trin;
  num? indicator;
  num? raw;
  num? vix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['fii'] = fii;
    map['skew'] = skew;
    map['momentum'] = momentum;
    map['goldOnNifty'] = goldOnNifty;
    map['gold'] = gold;
    map['nifty'] = nifty;
    map['extrema'] = extrema;
    map['fma'] = fma;
    map['sma'] = sma;
    map['trin'] = trin;
    map['indicator'] = indicator;
    map['raw'] = raw;
    map['vix'] = vix;
    return map;
  }

}