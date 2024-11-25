import 'package:alsewar/core/design/app_styles.dart';
import 'package:alsewar/core/design/fun_widgets.dart';
import 'package:alsewar/features/splash/manager/user_info_cubit.dart';
import 'package:alsewar/features/splash/manager/user_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigaation_body.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserInfoCubit,UserInfoState>(
        builder: (context,state){
          if(state is UserInfoSuccess){
            return const NavScreenBody();
          }else{
            return const Scaffold(body: Center(child: CircularProgressIndicator(color: Styles.primary,),),);
          }
        },
        listener: (context,state){
          if(state is UserInfoFailure) errorDialog(context: context, message: state.errorMessage);
        }
    );
  }
}
