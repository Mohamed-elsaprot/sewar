import 'dart:async';

import 'package:alsewar/core/widgets/circle_name.dart';
import 'package:alsewar/features/chat/data/chat_body_repo.dart';
import 'package:alsewar/features/chat/manager/add_to_archive_cubit.dart';
import 'package:alsewar/features/chat/manager/chat_body_cubit.dart';
import 'package:alsewar/features/forward_chat/data/online_users_repo.dart';
import 'package:alsewar/features/forward_chat/manager/online_users_cubit.dart';
import 'package:alsewar/features/home_screen/view/widgets/shimmer_chatsList.dart';
import 'package:alsewar/features/splash/manager/user_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../const.dart';
import '../../../../core/design/app_styles.dart';
import '../../../../core/design/fun_widgets.dart';
import '../../../chat/view/chat_screen.dart';
import '../../../forward_chat/forward_chat.dart';
import '../../manager/chats_cubit.dart';
import '../../manager/chats_state.dart';

class MyConList extends StatefulWidget {
  const MyConList({super.key});

  @override
  State<MyConList> createState() => _MyConListState();
}

class _MyConListState extends State<MyConList> {
  late ChatsCubit myChatsCubit;
  late Timer timer;
  @override
  void initState() {
    myChatsCubit = BlocProvider.of<ChatsCubit>(context);
    myChatsCubit.getMyCon(isMine: true);
    timer = Timer.periodic(const Duration(seconds: 5), (time){
      myChatsCubit.getMyCon(isMine: true);
    });
    super.initState();
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsCubit,ChatsState>(
        builder: (context,state){
          if(myChatsCubit.myConList.isNotEmpty || state is ChatsSuccess){
            UserInfoCubit userInfoCubit = BlocProvider.of<UserInfoCubit>(context);
            return ListView.separated(
                padding: EdgeInsetsDirectional.only(top: 30.h,end: 15.w,start: 15.w,bottom: 150.h),
                itemBuilder: (context,index)=>ListTile(
                  onTap: (){
                    showCupertinoModalBottomSheet(context: context,topRadius: const Radius.circular(40) ,builder: (_)=>
                    MultiBlocProvider(providers: [
                      BlocProvider(create: (context)=>
                      ChatBodyCubit(
                          ChatBodyRepo(), guestName: myChatsCubit.myConList[index].guestName??'', userName: userInfoCubit.user.name??'')
                        ..getChatBody(chatId: myChatsCubit.myConList[index].id.toString()),
                      ),
                      BlocProvider(create: (context)=> AddToArchiveCubit(ChatBodyRepo(),myChatsCubit.myConList[index].id!))
                    ], child: Chat(index: index,))
                    );
                  },
                  leading: CircleName(name: myChatsCubit.myConList[index].guestName??' '),
                  title: Styles.text(myChatsCubit.myConList[index].guestName??''),
                  subtitle: SizedBox(width: 200.w,child: Styles.subTitle(myChatsCubit.myConList[index].userName??'',color: Styles.primary,maxLine: 1,overflow: TextOverflow.ellipsis)),
                  trailing: SizedBox(
                    width: 90.w,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            showCupertinoModalBottomSheet(context: context,topRadius: const Radius.circular(40) ,
                                builder: (_)=> BlocProvider(create: (context)=> OnlineUsersCubit(OnlineUsersRepo()),child: ForwardChat(
                                  chatId: myChatsCubit.myConList[index].id??0,
                                ),));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.r),
                                color: Styles.grey
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 4.h),
                            child: Styles.text('تحويل المحادثة',size: 10),
                          ),
                        ),
                        SizedBox(height: 12.h,),
                        Styles.subTitle(DateFormat.jm().format(DateTime.tryParse(myChatsCubit.myConList[index].conversationLastMessage?.createdAt!??'')??DateTime(2024,1,1,0,0)),size: 13)
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context,index)=>SizedBox(height: 35.h,),
                itemCount: myChatsCubit.myConList.length
            );
          }
          else if(state is ChatsFailure){
            return Center(child: Styles.text(state.errorMessage),);
          }else{
            return myChatsCubit.myConFirst? const ShimmerChatslist() : const SizedBox();
          }
          },);
  }
}
