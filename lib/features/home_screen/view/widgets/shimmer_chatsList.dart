import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/design/fun_widgets.dart';

class ShimmerChatslist extends StatelessWidget {
  const ShimmerChatslist({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsetsDirectional.only(top: 30.h,end: 15.w,start: 15.w),
        itemBuilder: (context,index)=>shimmerWidget(height: 90.h, width: double.infinity,rad: 4),
        separatorBuilder: (context,index)=>SizedBox(height: 30.h,),
        itemCount: 15
    );;
  }
}
