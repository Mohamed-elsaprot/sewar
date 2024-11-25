class Pages {
  Pages({
      this.id, 
      this.name, 
      this.title, 
      this.content,});

  Pages.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    content = json['content'];
  }
  num? id;
  String? name;
  String? title;
  String? content;
Pages copyWith({  num? id,
  String? name,
  String? title,
  String? content,
}) => Pages(  id: id ?? this.id,
  name: name ?? this.name,
  title: title ?? this.title,
  content: content ?? this.content,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['title'] = title;
    map['content'] = content;
    return map;
  }

}