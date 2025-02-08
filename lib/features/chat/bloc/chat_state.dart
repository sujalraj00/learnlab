part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatSuccess extends ChatState {
  final List<ChatMessageModel> message;
  ChatSuccess({required this.message});
}

final class ChatLoading extends ChatState {}
