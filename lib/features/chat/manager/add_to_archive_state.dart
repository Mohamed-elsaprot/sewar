abstract class AddToArchiveState {}

final class AddToArchiveInitial extends AddToArchiveState {}
final class AddToArchiveLoading extends AddToArchiveState {}
final class AddToArchiveSuccess extends AddToArchiveState {}
final class BlAddToArchiveFailure extends AddToArchiveState {
  final String errorMessage;
  BlAddToArchiveFailure({required this.errorMessage});
}


