import 'package:alsewar/core/local_storage/secure_storage.dart';
import 'package:alsewar/features/home_screen/manager/user_state_cubit/user_state_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/user_state_repo.dart';

class UserStateCubit extends Cubit<UserStateState> {
  UserStateCubit(this.repo) : super(UserStateInitial());
  final UserStateRepo repo;
  bool userState = SecureStorage.userState;

  updateUserState()async{
    emit(UserStateLoading());
    var res = await repo.updateUserState();
    res.fold((failure)=>emit(UserStateFailure(errorMessage: failure.errorMessage)), (map) async {
      userState = !userState;
      await SecureStorage.setUserState(userState);
      emit(UserStateSuccess());
    });
  }

}
