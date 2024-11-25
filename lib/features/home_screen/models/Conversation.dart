import 'ConversationLastMessage.dart';

class Conversation {
  Conversation({
      this.id, 
      this.userId, 
      this.guestId, 
      this.userName, 
      this.guestName, 
      this.status, 
      this.createdAt, 
      this.isBlocked,
      this.conversationLastMessage,});

  Conversation.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    guestId = json['guest_id'];
    userName = json['user_name'];
    guestName = json['guest_name'];
    status = json['status'];
    createdAt = json['created_at'];
    isBlocked = json['is_blocked'];
    conversationLastMessage = json['conversation_last_message'] != null ? ConversationLastMessage.fromJson(json['conversation_last_message']) : null;
  }
  num? id;
  num? userId;
  num? guestId;
  String? userName;
  String? guestName;
  num? status;
  String? createdAt;
  bool? isBlocked;
  ConversationLastMessage? conversationLastMessage;

}