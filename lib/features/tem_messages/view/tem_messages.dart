import 'package:alsewar/core/design/app_styles.dart';
import 'package:alsewar/core/general_widgets/custom_button.dart';
import 'package:alsewar/features/tem_messages/manager/temp_cubit.dart';
import 'package:alsewar/features/tem_messages/manager/temp_state.dart';
import 'package:alsewar/features/tem_messages/view/widget/messages_list.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../chat/manager/chat_body_cubit.dart';

class TemMessages extends StatelessWidget {
  const TemMessages({super.key});

  @override
  Widget build(BuildContext context) {
    var tempCubit = BlocProvider.of<TempCubit>(context);
    var chatBodyCubit = BlocProvider.of<ChatBodyCubit>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120.h,
        backgroundColor: Colors.white,automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,elevation: 0,
        title: Row(
          children: [
            SizedBox(width: 10.w,),
            const Icon(CupertinoIcons.chat_bubble_text),
            SizedBox(width: 10.w,),
            Styles.text('رسائل جاهزة'),
          ],
        ),
      ),
      body: Stack(
        children: [
          BlocBuilder<TempCubit,TempState>(builder: (context,state){
            if(state is TempSuccess){
              return const MessagesList();
            }else if(state is TempFailure){
              return Center(child: Styles.text(state.errorMessage),);
            }else{
              return const Center(child: CircularProgressIndicator(color: Styles.primary,),);
            }
          },),
          BlocBuilder<TempCubit,TempState>(builder: (context,state){
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30.w,vertical: 40.h),
                  child: CustomButton(
                    fun: ()async{
                      if(tempCubit.selectedMessageIndex!=-1){
                        chatBodyCubit.chatList.insert(
                            0,
                            ChatMessage(
                                user: chatBodyCubit.myself,
                                createdAt: DateTime.now(),
                                text: tempCubit.tempsCatList[tempCubit.selectedCatIndex].replies![tempCubit.selectedMessageIndex].template??'')
                        );
                        chatBodyCubit.sendMessages(message: tempCubit.tempsCatList[tempCubit.selectedCatIndex].replies![tempCubit.selectedMessageIndex].template??'').then((x){
                          Navigator.pop(context);
                        });
                      }else{
                        Navigator.pop(context);
                      }
                    },
                    title: tempCubit.selectedMessageIndex==-1?'اغلاق':'ارسال',textSize: 23,rad: 50,padding: EdgeInsets.symmetric(vertical: 26.h),
                    backGroundColor: tempCubit.selectedMessageIndex==-1? Styles.grey:Styles.primary,
                    textColor: tempCubit.selectedMessageIndex==-1? Colors.black:Colors.white,
                  )),
            );
          })
        ],
      ),
    );
  }
}
