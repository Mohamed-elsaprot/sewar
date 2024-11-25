import 'package:alsewar/core/design/app_styles.dart';
import 'package:alsewar/core/general_widgets/custom_button.dart';
import 'package:alsewar/core/local_storage/secure_storage.dart';
import 'package:alsewar/core/router.dart';
import 'package:alsewar/features/settings/view/widgets/setting_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200.h,backgroundColor: Colors.transparent,
        elevation: 0,scrolledUnderElevation: 0,centerTitle: true,
        title: Styles.text('اعدادات',size: 39),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 42.w),
        children: [
          SettingButton(title: 'الاتصال بالمكتب', icon: CupertinoIcons.phone_fill, fun: () {  },),
          SizedBox(height: 20.h,),
          SettingButton(title: 'موقع السوار', icon: CupertinoIcons.location_fill, fun: () {  },),
          SizedBox(height: 20.h,),
          SettingButton(title: 'حذف الحساب', icon: Icons.cancel, fun: () {  },),
          SizedBox(height: 20.h,),
          SettingButton(title: 'تسجيل الخروج', icon: Icons.logout, fun: () {
            showDialog(context: context, builder: (context)=> AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Styles.text('هل تريد تسجيل الخروج؟'),
                  SizedBox(height: 20.h,),
                  Row(
                    children: [
                      Expanded(child: CustomButton(fun: ()async{
                        AppRouter.router.pop();
                        await SecureStorage.deleteToken();
                        AppRouter.router.pushReplacement(AppRouter.aScreen);
                      }, title: 'نعم',rad: 50,)),
                      SizedBox(width: 10.w,),
                      Expanded(child: CustomButton(fun: ()=>Navigator.pop(context), title: 'اغلاق',rad: 50,backGroundColor: Styles.grey,textColor: Colors.black,)),
                    ],
                  )
                ],
              ),
            ));
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Auth()));
          },),
        ],
      ),
    );
  }
}
