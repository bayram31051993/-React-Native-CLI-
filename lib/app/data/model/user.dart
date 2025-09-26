class UserModel {
  List<UserDataModel>? data;
  dynamic status;

  UserModel({this.data, this.status});

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserDataModel>[];
      json['data'].forEach((v) {
        data!.add(UserDataModel.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class UserDataModel {
  String? id;
  String? logo;
  Coordinates? coordinates;
  String? address;
  String? companyName;
  String? dateStartByCity;
  String? timeStartByCity;
  String? timeEndByCity;
  dynamic currentWorkers;
  dynamic planWorkers;
  List<WorkTypes>? workTypes;
  dynamic priceWorker;
  dynamic bonusPriceWorker;
  String? customerFeedbacksCount;
  dynamic customerRating;
  bool? isPromotionEnabled;

  UserDataModel({
    this.id,
    this.logo,
    this.coordinates,
    this.address,
    this.companyName,
    this.dateStartByCity,
    this.timeStartByCity,
    this.timeEndByCity,
    this.currentWorkers,
    this.planWorkers,
    this.workTypes,
    this.priceWorker,
    this.bonusPriceWorker,
    this.customerFeedbacksCount,
    this.customerRating,
    this.isPromotionEnabled,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    coordinates = json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'])
        : null;
    address = json['address'];
    companyName = json['companyName'];
    dateStartByCity = json['dateStartByCity'];
    timeStartByCity = json['timeStartByCity'];
    timeEndByCity = json['timeEndByCity'];
    currentWorkers = json['currentWorkers'];
    planWorkers = json['planWorkers'];
    if (json['workTypes'] != null) {
      workTypes = <WorkTypes>[];
      json['workTypes'].forEach((v) {
        workTypes!.add(WorkTypes.fromJson(v));
      });
    }
    priceWorker = json['priceWorker'];
    bonusPriceWorker = json['bonusPriceWorker'];
    customerFeedbacksCount = json['customerFeedbacksCount'];
    customerRating = json['customerRating'];
    isPromotionEnabled = json['isPromotionEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['logo'] = logo;
    if (coordinates != null) {
      data['coordinates'] = coordinates!.toJson();
    }
    data['address'] = address;
    data['companyName'] = companyName;
    data['dateStartByCity'] = dateStartByCity;
    data['timeStartByCity'] = timeStartByCity;
    data['timeEndByCity'] = timeEndByCity;
    data['currentWorkers'] = currentWorkers;
    data['planWorkers'] = planWorkers;
    if (workTypes != null) {
      data['workTypes'] = workTypes!.map((v) => v.toJson()).toList();
    }
    data['priceWorker'] = priceWorker;
    data['bonusPriceWorker'] = bonusPriceWorker;
    data['customerFeedbacksCount'] = customerFeedbacksCount;
    data['customerRating'] = customerRating;
    data['isPromotionEnabled'] = isPromotionEnabled;
    return data;
  }
}

class Coordinates {
  double? longitude;
  double? latitude;

  Coordinates({this.longitude, this.latitude});

  Coordinates.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}

class WorkTypes {
  dynamic id;
  String? name;
  String? nameGt5;
  String? nameLt5;
  String? nameOne;

  WorkTypes({this.id, this.name, this.nameGt5, this.nameLt5, this.nameOne});

  WorkTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameGt5 = json['nameGt5'];
    nameLt5 = json['nameLt5'];
    nameOne = json['nameOne'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['nameGt5'] = nameGt5;
    data['nameLt5'] = nameLt5;
    data['nameOne'] = nameOne;
    return data;
  }
}
