class Replies {
  Replies({
      this.id, 
      this.template,});

  Replies.fromJson(dynamic json) {
    id = json['id'];
    template = json['template'];
  }
  num? id;
  String? template;
Replies copyWith({  num? id,
  String? template,
}) => Replies(  id: id ?? this.id,
  template: template ?? this.template,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['template'] = template;
    return map;
  }

}