import 'package:alsewar/core/design/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleName extends StatelessWidget {
  const CircleName({super.key, required this.name, this.color});
  final String name;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25.sp,backgroundColor: color??const Color(0xfffa7fa7),
      child: Styles.text(name[0]),
    );
  }
}
