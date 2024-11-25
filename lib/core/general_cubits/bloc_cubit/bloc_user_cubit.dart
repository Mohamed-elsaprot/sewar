import 'package:alsewar/core/general_data/block_repo/bloc_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_user_state.dart';

class BlocUserCubit extends Cubit<BlocUserState> {
  BlocUserCubit(this.blocRepo) : super(BlocUserInitial());
  final BlocRepo blocRepo;
  Future blocUser({required num conId,})async{
    emit(BlocUserLoading());
    var res = await blocRepo.blocUser(conId: conId);
    res.fold((failure)=>emit(BlocUserFailure(errorMessage: failure.errorMessage)), (res)=>emit(BlocUserSuccess()));
  }
}
