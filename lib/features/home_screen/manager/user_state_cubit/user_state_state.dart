abstract class UserStateState {}

final class UserStateInitial extends UserStateState {}
final class UserStateLoading extends UserStateState {}
final class UserStateSuccess extends UserStateState {}
final class UserStateFailure extends UserStateState {
  final String errorMessage;
  UserStateFailure({required this.errorMessage});
}
