class User {
  User({
      this.id, 
      this.name, 
      this.email, 
      this.phone, 
      this.online,});

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    online = json['online'];
  }
  num? id;
  String? name;
  String? email;
  String? phone;
  num? online;
User copyWith({  num? id,
  String? name,
  String? email,
  String? phone,
  num? online,
}) => User(  id: id ?? this.id,
  name: name ?? this.name,
  email: email ?? this.email,
  phone: phone ?? this.phone,
  online: online ?? this.online,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['online'] = online;
    return map;
  }

}