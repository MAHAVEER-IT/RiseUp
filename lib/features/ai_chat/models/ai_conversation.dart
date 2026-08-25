import 'package:isar/isar.dart';

part 'ai_conversation.g.dart';

@collection
class AIConversation {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late DateTime date;

  String? summary;

  late DateTime createdAt;
}
