import 'package:alsewar/core/local_storage/secure_storage.dart';
import 'package:alsewar/features/auth/data/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;
  bool isAdmin = false;
  auth({required String phone,required String password})async{
    emit(AuthLoading());
    var res = await authRepo.auth(phone: phone, password: password);
    res.fold((failure) {
      emit(AuthFailure(errorMessage: failure.errorMessage));
    }, (map){
      isAdmin = map['role']==1;
      SecureStorage.setToken(map['access_token']);
      emit(AuthSuccess());
    });
  }
}
