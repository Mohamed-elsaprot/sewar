abstract class SettingsState {}

final class SettingsInitial extends SettingsState {}
final class SettingsLoading extends SettingsState {}
final class SettingsSuccess extends SettingsState {}
final class SettingsFailure extends SettingsState {
  final String errorMessage;
  SettingsFailure({required this.errorMessage});
}