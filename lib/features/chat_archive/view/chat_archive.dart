import 'package:alsewar/core/design/fun_widgets.dart';
import 'package:alsewar/core/general_cubits/bloc_cubit/bloc_user_cubit.dart';
import 'package:alsewar/core/general_cubits/bloc_cubit/bloc_user_state.dart';
import 'package:alsewar/core/widgets/circle_name.dart';
import 'package:alsewar/features/chat_archive/manager/archive_cubit.dart';
import 'package:alsewar/features/chat_archive/manager/archive_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/design/app_styles.dart';
import '../../home_screen/view/widgets/shimmer_chatsList.dart';

class ChatArchives extends StatelessWidget {
  const ChatArchives({super.key});

  @override
  Widget build(BuildContext context) {
    var archCubit = BlocProvider.of<ArchiveCubit>(context);
    var blocCubit = BlocProvider.of<BlocUserCubit>(context);
    return SizedBox(
      // height: (380+(110*(10-1))).h,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 120.h,
          backgroundColor: Colors.white,automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,elevation: 0,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Icon(CupertinoIcons.chat_bubble_text,size: 35.sp,),
                SizedBox(width: 13.w,),
                Styles.text('ارشيف المحادثات'),
                // const Spacer(),
                // IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_down_rounded,size: 50.sp,))
              ],
            ),
          ),
        ),
        body: BlocBuilder<ArchiveCubit,ArchiveState>(
            builder: (context,state){
              if(state is ArchiveSuccess) {
                return ListView.separated(
                    padding: EdgeInsets.only(bottom: 40.h),
                    itemBuilder: (context,index)=>ListTile(
                      // leading: cachedImage(testPic, rad: 100,width: 51.w,height: 51.w,),
                      leading: CircleName(name: archCubit.archivedChats[index].guestName??'',),
                      title: Styles.text(archCubit.archivedChats[index].guestName??''),
                      subtitle: SizedBox(width: 200.w,child: Styles.subTitle(archCubit.archivedChats[index].userName??'',color: Styles.primary,maxLine: 1,overflow: TextOverflow.ellipsis)),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          BlocConsumer<BlocUserCubit,BlocUserState>(builder: (context,state){
                            if(state is BlocUserLoading && archCubit.selectedIndex==index) {
                              return Container(width: 50.w,alignment: Alignment.center,child: const SizedBox(width: 12,height: 12,child: CircularProgressIndicator(color: Color(0xffFF5150),),));
                            }else {
                              return GestureDetector(
                                onTap: () async{
                                  if(!archCubit.archivedChats[index].isBlocked!){
                                    archCubit.selectedIndex=index;
                                    await blocCubit.blocUser(conId: archCubit.archivedChats[index].id??-1);
                                  }
                                },
                                child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40.r),
                                    color: archCubit.archivedChats[index].isBlocked!? Colors.grey:const Color(0xffFF5150)
                                ),
                                width: 50.w,height: 22.h,alignment: Alignment.center,
                                // padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 4.h),
                                child: Styles.text(archCubit.archivedChats[index].isBlocked!?'محظور':'حظر',size: 9,color: Colors.white),
                                ),
                              );
                            }
                          }, listener: (context,state){
                            if(state is BlocUserFailure) errorDialog(context: context, message: state.errorMessage);
                            if(state is BlocUserSuccess && archCubit.selectedIndex!=-1) {
                                archCubit.removeCon();
                                archCubit.selectedIndex=-1;
                              }
                            }),
                          SizedBox(height: 12.h,),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Styles.subTitle(DateFormat.jm().format(DateTime.tryParse(archCubit.archivedChats[index].conversationLastMessage?.createdAt!??'')??DateTime(2024,1,1,0,0)),size: 13),
                              const Text(' | '),
                              Styles.subTitle(DateFormat.yMd().format(DateTime.tryParse(archCubit.archivedChats[index].conversationLastMessage?.createdAt!??'')??DateTime(2024,1,1,0,0)),size: 13),
                            ],
                          )
                        ],
                      ),
                    ),
                    separatorBuilder: (context,index)=>SizedBox(height: 20.h,),
                    itemCount: archCubit.archivedChats.length
                );
              }else if(state is ArchiveFailure){
                return Center(child: Styles.text(state.errorMessage),);
              }else{
                return const ShimmerChatslist();
              }
            },
        ),
      ),
    );
  }
}

