import 'Pages.dart';

class SettingsModel {
  SettingsModel({
      this.phoneNumber, 
      this.pages,});

  SettingsModel.fromJson(dynamic json) {
    phoneNumber = json['phone_number'];
    if (json['pages'] != null) {
      pages = [];
      json['pages'].forEach((v) {
        pages?.add(Pages.fromJson(v));
      });
    }
  }
  String? phoneNumber;
  List<Pages>? pages;
SettingsModel copyWith({  String? phoneNumber,
  List<Pages>? pages,
}) => SettingsModel(  phoneNumber: phoneNumber ?? this.phoneNumber,
  pages: pages ?? this.pages,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone_number'] = phoneNumber;
    if (pages != null) {
      map['pages'] = pages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}