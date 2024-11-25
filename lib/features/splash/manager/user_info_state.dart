
abstract class UserInfoState {}


final class UserInfoInitial extends UserInfoState {}
final class UserInfoLoading extends UserInfoState {}
final class UserInfoSuccess extends UserInfoState {}
final class UserInfoFailure extends UserInfoState {
  final String errorMessage;
  UserInfoFailure({required this.errorMessage});
}
