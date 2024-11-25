import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../design/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,required this.fun, required this.title, this.click=true, this.textColor=Colors.white, this.padding,this.textSize=15, this.rad=12, this.titleWidget, this.backGroundColor=Styles.primary, this.borderSide,});
  final void Function() fun;
  final String title;
  final bool click;
  final Color? textColor,backGroundColor;
  final EdgeInsetsGeometry? padding;
  final double textSize;
  final double? rad;
  final Widget? titleWidget;
  final BorderSide? borderSide;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          padding: padding??EdgeInsets.symmetric(vertical: 10.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(rad!.r,),
            side:borderSide?? BorderSide(color:click! ? Colors.transparent:Colors.black26,width: 1.5),
          ),
          backgroundColor:click? backGroundColor:Colors.white
      ),
      onPressed: fun,
      child:titleWidget?? Styles.text(title,color:click! ? textColor! :Colors.black54,size: textSize),
    );
  }
}
