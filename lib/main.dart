import 'package:alsewar/core/design/app_styles.dart';
import 'package:alsewar/core/general_cubits/bloc_cubit/bloc_user_cubit.dart';
import 'package:alsewar/core/general_data/block_repo/bloc_repo.dart';
import 'package:alsewar/core/local_storage/secure_storage.dart';
import 'package:alsewar/features/auth/data/auth_repo.dart';
import 'package:alsewar/features/auth/manager/auth_cubit.dart';
import 'package:alsewar/features/splash/data/user_repo.dart';
import 'package:alsewar/features/splash/manager/user_info_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/router.dart';
import 'features/home_screen/data/my_con_repo.dart';
import 'features/home_screen/data/user_state_repo.dart';
import 'features/home_screen/manager/chats_cubit.dart';
import 'features/home_screen/manager/user_state_cubit/user_state_cubit.dart';
import 'features/navigation_screen/manager/navigation_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // await SecureStorage.delete();
  await SecureStorage.getToken();
  await SecureStorage.getUserState();
  runApp(EasyLocalization(
      startLocale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'),
        Locale('he'),
      ],
      path: 'locales',
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (_,child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context)=> AuthCubit(AuthRepo())),
            BlocProvider(create: (context)=> NavigationScreenCubit()),
            BlocProvider(create: (context)=> UserInfoCubit(UserRepo())),
            BlocProvider(create: (context)=> ChatsCubit(MyConRepo())),
            BlocProvider(create: (context)=> UserStateCubit(UserStateRepo())),
            BlocProvider(create: (context)=> BlocUserCubit(BlocRepo())),
          ],
          child: MaterialApp.router(
            // home: Auth(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerConfig: AppRouter.router,
            theme: ThemeData(
                scaffoldBackgroundColor: Styles.scaffoldColor,
                primaryColor: Styles.primary
            ),
          ),
        );
      },
    );
  }
}

