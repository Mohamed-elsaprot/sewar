import 'package:alsewar/features/settings/models/SettingsModel.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/errors/failure.dart';
import '../../../core/services/api_service.dart';

class SettingsRepo{
  Future <Either<Failure,SettingsModel>> getSettings()async{
    try{
      var res = await ApiService.getData(endPoint: ApiService.settings);
      SettingsModel model = SettingsModel.fromJson(res['data']);
      return right(model);
    }catch(e){
      if(e is DioException){
        return left(ServerFailure.fromDioError(e));
      }else{
        return left(ServerFailure('حدث خطأ من فضلك حاول لاحقا'));
      }
    }
  }
}