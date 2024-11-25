abstract class ArchiveState {}

final class ArchiveInitial extends ArchiveState {}
final class ArchiveLoading extends ArchiveState {}
final class ArchiveSuccess extends ArchiveState {}
final class ArchiveFailure extends ArchiveState {
  final String errorMessage;
  ArchiveFailure({required this.errorMessage});
}
