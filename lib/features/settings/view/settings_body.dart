import 'package:alsewar/core/design/app_styles.dart';
import 'package:alsewar/core/general_widgets/custom_button.dart';
import 'package:alsewar/core/local_storage/secure_storage.dart';
import 'package:alsewar/core/router.dart';
import 'package:alsewar/features/settings/manager/settings_cubit.dart';
import 'package:alsewar/features/settings/manager/settings_state.dart';
import 'package:alsewar/features/settings/view/widgets/setting_button.dart';
import 'package:alsewar/features/settings/view/widgets/shimmer_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: BlocBuilder<SettingsCubit,SettingsState>(builder: (context,state){
        if(state is SettingsSuccess){
          var settingsModel = BlocProvider.of<SettingsCubit>(context).settingsModel;
          return ListView(
            padding: EdgeInsets.only(left: 42.w, right: 42.w, bottom: 200.h),
            children: [
              SettingButton(title: 'الاتصال بالمكتب', icon: CupertinoIcons.phone_fill, fun: () async{
                if (await canLaunchUrl(Uri.parse('tel:${settingsModel.phoneNumber}'))) {
                  await launchUrl(Uri.parse('tel:${settingsModel.phoneNumber}'));
                }
              },),
              SizedBox(height: 20.h,),
              SettingButton(title: 'موقع السوار', icon: CupertinoIcons.location_fill, fun: () async{
                if (await canLaunchUrl(Uri.parse('https://www.assiwar.com'))) {
                await launchUrl(Uri.parse('https://www.assiwar.com'));
                }
              },),
              SizedBox(height: 20.h,),
              ...List.generate(settingsModel.pages!.length, (index){
                return Column(children: [
                  SettingButton(title: settingsModel.pages![index].title??'', icon: CupertinoIcons.news_solid, fun: () async{
                    AppRouter.router.push(AppRouter.contentPage, extra: settingsModel.pages![index]);
                  },),
                  SizedBox(height: 20.h,),
                ],);
              }),
              SettingButton(title: 'حذف الحساب', icon: Icons.cancel, fun: () {
                showDialog(context: context, builder: (context)=> AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Styles.text('هل تريد حذف الحساب؟'),
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

              },),
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
          );
        }else if(state is SettingsFailure){
          return Center(child: Styles.text(state.errorMessage),);
        }else{
          return const ShimmerSettings();
        }
      }),
    );
  }
}
