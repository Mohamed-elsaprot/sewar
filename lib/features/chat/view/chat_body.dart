import 'dart:async';

import 'package:alsewar/core/design/app_styles.dart';
import 'package:alsewar/features/chat/manager/add_to_archive_cubit.dart';
import 'package:alsewar/features/chat/manager/add_to_archive_state.dart';
import 'package:alsewar/features/chat/manager/chat_body_cubit.dart';
import 'package:alsewar/features/chat/view/widgets/bloc_widget.dart';
import 'package:alsewar/features/chat/view/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({super.key, required this.isOther,required this.index});
  final bool isOther;
  final int index;
  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  late ChatBodyCubit chatBodyCubit;
  late AddToArchiveCubit blocChatCubit;
  late Timer timer;

  @override
  void initState() {
    chatBodyCubit = BlocProvider.of<ChatBodyCubit>(context);
    blocChatCubit = BlocProvider.of<AddToArchiveCubit>(context);
    if(!widget.isOther){
      timer = Timer.periodic(const Duration(seconds: 5), (time){
        chatBodyCubit.updateMessages();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if(!widget.isOther)timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddToArchiveCubit,AddToArchiveState>(builder: (context,state){
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 120.h,
          backgroundColor: Colors.white,automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,elevation: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 60.w,width: 60.w,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,color: Colors.cyan
                  ),child: Styles.text(chatBodyCubit.guestName[0],color: Colors.white),
                ),
                SizedBox(width: 13.w,),
                Styles.text(chatBodyCubit.guestName),
                if(!widget.isOther)const Spacer(),
                if(!widget.isOther)IconButton(onPressed: (){
                  setState(() {
                    blocChatCubit.taped = !blocChatCubit.taped;
                    blocChatCubit.secStep = false;
                  });
                }, icon: Icon(Icons.keyboard_arrow_down_rounded,size: 50.sp,))
              ],
            ),
          ),
          bottom: blocChatCubit.taped?
          PreferredSize(preferredSize: Size(0, 90.h), child: BlocWidget(index: widget.index,),):
          const PreferredSize(preferredSize: Size(0,0), child: SizedBox()),
        ),
        body: ChatWidget(readOnly: widget.isOther,),
      );
    });
  }
}
