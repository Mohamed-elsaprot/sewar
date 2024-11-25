import 'package:alsewar/features/splash/view/splash.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../features/auth/view/auth.dart';
import '../features/navigation_screen/view/navigation.dart';
import 'general_widgets/modal_material_with_page.dart';



abstract class AppRouter {
  static  String navScreen = '/navScreen';
  static  String aScreen = '/aScreen';

  static final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Splash();
      },
    ),
    GoRoute(
      path: aScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const Auth();
      },
    ),
    GoRoute(
      path: navScreen,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const ModalWithMaterialPage(
            child: NavigationScreen()
        );
      },
    ),
  ]);
}