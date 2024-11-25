import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const.dart';



abstract class Styles{
  static const Color primary = Color(0xffD93081);
  static Color scaffoldColor = const Color(0xffffffff);
  static Color whiteColor = const Color(0xffffffff);
  static Color blackColor = const Color(0xff000000);
  static Color grey = const Color(0xffF4F4F4);
  static Text text(String t,{int?maxLine,double? size=21,Color? color=Colors.black,FontWeight fontWeight=FontWeight.w600,TextOverflow? overflow,TextAlign? textAlign=TextAlign.start}){
    return Text(t,maxLines: maxLine,style: TextStyle(fontSize: size!.sp,fontWeight: fontWeight,color: color,fontFamily: fontFamily),overflow: overflow,textAlign: textAlign,);
  }

  static Text subTitle(String t,{int?maxLine,double? size=17,Color? color,FontWeight fontWeight=FontWeight.w600,TextOverflow? overflow,TextAlign? textAlign=TextAlign.start}){
    return Text(t,maxLines: maxLine,style: TextStyle(fontSize: size!.sp,fontWeight: fontWeight,color: color??const Color(0xff505050),fontFamily: fontFamily),overflow: overflow,textAlign: textAlign,);
  }
}