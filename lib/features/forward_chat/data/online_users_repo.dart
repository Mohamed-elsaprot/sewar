import 'package:alsewar/features/forward_chat/models/OnlineUser.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/errors/failure.dart';
import '../../../core/services/api_service.dart';

class OnlineUsersRepo {
  Future <Either<Failure,List<OnlineUser>>> getOnlineUsers ()async{
    try{
      var res = await ApiService.getData(endPoint: ApiService.onlineUsers);
      List<OnlineUser> list=[];
     res['data']['online_users'].forEach((x)=>list.add(OnlineUser.fromJson(x)));
      return right(list);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }else{
        return left(ServerFailure('حدث خطأ من فضلك حاول لاحقا'));
      }
    }
  }

  Future <Either<Failure,Map>> forwardChat({required num chatId, required num userId})async{
    try{
      var res = await ApiService.postData(endPoint: ApiService.forwardChat,postedData: {
        "conversation_id" : chatId,
        "user_id" : userId
      });
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