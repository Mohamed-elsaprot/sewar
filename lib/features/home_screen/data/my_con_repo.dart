import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/errors/failure.dart';
import '../../../core/services/api_service.dart';
import '../models/Conversation.dart';

class MyConRepo {
  Future <Either<Failure,List<Conversation>>> getMyConversations ({required bool isMine})async{
    try{
      var res = await ApiService.getData(endPoint: isMine?ApiService.myConversations:ApiService.othersConversations);
      List<Conversation> list=[];
      if(isMine){
        res['data']['new_conversations'].forEach((x)=>list.add(Conversation.fromJson(x)));
        res['data']['conversations'].forEach((x)=> list.add(Conversation.fromJson(x)));
      }else{
        res['data']['conversations'].forEach((x)=> list.add(Conversation.fromJson(x)));
      }
      return right(list);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }else{
        return left(ServerFailure('حدث خطأ من فضلك حاول لاحقا'));
      }
    }
  }
}