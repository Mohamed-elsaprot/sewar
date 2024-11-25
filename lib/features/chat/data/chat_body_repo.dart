
import 'package:alsewar/features/chat/models/MessageModel.dart';
import 'package:dartz/dartz.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:dio/dio.dart';

import '../../../core/errors/failure.dart';
import '../../../core/services/api_service.dart';

class ChatBodyRepo {
  Future <Either<Failure,Map>> getMyConversations ({required String chatId,required ChatUser user,required guest,String?link})async{
    try{
    // print(ApiService.chatBody+chatId);
      var res = await ApiService.getData(endPoint: ApiService.chatBody+chatId,link: link);
      List<MessageModel> modeList=[];
      List<ChatMessage> chatList=[];
      res['data'].forEach((x) {
        modeList.add(MessageModel.fromJson(x));
        chatList.add(ChatMessage(
          text: x['message'],
          user: x['user_id']!=null?user:guest,
          createdAt: DateTime.tryParse(x['created_at'])??DateTime(2024,1,1,0,0),
        ));
      });
      return right({'messagesModelList':modeList,'chatList':chatList,'next':res['links']['next']});
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }else{
        return left(ServerFailure('حدث خطأ من فضلك حاول لاحقا'));
      }
    }
  }

  Future <Either<Failure,Map>> updateMessages ({required String chatId,required String lastMessageId,required ChatUser user,required guest})async{
    try{
      var res = await ApiService.getData(endPoint: '${ApiService.updateMessages}$chatId${lastMessageId=='-1'?'':'&last_message_id=$lastMessageId'}');
      List<MessageModel> modeList=[];
      List<ChatMessage> chatList=[];
      // print(chatId);
      // print(lastMessageId);
      res['data']['new_messages'].forEach((x) {
        modeList.add(MessageModel.fromJson(x));
        chatList.add(ChatMessage(
          text: x['message'],
          user: x['user_id']!=null?user:guest,
          createdAt: DateTime.tryParse(x['created_at'])??DateTime(2024,1,1,0,0),
        ));
      });
      return right({'messagesModelList':modeList,'chatList':chatList});
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }else{
        return left(ServerFailure('حدث خطأ من فضلك حاول لاحقا'));
      }
    }
  }

  Future <Either<Failure,MessageModel>> sendMessage({required String chatId,required String message})async{
    try{
      var res = await ApiService.postData(endPoint: ApiService.sendMessage,postedData: {
        "conversation_id" : int.parse(chatId),
        "message" : message
      });
      MessageModel model = MessageModel.fromJson(res['data']['message']);
      return right(model);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }else{
        return left(ServerFailure('حدث خطأ من فضلك حاول لاحقا'));
      }
    }
  }

  Future <Either<Failure,dynamic>> blockChat({required num chatId})async{
    try{
      var res = await ApiService.postData(endPoint: ApiService.blockChat,postedData: {"conversation_id" : chatId,});
      return right(res);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }else{
        return left(ServerFailure('حدث خطأ من فضلك حاول لاحقا'));
      }
    }
  }
}