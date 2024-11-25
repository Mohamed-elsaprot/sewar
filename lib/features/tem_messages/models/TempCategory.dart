import 'Replies.dart';

class TempCategory {
  TempCategory({
      this.id, 
      this.name, 
      this.replies,});

  TempCategory.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    if (json['replies'] != null) {
      replies = [];
      json['replies'].forEach((v) {
        replies?.add(Replies.fromJson(v));
      });
    }
  }
  num? id;
  String? name;
  List<Replies>? replies;
TempCategory copyWith({  num? id,
  String? name,
  List<Replies>? replies,
}) => TempCategory(  id: id ?? this.id,
  name: name ?? this.name,
  replies: replies ?? this.replies,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (replies != null) {
      map['replies'] = replies?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}