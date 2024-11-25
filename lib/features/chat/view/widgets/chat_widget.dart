import 'package:alsewar/core/general_widgets/custom_button.dart';
import 'package:alsewar/features/chat/manager/chat_body_cubit.dart';
import 'package:alsewar/features/chat/manager/chat_body_state.dart';
import 'package:alsewar/features/tem_messages/data/temp_message_repo.dart';
import 'package:alsewar/features/tem_messages/manager/temp_cubit.dart';
import 'package:alsewar/features/tem_messages/view/tem_messages.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/design/app_styles.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key, required this.readOnly});
  final bool readOnly;
  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late ChatBodyCubit chatBodyCubit;
  late ScrollController scrollController;
  @override
  void initState() {
    chatBodyCubit = BlocProvider.of<ChatBodyCubit>(context);
    scrollController = ScrollController();
    scrollController.addListener((){
      if(scrollController.position.pixels==scrollController.position.maxScrollExtent) {
          if(chatBodyCubit.next!=null)chatBodyCubit.getChatBody(chatId: chatBodyCubit.chatId);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h,left: 15.w,right: 15.w),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BlocConsumer<ChatBodyCubit,ChatBodyState>(
              builder: (context,state){
                if(state is ChatBodySuccess || state is MessageSentSuccess){
                  return DashChat(
                    scrollController: scrollController,
                    currentUser: chatBodyCubit.myself,
                    onSend: (ChatMessage m) {
                      setState(() {
                        chatBodyCubit.chatList.insert(0, m);
                      });
                      chatBodyCubit.sendMessages(message: m.text);
                    },
                    readOnly: widget.readOnly,//chatBodyCubit.readOnly,
                    inputOptions: InputOptions(
                        inputMaxLines: 2,
                        inputDecoration: InputDecoration(
                          prefixIcon: GestureDetector(
                              onTap: ()=> showCupertinoModalBottomSheet(
                                  context: context,topRadius: const Radius.circular(40),
                                  builder: (context)=> MultiBlocProvider(providers: [
                                    BlocProvider(create: (context)=>TempCubit(TempMessageRepo())..getTemps()),
                                    BlocProvider.value(value: chatBodyCubit)
                                  ], child: const TemMessages())).then((x)=>setState(() {})),
                              child: Container(
                                  width: 70.w,color: Colors.transparent,
                                  child: Icon(CupertinoIcons.chat_bubble_text,color: Styles.primary,size: 30.sp,))),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 8.h),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100),borderSide: const BorderSide(width: 0,color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100),borderSide: const BorderSide(width: 0,color: Colors.transparent)),
                          filled: true,fillColor: const Color(0xffFFEFF5),
                        )
                    ),
                    messages: chatBodyCubit.chatList,
                  );
                }else if(state is ChatBodyFailure){
                  return Center(child: Styles.text(state.errorMessage,textAlign: TextAlign.center),);
                }else{
                  return const Center(child: CircularProgressIndicator(color: Styles.primary,),);
                }
              },
              listener: (context,state){}
          ),
          if(chatBodyCubit.readOnly)Container(
              width: 340.w,height: 85.h,
              margin: EdgeInsets.only(bottom: 20.h),
              child: CustomButton(
                  fun: (){},
                backGroundColor: const Color(0xffE4E6EA),
                  title: 'اغلاق',rad: 100,textSize: 23,textColor: Colors.black,
              ))
        ],
      ),
    );
  }
}
