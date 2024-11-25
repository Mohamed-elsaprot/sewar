class OnlineUser {
  OnlineUser({
      this.id, 
      this.name, 
      this.email, 
      this.phone, 
      this.online,});

  OnlineUser.fromJson(dynamic json) {
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
OnlineUser copyWith({  num? id,
  String? name,
  String? email,
  String? phone,
  num? online,
}) => OnlineUser(  id: id ?? this.id,
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