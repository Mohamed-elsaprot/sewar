import 'package:alsewar/core/errors/failure.dart';
import 'package:alsewar/core/services/api_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthRepo {
  Future <Either<Failure,Map>> auth ({required String phone, required String password})async{
    try{
      var res = await ApiService.postData(endPoint: ApiService.auth, postedData: {
        'phone_number':phone,
        'password':password,
      });
      return right(res['data']);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }else{
        return left(ServerFailure('حدث خطأ من فضلك حاول لاحقا'));
      }
    }
  }
}