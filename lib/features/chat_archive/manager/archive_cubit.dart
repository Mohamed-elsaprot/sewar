import 'package:alsewar/features/chat_archive/data/archives_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home_screen/models/Conversation.dart';
import 'archive_state.dart';

class ArchiveCubit extends Cubit<ArchiveState> {
  ArchiveCubit(this.repo) : super(ArchiveInitial());
  final ArchivesRepo repo;

  int selectedIndex=-1;
  List<Conversation> archivedChats=[];

  Future getArchivedChats()async{
    emit(ArchiveLoading());
    var res = await repo.getMyConversations();
    res.fold((failure) => emit(ArchiveFailure(errorMessage: failure.errorMessage)), (list){
      archivedChats = list;
      emit(ArchiveSuccess());
    });
  }

  removeCon(){
    archivedChats[selectedIndex].isBlocked = !archivedChats[selectedIndex].isBlocked!;
    // archivedChats.removeAt(selectedIndex);
    selectedIndex = -1;
    emit(ArchiveSuccess());
  }
}
