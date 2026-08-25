import 'package:isar/isar.dart';
import '../models/ai_conversation.dart';
import '../models/message.dart';

class AIChatRepository {
  final Isar isar;

  AIChatRepository(this.isar);

  Future<AIConversation> getOrCreateTodayConversation() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);

    var conversation = await isar.aIConversations
        .where()
        .dateEqualTo(startOfDay)
        .findFirst();

    if (conversation == null) {
      conversation = AIConversation()
        ..date = startOfDay
        ..createdAt = DateTime.now();
      await isar.writeTxn(() async {
        await isar.aIConversations.put(conversation!);
      });
    }

    return conversation;
  }

  Future<void> saveMessage(Message message) async {
    await isar.writeTxn(() async {
      await isar.messages.put(message);
    });
  }

  Future<List<Message>> getMessagesForConversation(int conversationId) async {
    return await isar.messages
        .filter()
        .conversationIdEqualTo(conversationId)
        .sortByTimestamp()
        .findAll();
  }

  Future<List<Message>> getRecentMessages(int conversationId, int limit) async {
    return await isar.messages
        .filter()
        .conversationIdEqualTo(conversationId)
        .sortByTimestampDesc()
        .limit(limit)
        .findAll();
  }

  /// Delete a conversation and all its messages
  Future<void> deleteConversation(int conversationId) async {
    await isar.writeTxn(() async {
      // Delete all messages in this conversation
      await isar.messages
          .filter()
          .conversationIdEqualTo(conversationId)
          .deleteAll();
      // Delete the conversation
      await isar.aIConversations.delete(conversationId);
    });
  }

  /// Delete all messages in a conversation (keep conversation)
  Future<void> deleteConversationMessages(int conversationId) async {
    await isar.writeTxn(() async {
      await isar.messages
          .filter()
          .conversationIdEqualTo(conversationId)
          .deleteAll();
    });
  }
}
