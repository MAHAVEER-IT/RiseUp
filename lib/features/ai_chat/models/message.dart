import 'package:isar/isar.dart';

part 'message.g.dart';

enum SenderType { user, ai }

@collection
class Message {
  Id id = Isar.autoIncrement;

  late String text;

  @enumerated
  late SenderType sender;

  @Index()
  late DateTime timestamp;

  late int conversationId; // Reference to AIConversation ID
}
