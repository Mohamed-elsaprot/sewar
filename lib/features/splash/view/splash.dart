import 'package:alsewar/core/design/images.dart';
import 'package:alsewar/core/local_storage/secure_storage.dart';
import 'package:alsewar/core/router.dart';
import 'package:alsewar/core/services/api_service.dart';
import 'package:alsewar/features/splash/manager/user_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    if(SecureStorage.hasToken) {
      ApiService.updateHeader({'Authorization': 'Bearer ${SecureStorage.token}'});
      UserInfoCubit userInfoCubit = BlocProvider.of<UserInfoCubit>(context);
      userInfoCubit.getUserInfo();
    }
    Future.delayed(const Duration(milliseconds: 500),()=> AppRouter.router.pushReplacement(
     // !
     SecureStorage.hasToken? AppRouter.navScreen:AppRouter.aScreen
    ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(Images.siwarLogo).animate().fade(duration: const Duration(milliseconds: 150)),),
    );
  }
}
