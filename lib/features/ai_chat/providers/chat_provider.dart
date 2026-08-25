import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riseup/core/database/database_provider.dart';
import 'package:riseup/features/ai_chat/models/ai_conversation.dart';
import 'package:riseup/features/ai_chat/models/message.dart';
import 'package:riseup/features/ai_chat/repositories/ai_chat_repository.dart';

final aiChatRepositoryProvider = Provider<AIChatRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return AIChatRepository(isar);
});

final todayConversationProvider =
    AsyncNotifierProvider<TodayConversationNotifier, AIConversation>(() {
      return TodayConversationNotifier();
    });

class TodayConversationNotifier extends AsyncNotifier<AIConversation> {
  @override
  Future<AIConversation> build() async {
    return ref.watch(aiChatRepositoryProvider).getOrCreateTodayConversation();
  }
}

final conversationMessagesProvider =
    AsyncNotifierProvider<ConversationMessagesNotifier, List<Message>>(() {
      return ConversationMessagesNotifier();
    });

class ConversationMessagesNotifier extends AsyncNotifier<List<Message>> {
  @override
  Future<List<Message>> build() async {
    final conversation = await ref.watch(todayConversationProvider.future);
    return ref
        .watch(aiChatRepositoryProvider)
        .getMessagesForConversation(conversation.id.toInt());
  }

  Future<void> addMessage(String text, SenderType sender) async {
    final repository = ref.read(aiChatRepositoryProvider);
    final conversation = await ref.read(todayConversationProvider.future);

    final message = Message()
      ..text = text
      ..sender = sender
      ..timestamp = DateTime.now()
      ..conversationId = conversation.id.toInt();

    await repository.saveMessage(message);
    state = await AsyncValue.guard(() => build());
  }

  Future<void> clearMessages() async {
    final repository = ref.read(aiChatRepositoryProvider);
    final conversation = await ref.read(todayConversationProvider.future);
    await repository.deleteConversationMessages(conversation.id.toInt());
    state = await AsyncValue.guard(() => build());
  }

  Future<void> deleteConversation() async {
    final repository = ref.read(aiChatRepositoryProvider);
    final conversation = await ref.read(todayConversationProvider.future);
    await repository.deleteConversation(conversation.id.toInt());
    ref.invalidate(todayConversationProvider);
    state = await AsyncValue.guard(() => build());
  }
}
