import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/design/app_styles.dart';

class OffLineColumn extends StatelessWidget {
  const OffLineColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Styles.text('OFFLINE',color: const Color(0xffCA2D2D)),
                SizedBox(width: 4.w,),
                CircleAvatar(radius: 6.sp,backgroundColor: const Color(0xffCA2D2D),),
              ],
            ),
            SizedBox(height: 14.h,),
            Styles.text('يرجي الاتصال لفتح المحادثات\nمن القائمة في الاعلي!',size: 17,fontWeight: FontWeight.w500)
          ],
        )
      ],
    );
  }
}
