import 'package:dio/dio.dart';

class ApiService {
  static const baseUrl = 'https://assiwar.com/api/v1/';
  static const auth = 'users/login';
  static const myConversations = 'conversations';
  static const othersConversations = 'conversations/others';
  static const chatBody = 'conversations/chat/messages?conversation_id=';
  static const updateMessages = 'conversations/chat/new_messages?conversation_id=';
  static const usersInfo = 'users/info';
  static const sendMessage = 'conversations/chat/send';
  static const onlineUsers = 'users/online';
  static const forwardChat = 'conversations/transfer';
  static const closeConversation = 'conversations/close';
  static const updateUserState = 'users/online/status';
  static const blockChat = 'conversations/close';
  static const archive = 'conversations/archive';
  static const block = 'conversations/chat/guest/block';
  static const tempMessages = 'conversations/chat/reply_templates';
  static const settings = 'settings';

  static final Dio _dio = Dio(
    BaseOptions(
        headers: {'Content-Type': 'application/json'},
        receiveDataWhenStatusError: true),
  );

  static updateHeader(Map<String,dynamic> map){
    _dio.options.headers.addAll(map);
  }

  static Future postData({required String endPoint, required postedData}) async {
    Response res = await _dio.post(baseUrl + endPoint, data: postedData);
    return res.data;
  }

  static Future getData({required String endPoint,String? link,}) async {
    Response res = await _dio.get(
     link?? (baseUrl + endPoint),
    );
    return res.data;
  }

  static Future delete({required String endPoint}) async {
    var res = await _dio.delete(baseUrl + endPoint);
    return res.data;
  }

  static Future update({required String endPoint, required Map body}) async {
    Response res = await _dio.put(baseUrl + endPoint, data: body);
    return res.data;
  }

}