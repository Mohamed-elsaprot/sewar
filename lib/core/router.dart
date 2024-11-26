import 'package:alsewar/features/auth/view/widgets/sign_up_webview.dart';
import 'package:alsewar/features/settings/models/Pages.dart';
import 'package:alsewar/features/splash/view/splash.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../features/auth/view/auth.dart';
import '../features/navigation_screen/view/navigation.dart';
import '../features/settings/view/widgets/content_page.dart';
import 'general_widgets/modal_material_with_page.dart';



abstract class AppRouter {
  static  String navScreen = '/navScreen';
  static  String aScreen = '/aScreen';
  static  String contentPage = '/contentPage';
  static  String signUpWebView = '/signUpWebView';

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
    GoRoute(
      path: contentPage,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return ModalWithMaterialPage(
            child: ContentPage(page: state.extra as Pages,)
        );
      },
    ),
    GoRoute(
      path: signUpWebView,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return const ModalWithMaterialPage(
            child: SignUpWebView()
        );
      },
    ),

  ]);
}