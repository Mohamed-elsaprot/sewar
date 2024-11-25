
import 'package:alsewar/features/chat/data/chat_body_repo.dart';
import 'package:alsewar/features/chat/models/MessageModel.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_body_state.dart';

class ChatBodyCubit extends Cubit<ChatBodyState> {
  ChatBodyCubit(this.repo,  {required this.userName,required this.guestName}) : super(ChatBodyInitial());
  final ChatBodyRepo repo;
  final String userName,guestName;

  late ChatUser myself = ChatUser(id: '1', firstName: userName,);
  late ChatUser otherUser = ChatUser(id: '2', firstName: guestName,);

  List<MessageModel> messagesList=[];
  List<ChatMessage> chatList=[];
  late String chatId;
  bool readOnly = false;
  String? next;

  Future getChatBody({required String chatId,})async{
    if(next==null)emit(ChatBodyLoading());
    this.chatId = chatId;
    var res = await repo.getMyConversations(chatId: chatId,user: myself,guest: otherUser,link: next);
    res.fold((failure) {
      emit(ChatBodyFailure(errorMessage: failure.errorMessage));
    }, (map){
      if(next==null){
        messagesList = map['messagesModelList'];
        chatList=map['chatList'];
      }else{
        messagesList.addAll(map['messagesModelList']);
        chatList.addAll(map['chatList']);
      }
      next=map['next'];
      emit(ChatBodySuccess());
    });
  }

  Future updateMessages()async{
      var res = await repo.updateMessages(chatId: chatId,user: myself,guest: otherUser, lastMessageId: messagesList.isNotEmpty?messagesList[0].id.toString():'-1');
      res.fold((failure) {
        emit(ChatBodyFailure(errorMessage: failure.errorMessage));
      }, (map){
        messagesList.insertAll(0, map['messagesModelList']);
        chatList.insertAll(0, map['chatList']);
        emit(ChatBodySuccess());
      });
  }

  Future sendMessages({required String message})async{
    var res = await repo.sendMessage(chatId: chatId,message: message);
    res.fold((failure) {
      chatList.removeAt(0);
      emit(ChatBodyFailure(errorMessage: failure.errorMessage));
    }, (message) {
      messagesList.insert(0, message);
      emit(MessageSentSuccess());
    });
  }
}
