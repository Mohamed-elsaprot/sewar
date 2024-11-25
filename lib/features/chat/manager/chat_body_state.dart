abstract class ChatBodyState {}

final class ChatBodyInitial extends ChatBodyState {}
final class ChatBodyLoading extends ChatBodyState {}
final class ChatBodySuccess extends ChatBodyState {}
final class MessageSentSuccess extends ChatBodyState {}
final class ChatBodyFailure extends ChatBodyState {
  final String errorMessage;
  ChatBodyFailure({required this.errorMessage});
}
