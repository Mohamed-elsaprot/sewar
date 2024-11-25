import 'package:alsewar/features/splash/data/user_repo.dart';
import 'package:alsewar/features/splash/manager/user_info_state.dart';
import 'package:alsewar/features/splash/model/User.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit(this.repo) : super(UserInfoInitial());
  final UserRepo repo;
  late User user;
  Future getUserInfo()async{
    emit(UserInfoLoading());
    var res = await repo.getMyConversations();
    res.fold((failure)=>emit(UserInfoFailure(errorMessage: failure.errorMessage)), (user){
      this.user=user;
      emit(UserInfoSuccess());
    });
  }
}
