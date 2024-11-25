import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/errors/failure.dart';
import '../../../core/services/api_service.dart';
import '../../home_screen/models/Conversation.dart';

class ArchivesRepo {
  Future <Either<Failure,List<Conversation>>> getMyConversations ()async{
    try{
      var res = await ApiService.getData(endPoint: ApiService.archive);
      List<Conversation> list=[];
      res['data']['conversations'].forEach((x)=> list.add(Conversation.fromJson(x)));
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