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

@DriftDatabase(tables: [CachedUserTable, CachedNotificationTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'schat.db'));

  @override
  int get schemaVersion => 3;
}
