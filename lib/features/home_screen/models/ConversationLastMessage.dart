class ConversationLastMessage {
  ConversationLastMessage({
      this.id, 
      this.userId, 
      this.guestId, 
      this.conversationId, 
      this.message, 
      this.file, 
      this.readed, 
      this.createdAt,});

  ConversationLastMessage.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    guestId = json['guest_id'];
    conversationId = json['conversation_id'];
    message = json['message'];
    file = json['file'];
    readed = json['readed'];
    createdAt = json['created_at'];
  }
  num? id;
  num? userId;
  dynamic guestId;
  num? conversationId;
  String? message;
  dynamic file;
  num? readed;
  String? createdAt;
ConversationLastMessage copyWith({  num? id,
  num? userId,
  dynamic guestId,
  num? conversationId,
  String? message,
  dynamic file,
  num? readed,
  String? createdAt,
}) => ConversationLastMessage(  id: id ?? this.id,
  userId: userId ?? this.userId,
  guestId: guestId ?? this.guestId,
  conversationId: conversationId ?? this.conversationId,
  message: message ?? this.message,
  file: file ?? this.file,
  readed: readed ?? this.readed,
  createdAt: createdAt ?? this.createdAt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['guest_id'] = guestId;
    map['conversation_id'] = conversationId;
    map['message'] = message;
    map['file'] = file;
    map['readed'] = readed;
    map['created_at'] = createdAt;
    return map;
  }

}