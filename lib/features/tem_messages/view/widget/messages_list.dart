import 'package:alsewar/features/tem_messages/manager/temp_cubit.dart';
import 'package:alsewar/features/tem_messages/manager/temp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/design/app_styles.dart';
import '../../../chat/manager/chat_body_cubit.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({Key? key}) : super(key: key);

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  late TempCubit tempCubit;
  late ChatBodyCubit chatBodyCubit;
  @override
  void initState() {
    chatBodyCubit = BlocProvider.of<ChatBodyCubit>(context);
    tempCubit = BlocProvider.of<TempCubit>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 18.h),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100),borderSide: const BorderSide(width: 0,color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100),borderSide: const BorderSide(width: 0,color: Colors.transparent)),
              fillColor: Styles.grey,filled: true,
            ),
            dropdownColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 10.h),
            value: 0,
            items: List.generate(tempCubit.tempsCatList.length, (index){
              return DropdownMenuItem(value: index,child: Styles.text(tempCubit.tempsCatList[index].name??'',size: 18));
            }), onChanged: (x){
              tempCubit.selectedCatIndex=x!;
              tempCubit.selectedMessageIndex=-1;
              tempCubit.emit(TempSuccess());
              setState(() {});
        }),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 10.h,bottom: 150.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(tempCubit.tempsCatList[tempCubit.selectedCatIndex].replies!.length, (index)=>GestureDetector(
                  onTap: (){
                    setState(() {
                      tempCubit.selectedMessageIndex=index;
                      tempCubit.emit(TempSuccess());
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28.r),
                        color: tempCubit.selectedMessageIndex==index? Styles.primary:const Color(0xff5D5D5D)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 22.w,vertical: 12.h),
                    margin: EdgeInsets.symmetric(vertical: 12.h,horizontal: 30.w),
                    child: Styles.text(tempCubit.tempsCatList[tempCubit.selectedCatIndex].replies![index].template??'',color: Colors.white,fontWeight: FontWeight.w500),
                  ),
                )),
              ),
            ),
          ),
        )
      ],
    );
  }
}
