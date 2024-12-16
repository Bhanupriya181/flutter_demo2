import 'dart:convert';
/// statusCode : 200
/// status : "success"
/// message : "Data fetched successfully!"
/// mineralData : [{"mineralID":"79","mineralName":"Iron"},{"mineralID":"12","mineralName":"Manganese"}]
/// unitData : [{"unitId":"79","UnitName":"Unit1"},{"unitId":"12","UnitName":"Unit2"}]
/// coOperativeSocietyData : [{"societyId":"79","societyName":"Socity1"},{"societyId":"12","societyName":"Socity2"}]
/// yearData : [{"yearId":"1","year":"2023"},{"yearId":"2","year":"2024"}]
/// periodData : [{"periodId":"1","period":"January"},{"periodId":"2","period":"February"}]

AddProductionData addProductionDataFromJson(String str) => AddProductionData.fromJson(json.decode(str));
String addProductionDataToJson(AddProductionData data) => json.encode(data.toJson());
class AddProductionData {
  AddProductionData({
      num? statusCode, 
      String? status, 
      String? message, 
      List<MineralData>? mineralData, 
      List<UnitData>? unitData, 
      List<CoOperativeSocietyData>? coOperativeSocietyData, 
      List<YearData>? yearData, 
      List<PeriodData>? periodData,}){
    _statusCode = statusCode;
    _status = status;
    _message = message;
    _mineralData = mineralData;
    _unitData = unitData;
    _coOperativeSocietyData = coOperativeSocietyData;
    _yearData = yearData;
    _periodData = periodData;
}

  AddProductionData.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _status = json['status'];
    _message = json['message'];
    if (json['mineralData'] != null) {
      _mineralData = [];
      json['mineralData'].forEach((v) {
        _mineralData?.add(MineralData.fromJson(v));
      });
    }
    if (json['unitData'] != null) {
      _unitData = [];
      json['unitData'].forEach((v) {
        _unitData?.add(UnitData.fromJson(v));
      });
    }
    if (json['coOperativeSocietyData'] != null) {
      _coOperativeSocietyData = [];
      json['coOperativeSocietyData'].forEach((v) {
        _coOperativeSocietyData?.add(CoOperativeSocietyData.fromJson(v));
      });
    }
    if (json['yearData'] != null) {
      _yearData = [];
      json['yearData'].forEach((v) {
        _yearData?.add(YearData.fromJson(v));
      });
    }
    if (json['periodData'] != null) {
      _periodData = [];
      json['periodData'].forEach((v) {
        _periodData?.add(PeriodData.fromJson(v));
      });
    }
  }
  num? _statusCode;
  String? _status;
  String? _message;
  List<MineralData>? _mineralData;
  List<UnitData>? _unitData;
  List<CoOperativeSocietyData>? _coOperativeSocietyData;
  List<YearData>? _yearData;
  List<PeriodData>? _periodData;
AddProductionData copyWith({  num? statusCode,
  String? status,
  String? message,
  List<MineralData>? mineralData,
  List<UnitData>? unitData,
  List<CoOperativeSocietyData>? coOperativeSocietyData,
  List<YearData>? yearData,
  List<PeriodData>? periodData,
}) => AddProductionData(  statusCode: statusCode ?? _statusCode,
  status: status ?? _status,
  message: message ?? _message,
  mineralData: mineralData ?? _mineralData,
  unitData: unitData ?? _unitData,
  coOperativeSocietyData: coOperativeSocietyData ?? _coOperativeSocietyData,
  yearData: yearData ?? _yearData,
  periodData: periodData ?? _periodData,
);
  num? get statusCode => _statusCode;
  String? get status => _status;
  String? get message => _message;
  List<MineralData>? get mineralData => _mineralData;
  List<UnitData>? get unitData => _unitData;
  List<CoOperativeSocietyData>? get coOperativeSocietyData => _coOperativeSocietyData;
  List<YearData>? get yearData => _yearData;
  List<PeriodData>? get periodData => _periodData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['status'] = _status;
    map['message'] = _message;
    if (_mineralData != null) {
      map['mineralData'] = _mineralData?.map((v) => v.toJson()).toList();
    }
    if (_unitData != null) {
      map['unitData'] = _unitData?.map((v) => v.toJson()).toList();
    }
    if (_coOperativeSocietyData != null) {
      map['coOperativeSocietyData'] = _coOperativeSocietyData?.map((v) => v.toJson()).toList();
    }
    if (_yearData != null) {
      map['yearData'] = _yearData?.map((v) => v.toJson()).toList();
    }
    if (_periodData != null) {
      map['periodData'] = _periodData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// periodId : "1"
/// period : "January"

PeriodData periodDataFromJson(String str) => PeriodData.fromJson(json.decode(str));
String periodDataToJson(PeriodData data) => json.encode(data.toJson());
class PeriodData {
  PeriodData({
      String? periodId, 
      String? period,}){
    _periodId = periodId;
    _period = period;
}

  PeriodData.fromJson(dynamic json) {
    _periodId = json['periodId'];
    _period = json['period'];
  }
  String? _periodId;
  String? _period;
PeriodData copyWith({  String? periodId,
  String? period,
}) => PeriodData(  periodId: periodId ?? _periodId,
  period: period ?? _period,
);
  String? get periodId => _periodId;
  String? get period => _period;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['periodId'] = _periodId;
    map['period'] = _period;
    return map;
  }

}

