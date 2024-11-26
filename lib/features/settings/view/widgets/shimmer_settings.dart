import 'package:alsewar/core/design/fun_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerSettings extends StatelessWidget {
  const ShimmerSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(left: 42.w, right: 42.w, bottom: 200.h),
        itemBuilder: (context, index) =>
            shimmerWidget(height: 85, width: double.infinity, rad: 50),
        separatorBuilder: (context, index) => SizedBox(height: 20.h,),
        itemCount: 6);
  }
}
