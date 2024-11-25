import 'package:alsewar/features/tem_messages/models/TempCategory.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/errors/failure.dart';
import '../../../core/services/api_service.dart';

class TempMessageRepo{
  Future<Either<Failure, List<TempCategory>>> getTemps() async {
    try {
      var res = await ApiService.getData(endPoint: ApiService.tempMessages);
      List<TempCategory> list=[];
      res['data']['categories'].forEach((x)=>list.add(TempCategory.fromJson(x)));
      return right(list);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure('حدث خطأ من فضلك حاول لاحقا'));
      }
    }
  }
}