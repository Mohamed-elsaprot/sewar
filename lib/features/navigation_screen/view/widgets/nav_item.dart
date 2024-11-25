import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/design/app_styles.dart';

class NavItem extends StatelessWidget {
  const NavItem({super.key, required this.iconData, required this.title,required this.onTap, required this.selected});
  final IconData iconData;
  final String title;
  final void Function()? onTap;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.r),
              color: selected?Styles.primary:Colors.transparent
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData,size: 26,color: selected?Styles.whiteColor:Styles.blackColor,),
              SizedBox(height: 4.h,),
              Styles.text(title,color: selected?Styles.whiteColor:Styles.blackColor,size: 16)
            ],
          ),
        ),
      ),
    );
  }
}
