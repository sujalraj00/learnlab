import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:learnlab/features/chat/model/chat_message_model.dart';
import 'package:learnlab/features/chat/repo/chat_repo.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccess(message: [])) {
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessage);
  }

  List<ChatMessageModel> message = [];
  bool isGenerating = false;

  Future<void> chatGenerateNewTextMessage(
      ChatGenerateNewTextMessageEvent event, Emitter<ChatState> emit) async {
    message.add(ChatMessageModel(
        role: "user", parts: [ChatPartModel(text: event.inputMessage)]));

    emit(ChatSuccess(message: message));
    isGenerating = true;

    String generatedText = await ChatRepo.chatGenerateTextRepo(message);
    if (generatedText.length > 0) {
      message.add(ChatMessageModel(
          role: 'model', parts: [ChatPartModel(text: generatedText)]));
      emit(ChatSuccess(message: message));
    }
    isGenerating = false;
  }
}
