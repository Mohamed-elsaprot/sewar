import 'package:alsewar/features/settings/data/settings_repo.dart';
import 'package:alsewar/features/settings/manager/settings_state.dart';
import 'package:alsewar/features/settings/models/SettingsModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.repo) : super(SettingsInitial());
  final SettingsRepo repo;
  late SettingsModel settingsModel;
  Future getSettingsModel()async{
    emit(SettingsLoading());
    var res = await repo.getSettings();
    res.fold((failure)=>emit(SettingsFailure(errorMessage: failure.errorMessage)), (model){
      settingsModel = model;
      emit(SettingsSuccess());
    });
  }
}
