import 'dart:async';

import 'package:alsewar/core/design/fun_widgets.dart';
import 'package:alsewar/core/general_widgets/custom_button.dart';
import 'package:alsewar/features/forward_chat/manager/online_users_cubit.dart';
import 'package:alsewar/features/forward_chat/manager/online_users_state.dart';
import 'package:alsewar/features/splash/manager/user_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/design/app_styles.dart';
import '../home_screen/manager/chats_cubit.dart';

class ForwardChat extends StatefulWidget {
  const ForwardChat({super.key, required this.chatId});
  final num chatId;
  @override
  State<ForwardChat> createState() => _ForwardChatState();
}

class _ForwardChatState extends State<ForwardChat> {
  late ChatsCubit chatsCubit;
  late OnlineUsersCubit onlineUsersCubit;
  late UserInfoCubit userInfoCubit;
  late Timer timer;
  @override
  void initState() {
    onlineUsersCubit = BlocProvider.of<OnlineUsersCubit>(context);
    userInfoCubit = BlocProvider.of<UserInfoCubit>(context);
    chatsCubit = BlocProvider.of<ChatsCubit>(context);
    onlineUsersCubit.getOnlineUsers();
    timer = Timer.periodic(const Duration(seconds: 5), (time){
      onlineUsersCubit.getOnlineUsers();
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
    return SizedBox(
      // height: (380+(110*(onlineUsersCubit.onlineUsersList.length-1))).h,
      child: Scaffold(
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
                  ),child: Styles.text(userInfoCubit.user.name![0],color: Colors.white),
                ),
                SizedBox(width: 13.w,),
                Styles.text(userInfoCubit.user.name??''),
                const Spacer(),
                IconButton(onPressed: (){
                }, icon: Icon(Icons.keyboard_arrow_down_rounded,size: 50.sp,))
              ],
            ),
          ),
        ),
        body: BlocBuilder<OnlineUsersCubit,OnlineUsersState>(builder: (context,state){
          if(onlineUsersCubit.onlineUsersList.isEmpty){
            return const Center(child: CircularProgressIndicator(color: Styles.primary,),);
          }else{
            return ListView.separated(
                padding: EdgeInsets.only(bottom: 40.h),
                itemBuilder: (context,index)=>GestureDetector(
                  onTap: ()=>setState(()=>onlineUsersCubit.selected=index),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: onlineUsersCubit.selected==index?Styles.primary:const Color(0xffF0F0F0)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 18.h),
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        cachedImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhAu72pB24JrKJpqABtlUUqV02c4W-BaPyBQ&s',width: 51,height: 51,rad: 100),
                        SizedBox(width: 15.w,),
                        Styles.text(onlineUsersCubit.onlineUsersList[index].name??'',color: onlineUsersCubit.selected==index? Colors.white:null),
                        const Spacer(),
                        CircleAvatar(backgroundColor: const Color(0xff91F43D),radius: 10.sp,)
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context,index)=>SizedBox(height: 20.h,),
                itemCount: onlineUsersCubit.onlineUsersList.length
            );
          }
        }),
        bottomNavigationBar: Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 40.w,right: 40.w,bottom: 40.h,top: 10.h),
          child: CustomButton(
              fun: (){
                onlineUsersCubit.forwardChat(chatId: widget.chatId, userId: onlineUsersCubit.onlineUsersList[onlineUsersCubit.selected].id, c: context).
                then((x) async {
                  print(111);
                  await chatsCubit.getMyCon(isMine: true).then((x){
                    print(2222);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                });
              },
            padding: EdgeInsets.symmetric(vertical: 24.h),
            title: 'تحويل',textSize: 23,rad: 100,
          ),
        ),
      ),
    );
  }
}
