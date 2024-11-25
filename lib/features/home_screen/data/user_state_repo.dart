import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/errors/failure.dart';
import '../../../core/services/api_service.dart';

class UserStateRepo {
  Future <Either<Failure,Map>> updateUserState()async{
    try{
      var res = await ApiService.postData(endPoint: ApiService.updateUserState,postedData: {});
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