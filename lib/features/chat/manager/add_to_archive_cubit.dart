import 'package:alsewar/features/chat/data/chat_body_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_to_archive_state.dart';

class AddToArchiveCubit extends Cubit<AddToArchiveState> {
  AddToArchiveCubit(this.repo, this.chatId) : super(AddToArchiveInitial());
  final ChatBodyRepo repo;
  bool taped=false;
  bool secStep=false;
  final num chatId;

  Future addChatToArchive()async{
    emit(AddToArchiveLoading());
    var res = await repo.blockChat(chatId: chatId);
    res.fold(
            (failure)=> emit(BlAddToArchiveFailure(errorMessage: failure.errorMessage)),
            (res)=>emit(AddToArchiveSuccess())
    );
  }
}
