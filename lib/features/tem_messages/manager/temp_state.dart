abstract class TempState {}

final class TempInitial extends TempState {}
final class TempLoading extends TempState {}
final class TempSuccess extends TempState {}
final class TempFailure extends TempState {
  final String errorMessage;
  TempFailure({required this.errorMessage});
}
