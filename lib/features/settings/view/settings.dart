import 'package:alsewar/features/settings/data/settings_repo.dart';
import 'package:alsewar/features/settings/manager/settings_cubit.dart';
import 'package:alsewar/features/settings/view/settings_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> SettingsCubit(SettingsRepo())..getSettingsModel(),child: const SettingsBody(),);
  }
}
