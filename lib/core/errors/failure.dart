
import 'package:dio/dio.dart';

abstract class Failure{
  final String errorMessage;
  const Failure(this.errorMessage);
}

class ServerFailure extends Failure{
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioException dioError){
    switch(dioError.type){

      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');

      case DioExceptionType.badCertificate:
        return ServerFailure('There was BadCertificate error');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioError.response!.statusCode, dioError.response!.data);

      case DioExceptionType.cancel:
        return ServerFailure('Request with Api was canceled');

      case DioExceptionType.connectionError:
        return ServerFailure('There was connection error');

      case DioExceptionType.unknown:
        return ServerFailure('Something wrong in connection !');

      default:
        return ServerFailure('Unexpected problem, Please try again !');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic res){
    if(statusCode == 400||statusCode == 401||statusCode == 403){
      return ServerFailure(res['data']['message']);
    }else if(statusCode == 404){
      return ServerFailure('Your request not found, Please try later!');
    }else if(statusCode == 500){
      return ServerFailure('Internal server error, Please try later!');
    }else{
      return ServerFailure('Opps There was an error, PLease try again!');
    }
  }


}