import 'package:alsewar/core/design/app_styles.dart';
import 'package:alsewar/core/design/fun_widgets.dart';
import 'package:alsewar/core/widgets/circle_name.dart';
import 'package:alsewar/features/chat_archive/manager/archive_cubit.dart';
import 'package:alsewar/features/chat_archive/view/chat_archive.dart';
import 'package:alsewar/features/home_screen/view/widgets/chat_nav_item.dart';
import 'package:alsewar/features/home_screen/view/widgets/my_con_list.dart';
import 'package:alsewar/features/home_screen/view/widgets/off_line_column.dart';
import 'package:alsewar/features/home_screen/view/widgets/others_con.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../const.dart';
import '../../chat_archive/data/archives_repo.dart';
import '../../splash/manager/user_info_cubit.dart';
import '../manager/chats_cubit.dart';
import '../manager/user_state_cubit/user_state_cubit.dart';
import '../manager/user_state_cubit/user_state_state.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatsCubit myChatsCubit;
  late UserInfoCubit userCubit;
  late UserStateCubit userStateCubit;
  @override
  void initState() {
    myChatsCubit = BlocProvider.of<ChatsCubit>(context);
    userCubit = BlocProvider.of<UserInfoCubit>(context);
    userStateCubit = BlocProvider.of<UserStateCubit>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 143.h,
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xffF0F0F0),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            children: [
              CircleName(name: userCubit.user.name??' '),
              SizedBox(width: 13.w,),
              Styles.text(userCubit.user.name??'',),
              const Spacer(),
              BlocConsumer<UserStateCubit,UserStateState>(builder: (context,state){
                return CupertinoSwitch(
                  value: userStateCubit.userState, onChanged: (x) => userStateCubit.updateUserState(),
                  thumbColor: userStateCubit.userState?const Color(0xff20A73A):const Color(0xffCA2D2D),
                  trackColor: Colors.grey.shade300,activeColor: Colors.grey.shade300,
                );
              }, listener: (context,state){
                if(state is UserStateFailure) errorDialog(context: context, message: state.errorMessage);
              }),
              if(myChatsCubit.selectedChat==0) SizedBox(width: 6.w,),
              if(myChatsCubit.selectedChat==0) IconButton(onPressed: ()=>
                  showCupertinoModalBottomSheet(
                      context: context,topRadius: const Radius.circular(40) ,builder: (_)=> MultiBlocProvider(
                      providers: [
                        BlocProvider(create: (context)=> ArchiveCubit(ArchivesRepo())..getArchivedChats(),),
                        // BlocProvider(create: (context)=> AddToArchiveCubit(ChatBodyRepo(),myChatsCubit.myConList[index].id!))
                      ], child: const ChatArchives(),),
                  ),
                  icon: const Icon(Icons.menu,size: 33,)
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 90.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   ChatNavItem(title: 'محادثاتي',selected: myChatsCubit.selectedChat==0,fun: ()=>setState(()=>myChatsCubit.selectedChat=0),),
                   ChatNavItem(title: 'الاخرى',selected: myChatsCubit.selectedChat==1,fun: ()=>setState(()=>myChatsCubit.selectedChat=1)),
                  ],
                ),
              ),
              Expanded(
                  child: myChatsCubit.selectedChat==0?const MyConList():const OthersCon()
              )
            ],
          ),
          BlocBuilder<UserStateCubit,UserStateState>(builder: (context,state){
            return userStateCubit.userState? const SizedBox():const OffLineColumn();
          })
        ],
      ),
    );
  }
}
