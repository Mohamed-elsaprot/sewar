import 'package:alsewar/core/design/app_styles.dart';
import 'package:alsewar/core/design/fun_widgets.dart';
import 'package:alsewar/core/design/images.dart';
import 'package:alsewar/core/general_widgets/custom_button.dart';
import 'package:alsewar/core/general_widgets/text_filed.dart';
import 'package:alsewar/features/auth/manager/auth_cubit.dart';
import 'package:alsewar/features/auth/manager/auth_state.dart';
import 'package:alsewar/features/navigation_screen/view/navigation.dart';
import 'package:alsewar/features/splash/manager/user_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/local_storage/secure_storage.dart';
import '../../../core/router.dart';

class AuthBody extends StatelessWidget {
  const AuthBody({super.key});

  @override
  Widget build(BuildContext context) {
    late String phone,password; GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // SizedBox(height: 145.h,),
              SizedBox(height: 200.h,),
              Image.asset(Images.siwarLogo,width: 200.w,),
              SizedBox(height: 64.h,),
              CustomTextField(title: 'رقم الهاتف',onChange: (x)=>phone=x,textInputType: TextInputType.text,),
              SizedBox(height: 30.h,),
              CustomTextField(title: 'الرقم السري',onChange: (x)=>password=x,textInputType: TextInputType.visiblePassword,password: true,),
              SizedBox(height: 55.h,),
              BlocConsumer<AuthCubit,AuthState>(
                  builder: (context,state) {
                    return SizedBox(
                    width: double.infinity,
                    height: 85.h,
                    child: CustomButton(fun: (){
                      if(formKey.currentState!.validate() && state is! AuthLoading){
                       BlocProvider.of<AuthCubit>(context).auth(phone: phone, password: password);
                      }
                    },
                      titleWidget: state is AuthLoading
                      ?const SizedBox(width: 30,height: 30,child: CircularProgressIndicator(color: Colors.white,),):
                      Styles.text('دخول',color: Colors.white),
                      title: '',rad: 60.r,textSize: 23,),
              );
                  }, listener: (context,state){
                    if(state is AuthFailure) errorDialog(context: context, message: state.errorMessage);
                    if(state is AuthSuccess) {
                      UserInfoCubit cubit = BlocProvider.of<UserInfoCubit>(context);
                      cubit.getUserInfo();
                      AppRouter.router.pushReplacement(AppRouter.navScreen);
                }
              }),

              // SizedBox(height: 80.h,),
              // CustomButton(
              //     fun: (){
              //     }, title: 'تسجيل',
              //     padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 55.w),rad: 60.r,textSize: 17,
              //     backGroundColor: Styles.whiteColor,textColor: Styles.blackColor,
              //     borderSide: const BorderSide(color: Styles.primary,width: 2),
              // ),
              SizedBox(height: 40.h,),
            ],
          ),
        ),
      ),
    );
  }
}
