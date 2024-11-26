import 'dart:async';

import 'package:alsewar/core/widgets/circle_name.dart';
import 'package:alsewar/features/auth/manager/auth_cubit.dart';
import 'package:alsewar/features/chat/manager/add_to_archive_cubit.dart';
import 'package:alsewar/features/home_screen/view/widgets/shimmer_chatsList.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../const.dart';
import '../../../../core/design/app_styles.dart';
import '../../../../core/design/fun_widgets.dart';
import '../../../chat/data/chat_body_repo.dart';
import '../../../chat/manager/chat_body_cubit.dart';
import '../../../chat/view/chat_screen.dart';
import '../../../splash/manager/user_info_cubit.dart';
import '../../manager/chats_cubit.dart';
import '../../manager/chats_state.dart';

class OthersCon extends StatefulWidget {
  const OthersCon({super.key});

  @override
  State<OthersCon> createState() => _OthersConState();
}

class _OthersConState extends State<OthersCon> {
  late ChatsCubit myChatsCubit;
  late Timer timer;
  @override
  void initState() {
    myChatsCubit = BlocProvider.of<ChatsCubit>(context);
    myChatsCubit.getMyCon(isMine: false);
    timer = Timer.periodic(const Duration(seconds: 5), (time){
      myChatsCubit.getMyCon(isMine: false);
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
          if(myChatsCubit.othersConList.isNotEmpty || state is ChatsSuccess){
            UserInfoCubit userInfoCubit = BlocProvider.of<UserInfoCubit>(context);
            return ListView.separated(
                padding: EdgeInsetsDirectional.only(top: 30.h,end: 15.w,start: 15.w,bottom: 150.h),
                itemBuilder: (context,index)=>ListTile(
                  onTap: (){
                    if(BlocProvider.of<AuthCubit>(context).isAdmin){
                      showCupertinoModalBottomSheet(context: context,topRadius: const Radius.circular(40) ,builder: (_)=>
                          MultiBlocProvider(providers: [
                            BlocProvider(create: (context)=>
                            ChatBodyCubit(ChatBodyRepo(), guestName: myChatsCubit.othersConList[index].guestName??'', userName: userInfoCubit.user.name??'')
                              ..getChatBody(chatId: myChatsCubit.othersConList[index].id.toString()),
                            ),
                            BlocProvider(create: (context)=> AddToArchiveCubit(ChatBodyRepo(),myChatsCubit.othersConList[index].id!))
                          ], child: const Chat(isOther: true,))
                      );
                    }
                  },
                  leading: CircleName(name: myChatsCubit.othersConList[index].guestName??' '),
                  title: Styles.text(myChatsCubit.othersConList[index].guestName??''),
                  subtitle: SizedBox(width: 200.w,child: Styles.subTitle(myChatsCubit.othersConList[index].userName??'',color: Styles.primary,maxLine: 1,overflow: TextOverflow.ellipsis)),
                  trailing: Styles.subTitle(DateFormat.Hm().format(DateTime.tryParse(myChatsCubit.othersConList[index].conversationLastMessage?.createdAt!??'')??DateTime(2024,1,1,0,0)),size: 13),
                ),
                separatorBuilder: (context,index)=>SizedBox(height: 35.h,),
                itemCount: myChatsCubit.othersConList.length
            );
          }
          else if(state is ChatsFailure){
            return Center(child: Styles.text(state.errorMessage),);
          }else{
            return myChatsCubit.otherFirst? const ShimmerChatslist() : const SizedBox();
          }
        },);
  }
}
