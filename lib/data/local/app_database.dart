import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class CachedUserTable extends Table {
  TextColumn get id => text()();
  TextColumn get fullName => text()();
  TextColumn get username => text()();
  TextColumn get email => text()();
  TextColumn get bio => text().nullable()();
  TextColumn get gender => text().nullable()();
  TextColumn get dateOfBirth => text().nullable()();
  TextColumn get phoneNumber => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get backgroundUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class CachedNotificationTable extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  TextColumn get payload => text()(); // JSON string
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  TextColumn get createdAt => text()(); // ISO 8601

  @override
  Set<Column> get primaryKey => {id};
}

class CachedConversationTable extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()(); // DIRECT | GROUP
  TextColumn get name => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();
  IntColumn get lastSeq => integer()();
  // lastMessage denormalized
  TextColumn get lastMessageId => text().nullable()();
  TextColumn get lastMessageContent => text().nullable()();
  TextColumn get lastMessageType => text().nullable()();
  TextColumn get lastMessageSenderId => text().nullable()();
  TextColumn get lastMessageSenderName => text().nullable()();
  BoolColumn get lastMessageIsDeleted =>
      boolean().withDefault(const Constant(false))();
  TextColumn get lastMessageCreatedAt => text().nullable()();
  TextColumn get updatedAt => text()(); // ISO 8601
  TextColumn get createdAt => text()(); // ISO 8601

  @override
  Set<Column> get primaryKey => {id};
}

class CachedParticipantTable extends Table {
  TextColumn get conversationId => text()();
  TextColumn get userId => text()();
  TextColumn get fullName => text()();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get role => text()();
  IntColumn get lastReadSeq => integer()();
  TextColumn get leftAt => text().nullable()(); // ISO 8601, null = still in group

  @override
  Set<Column> get primaryKey => {conversationId, userId};
}

class CachedMessageTable extends Table {
  TextColumn get id => text()();
  TextColumn get conversationId => text()();
  IntColumn get seq => integer()();
  TextColumn get content => text().nullable()(); // null khi isDeleted
  TextColumn get type => text()(); // TEXT|IMAGE|FILE|VIDEO|AUDIO|SYSTEM|CALL
  TextColumn get senderId => text()();
  BoolColumn get isEdited =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted =>
      boolean().withDefault(const Constant(false))();
  TextColumn get reactionsJson =>
      text().withDefault(const Constant('[]'))(); // JSON array
  TextColumn get replyToId => text().nullable()();
  TextColumn get createdAt => text()(); // ISO 8601

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    CachedUserTable,
    CachedNotificationTable,
    CachedConversationTable,
    CachedParticipantTable,
    CachedMessageTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'schat.db'));

  @override
  int get schemaVersion => 1;
}