/// yearId : "1"
/// year : "2023"

YearData yearDataFromJson(String str) => YearData.fromJson(json.decode(str));
String yearDataToJson(YearData data) => json.encode(data.toJson());
class YearData {
  YearData({
      String? yearId, 
      String? year,}){
    _yearId = yearId;
    _year = year;
}

  YearData.fromJson(dynamic json) {
    _yearId = json['yearId'];
    _year = json['year'];
  }
  String? _yearId;
  String? _year;
YearData copyWith({  String? yearId,
  String? year,
}) => YearData(  yearId: yearId ?? _yearId,
  year: year ?? _year,
);
  String? get yearId => _yearId;
  String? get year => _year;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['yearId'] = _yearId;
    map['year'] = _year;
    return map;
  }

}

/// societyId : "79"
/// societyName : "Socity1"

CoOperativeSocietyData coOperativeSocietyDataFromJson(String str) => CoOperativeSocietyData.fromJson(json.decode(str));
String coOperativeSocietyDataToJson(CoOperativeSocietyData data) => json.encode(data.toJson());
class CoOperativeSocietyData {
  CoOperativeSocietyData({
      String? societyId, 
      String? societyName,}){
    _societyId = societyId;
    _societyName = societyName;
}

  CoOperativeSocietyData.fromJson(dynamic json) {
    _societyId = json['societyId'];
    _societyName = json['societyName'];
  }
  String? _societyId;
  String? _societyName;
CoOperativeSocietyData copyWith({  String? societyId,
  String? societyName,
}) => CoOperativeSocietyData(  societyId: societyId ?? _societyId,
  societyName: societyName ?? _societyName,
);
  String? get societyId => _societyId;
  String? get societyName => _societyName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['societyId'] = _societyId;
    map['societyName'] = _societyName;
    return map;
  }

}

/// unitId : "79"
/// UnitName : "Unit1"

UnitData unitDataFromJson(String str) => UnitData.fromJson(json.decode(str));
String unitDataToJson(UnitData data) => json.encode(data.toJson());
class UnitData {
  UnitData({
      String? unitId, 
      String? unitName,}){
    _unitId = unitId;
    _unitName = unitName;
}

  UnitData.fromJson(dynamic json) {
    _unitId = json['unitId'];
    _unitName = json['UnitName'];
  }
  String? _unitId;
  String? _unitName;
UnitData copyWith({  String? unitId,
  String? unitName,
}) => UnitData(  unitId: unitId ?? _unitId,
  unitName: unitName ?? _unitName,
);
  String? get unitId => _unitId;
  String? get unitName => _unitName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unitId'] = _unitId;
    map['UnitName'] = _unitName;
    return map;
  }

}

/// mineralID : "79"
/// mineralName : "Iron"

MineralData mineralDataFromJson(String str) => MineralData.fromJson(json.decode(str));
String mineralDataToJson(MineralData data) => json.encode(data.toJson());
class MineralData {
  MineralData({
      String? mineralID, 
      String? mineralName,}){
    _mineralID = mineralID;
    _mineralName = mineralName;
}

  MineralData.fromJson(dynamic json) {
    _mineralID = json['mineralID'];
    _mineralName = json['mineralName'];
  }
  String? _mineralID;
  String? _mineralName;
MineralData copyWith({  String? mineralID,
  String? mineralName,
}) => MineralData(  mineralID: mineralID ?? _mineralID,
  mineralName: mineralName ?? _mineralName,
);
  String? get mineralID => _mineralID;
  String? get mineralName => _mineralName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mineralID'] = _mineralID;
    map['mineralName'] = _mineralName;
    return map;
  }

}