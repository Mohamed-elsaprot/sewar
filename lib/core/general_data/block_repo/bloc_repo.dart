import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../errors/failure.dart';
import '../../services/api_service.dart';

class BlocRepo {
  Future<Either<Failure, dynamic>> blocUser({required num conId}) async {
    try {
      var res = await ApiService.postData(endPoint: ApiService.block, postedData: {"conversation_id" : conId});
      return right(res);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure('حدث خطأ من فضلك حاول لاحقا'));
      }
    }
  }
}
