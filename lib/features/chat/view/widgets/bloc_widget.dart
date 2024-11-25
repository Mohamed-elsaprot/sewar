import 'package:alsewar/core/design/fun_widgets.dart';
import 'package:alsewar/core/general_cubits/bloc_cubit/bloc_user_cubit.dart';
import 'package:alsewar/features/chat/manager/add_to_archive_cubit.dart';
import 'package:alsewar/features/chat/manager/add_to_archive_state.dart';
import 'package:alsewar/features/chat_archive/manager/archive_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/design/app_styles.dart';
import '../../../../core/general_cubits/bloc_cubit/bloc_user_state.dart';
import '../../../../core/general_widgets/custom_button.dart';
import '../../../home_screen/manager/chats_cubit.dart';

class BlocWidget extends StatefulWidget {
  const BlocWidget({super.key, required this.index,});
  final int index;
  @override
  State<BlocWidget> createState() => _BlocWidgetState();
}

class _BlocWidgetState extends State<BlocWidget> {
  late AddToArchiveCubit addToArchiveCubit;
  late BlocUserCubit blocCubit;
  late ChatsCubit chatsCubit;
  @override
  void initState() {
    addToArchiveCubit = BlocProvider.of<AddToArchiveCubit>(context);
    // archCubit = BlocProvider.of<ArchiveCubit>(context);
    blocCubit = BlocProvider.of<BlocUserCubit>(context);
    chatsCubit = BlocProvider.of<ChatsCubit>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: !addToArchiveCubit.secStep?
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 180.w,height: 55.h,
            child: CustomButton(
              fun: (){
                addToArchiveCubit.secStep=true;
                setState(() {});
              },
              title: '', backGroundColor: Colors.red,rad: 100,
              titleWidget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.block,color: Colors.white,),
                  SizedBox(width: 8.w,),
                  Styles.text('حظر',color: Colors.white)
                ],
              ),
            ),
          ),
          SizedBox(width: 20.w,),
          SizedBox(
            width: 180.w,height: 55.h,
            child: BlocConsumer<AddToArchiveCubit,AddToArchiveState>(builder: (context,state){
              return CustomButton(
                fun: (){
                  if(state is! AddToArchiveLoading){
                    addToArchiveCubit.addChatToArchive();
                  }
                },
                title: '', backGroundColor: Styles.grey,rad: 100,
                titleWidget:
                state is AddToArchiveLoading?
                const SizedBox(height: 20,width: 20,child: CircularProgressIndicator(color: Colors.black,)):
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.block,),
                    SizedBox(width: 8.w,),
                    Styles.text('اغلاق',)
                  ],
                ),
              );
            }, listener: (context,state)async{
              if(state is BlAddToArchiveFailure) errorDialog(context: context, message: state.errorMessage);
              if(state is AddToArchiveSuccess){
                chatsCubit.getMyCon(isMine: true).then((x)=>Navigator.pop(context));
              }
            }),
          ),
        ],
      ):
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 55.h,
                child: BlocConsumer<BlocUserCubit,BlocUserState>(builder: (context,state){
                  if(state is BlocUserLoading) {
                    return CustomButton(
                      fun: (){}, title: '',backGroundColor: Colors.red,rad: 100,
                      titleWidget: const SizedBox(width: 20,height: 20,child: CircularProgressIndicator(color: Colors.white,),),);
                  }else {
                    return CustomButton(
                      fun: ()async{
                        await blocCubit.blocUser(conId: chatsCubit.myConList[widget.index].id??-1).then((x){
                          chatsCubit.getMyCon(isMine: true);
                        });
                      },
                      title: '', backGroundColor: Colors.red,rad: 100,
                      titleWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.block,color: Colors.white,),
                          SizedBox(width: 8.w,),
                          Styles.text('تأكيد الحظر',color: Colors.white)
                        ],
                      ),
                    );
                  }
                }, listener: (context,state){
                  if(state is BlocUserFailure) errorDialog(context: context, message: state.errorMessage);
                  if(state is BlocUserSuccess ) {
                    Navigator.pop(context);
                  }
                }),
              ),
            ),
            // Expanded(
            //   child: SizedBox(
            //     height: 55.h,
            //     child: CustomButton(
            //       fun: ()async{
            //         archCubit.selectedIndex=widget.index;
            //         await blocCubit.blocUser(conId: archCubit.archivedChats[widget.index].id??-1);
            //       },
            //       title: '', backGroundColor: Colors.red,rad: 100,
            //       titleWidget: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             const Icon(Icons.block,color: Colors.white,),
            //             SizedBox(width: 8.w,),
            //             Styles.text('تأكيد الحظر',color: Colors.white)
            //           ],
            //         ),
            //     ),
            //   ),
            // ),
            SizedBox(width: 20.w,),
            SizedBox(
              width: 70.w.w,height: 55.h,
              child: CustomButton(
                fun: (){
                  addToArchiveCubit.taped = !addToArchiveCubit.taped;
                  addToArchiveCubit.secStep = false;
                  addToArchiveCubit.emit(AddToArchiveInitial());
                },
                title: '',backGroundColor:  Colors.grey.shade200,rad: 100,
                titleWidget: const Icon(Icons.cancel_outlined,color: Colors.black,),
              ),
            ),
          ],
        ),
      ),
    ).animate().slideY(begin:-.2,duration: const Duration(milliseconds: 150));
  }
}
