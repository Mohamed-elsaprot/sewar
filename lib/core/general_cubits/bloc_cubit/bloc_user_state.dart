abstract class BlocUserState {}

final class BlocUserInitial extends BlocUserState {}
final class BlocUserLoading extends BlocUserState {}
final class BlocUserSuccess extends BlocUserState {}
final class BlocUserFailure extends BlocUserState {
  final String errorMessage;
  BlocUserFailure({required this.errorMessage});
}