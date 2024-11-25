import 'package:alsewar/const.dart';
import 'package:alsewar/features/navigation_screen/manager/navigation_cubit.dart';
import 'package:alsewar/features/navigation_screen/view/widgets/nav_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/design/app_styles.dart';

class NavScreenBody extends StatefulWidget {
  const NavScreenBody({super.key});

  @override
  State<NavScreenBody> createState() => _NavScreenBodyState();
}

class _NavScreenBodyState extends State<NavScreenBody> {
  @override
  Widget build(BuildContext context) {
    var navCubit = BlocProvider.of<NavigationScreenCubit>(context);
    return Scaffold(
      body: Stack(
        children: [
          screens[navCubit.index],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80.h,width: 190.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  boxShadow: [
                    BoxShadow(
                        color: Styles.blackColor.withOpacity(.2),
                        blurRadius: 40,
                        offset: const Offset(-15, 5)
                    )
                  ],
                  color: Styles.whiteColor
              ),
              margin: EdgeInsets.only(bottom: 53.h,left: 122.w,right: 122.w),
              child: Row(
                children: [
                  NavItem(iconData: CupertinoIcons.chat_bubble, title: 'مكالمات',
                    onTap: () => setState(() {navCubit.setIndex(0);}),selected: navCubit.index==0,),
                  NavItem(iconData: CupertinoIcons.slider_horizontal_3, title: 'اعدادات',
                    onTap: () => setState(() {navCubit.setIndex(1);}),selected: navCubit.index==1,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
