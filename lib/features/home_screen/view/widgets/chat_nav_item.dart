import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/design/app_styles.dart';

class ChatNavItem extends StatelessWidget {
  const ChatNavItem({super.key, required this.title, required this.selected, required this.fun});
  final String title;
  final bool selected;
  final void Function()? fun;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fun,
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width/2,
        child: Column(
          children: [
            SizedBox(height: 24.h,),
            Styles.text(title,color: selected?Styles.primary:null),
            SizedBox(height: 11.h,),
            Container(
              height: 5.h,width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 22.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: selected?Styles.primary:Styles.grey,
              ),
            )
          ],
        ),
      ),
    ) ;
  }
}
