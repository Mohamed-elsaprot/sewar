import 'package:alsewar/features/tem_messages/data/temp_message_repo.dart';
import 'package:alsewar/features/tem_messages/manager/temp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/TempCategory.dart';

class TempCubit extends Cubit<TempState> {
  TempCubit(this.repo) : super(TempInitial());
  final TempMessageRepo repo;
  List<TempCategory> tempsCatList=[];

  int selectedCatIndex=0;
  int selectedMessageIndex=-1;

  Future getTemps()async{
    emit(TempLoading());
    var res = await repo.getTemps();
    res.fold((failure)=>emit(TempFailure(errorMessage: failure.errorMessage)), (list){
      tempsCatList=list;
      emit(TempSuccess());
    });
  }
}
