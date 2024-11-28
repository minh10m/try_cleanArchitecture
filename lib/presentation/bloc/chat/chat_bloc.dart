import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecase/chat_usecases.dart';
import 'chat_event.dart';
import 'chat_state.dart';

@singleton
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatUseCase _chatUseCase;

  ChatBloc({required ChatUseCase chatUseCase})
      : _chatUseCase = chatUseCase,
        super(ChatInitialState()) {
    on<SendMessageEvent>((event, emit) async {
      try {
        emit(ChatMessageSentState());
        await _chatUseCase.sendMessage(event.receiverID, event.message);
      } catch (e) {
        emit(ChatErrorState(error: e.toString()));
      }
    });

    on<FetchMessagesEvent>((event, emit) async {
      emit(ChatMessagesLoadingState());
      try {
        final messages = await _chatUseCase.getMessages(event.userID, event.otherUserID).first;
        emit(ChatMessagesLoadedState(messages: messages));
      } catch (e) {
        emit(ChatErrorState(error: e.toString()));
      }
    });
  }
}
