import 'package:alsewar/core/design/fun_widgets.dart';
import 'package:alsewar/features/forward_chat/data/online_users_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/OnlineUser.dart';
import 'online_users_state.dart';

class OnlineUsersCubit extends Cubit<OnlineUsersState> {
  OnlineUsersCubit(this.repo) : super(OnlineUsersInitial());
  final OnlineUsersRepo repo;

  List<OnlineUser> onlineUsersList=[];
  int selected=-1;

  Future getOnlineUsers()async{
    emit(OnlineUsersLoading());
    var res = await repo.getOnlineUsers();
    res.fold((failure)=> emit(OnlineUsersFailure(errorMessage: failure.errorMessage)), (list){
      onlineUsersList = list;
      emit(OnlineUsersSuccess());
    });
  }

  Future forwardChat({required num chatId,required userId,required BuildContext c})async{
    loadingDialog(c);
    var res = await repo.forwardChat(chatId: chatId, userId: userId);
    res.fold((failure) {
      Navigator.pop(c);
      errorDialog(context: c, message: failure.errorMessage);
    }, (map) {
      // Navigator.pop(c);
      // Navigator.pop(c);
    });
  }
}
