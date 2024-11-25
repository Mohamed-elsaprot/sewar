import 'package:alsewar/features/splash/model/User.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/errors/failure.dart';
import '../../../core/services/api_service.dart';

class UserRepo{
  Future <Either<Failure,User>> getMyConversations ()async{
    try{
      var res = await ApiService.getData(endPoint: ApiService.usersInfo);
      User user = User.fromJson(res['data']['user']);
      return right(user);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }else{
        return left(ServerFailure('حدث خطأ من فضلك حاول لاحقا'));
      }
    }
  }
}