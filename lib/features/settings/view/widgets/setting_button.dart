import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/design/app_styles.dart';
import '../../../../core/general_widgets/custom_button.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({super.key, required this.title, required this.icon, required this.fun});
  final String title;
  final IconData icon;
  final void Function() fun;
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      titleWidget: Row(
        children: [
          Container(
              width: 100.w,
              alignment: AlignmentDirectional.centerEnd,
              child: Icon(icon,color: Styles.primary,size: 31.sp,)),
          SizedBox(width: 22.w,),
          Styles.text(title,size: 25,textAlign: TextAlign.center),
        ],
      ),
      rad: 60.r,backGroundColor: Styles.grey,
      padding: EdgeInsets.symmetric(vertical: 27.h),
      fun: fun, title: '',
    );
  }
}
