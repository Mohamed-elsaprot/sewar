abstract class OnlineUsersState {}

final class OnlineUsersInitial extends OnlineUsersState {}
final class OnlineUsersLoading extends OnlineUsersState {}
final class OnlineUsersSuccess extends OnlineUsersState {}
final class OnlineUsersFailure extends OnlineUsersState {
  final String errorMessage;
  OnlineUsersFailure({required this.errorMessage});
}
