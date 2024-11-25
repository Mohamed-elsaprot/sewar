import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/my_con_repo.dart';
import '../models/Conversation.dart';
import 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this.repo) : super(ChatsInitial());
  final MyConRepo repo;
  int selectedChat = 0;
  List<Conversation> myConList = [];
  List<Conversation> othersConList = [];
  bool myConFirst = true, otherFirst = true;
  Future getMyCon({required bool isMine}) async {
    emit(ChatsLoading());
    var res = await repo.getMyConversations(isMine: isMine);
    res.fold(
        (failure) => emit(ChatsFailure(errorMessage: failure.errorMessage)),
        (list) {
      isMine ? myConList = list : othersConList = list;
      isMine? myConFirst = false: otherFirst = false;
      emit(ChatsSuccess());
    });
  }
}
