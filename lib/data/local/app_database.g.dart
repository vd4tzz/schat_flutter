// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CachedUserTableTable extends CachedUserTable
    with TableInfo<$CachedUserTableTable, CachedUserTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedUserTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bioMeta = const VerificationMeta('bio');
  @override
  late final GeneratedColumn<String> bio = GeneratedColumn<String>(
    'bio',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<String> dateOfBirth = GeneratedColumn<String>(
    'date_of_birth',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _backgroundUrlMeta = const VerificationMeta(
    'backgroundUrl',
  );
  @override
  late final GeneratedColumn<String> backgroundUrl = GeneratedColumn<String>(
    'background_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fullName,
    username,
    email,
    bio,
    gender,
    dateOfBirth,
    phoneNumber,
    avatarUrl,
    backgroundUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_user_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedUserTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('bio')) {
      context.handle(
        _bioMeta,
        bio.isAcceptableOrUnknown(data['bio']!, _bioMeta),
      );
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('background_url')) {
      context.handle(
        _backgroundUrlMeta,
        backgroundUrl.isAcceptableOrUnknown(
          data['background_url']!,
          _backgroundUrlMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedUserTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedUserTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      bio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bio'],
      ),
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      ),
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_of_birth'],
      ),
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      backgroundUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}background_url'],
      ),
    );
  }

  @override
  $CachedUserTableTable createAlias(String alias) {
    return $CachedUserTableTable(attachedDatabase, alias);
  }
}

class CachedUserTableData extends DataClass
    implements Insertable<CachedUserTableData> {
  final String id;
  final String fullName;
  final String username;
  final String email;
  final String? bio;
  final String? gender;
  final String? dateOfBirth;
  final String? phoneNumber;
  final String? avatarUrl;
  final String? backgroundUrl;
  const CachedUserTableData({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
    this.bio,
    this.gender,
    this.dateOfBirth,
    this.phoneNumber,
    this.avatarUrl,
    this.backgroundUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['full_name'] = Variable<String>(fullName);
    map['username'] = Variable<String>(username);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || bio != null) {
      map['bio'] = Variable<String>(bio);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<String>(dateOfBirth);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    if (!nullToAbsent || backgroundUrl != null) {
      map['background_url'] = Variable<String>(backgroundUrl);
    }
    return map;
  }

  CachedUserTableCompanion toCompanion(bool nullToAbsent) {
    return CachedUserTableCompanion(
      id: Value(id),
      fullName: Value(fullName),
      username: Value(username),
      email: Value(email),
      bio: bio == null && nullToAbsent ? const Value.absent() : Value(bio),
      gender: gender == null && nullToAbsent
          ? const Value.absent()
          : Value(gender),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      backgroundUrl: backgroundUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(backgroundUrl),
    );
  }

  factory CachedUserTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedUserTableData(
      id: serializer.fromJson<String>(json['id']),
      fullName: serializer.fromJson<String>(json['fullName']),
      username: serializer.fromJson<String>(json['username']),
      email: serializer.fromJson<String>(json['email']),
      bio: serializer.fromJson<String?>(json['bio']),
      gender: serializer.fromJson<String?>(json['gender']),
      dateOfBirth: serializer.fromJson<String?>(json['dateOfBirth']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      backgroundUrl: serializer.fromJson<String?>(json['backgroundUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fullName': serializer.toJson<String>(fullName),
      'username': serializer.toJson<String>(username),
      'email': serializer.toJson<String>(email),
      'bio': serializer.toJson<String?>(bio),
      'gender': serializer.toJson<String?>(gender),
      'dateOfBirth': serializer.toJson<String?>(dateOfBirth),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'backgroundUrl': serializer.toJson<String?>(backgroundUrl),
    };
  }

  CachedUserTableData copyWith({
    String? id,
    String? fullName,
    String? username,
    String? email,
    Value<String?> bio = const Value.absent(),
    Value<String?> gender = const Value.absent(),
    Value<String?> dateOfBirth = const Value.absent(),
    Value<String?> phoneNumber = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
    Value<String?> backgroundUrl = const Value.absent(),
  }) => CachedUserTableData(
    id: id ?? this.id,
    fullName: fullName ?? this.fullName,
    username: username ?? this.username,
    email: email ?? this.email,
    bio: bio.present ? bio.value : this.bio,
    gender: gender.present ? gender.value : this.gender,
    dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    backgroundUrl: backgroundUrl.present
        ? backgroundUrl.value
        : this.backgroundUrl,
  );
  CachedUserTableData copyWithCompanion(CachedUserTableCompanion data) {
    return CachedUserTableData(
      id: data.id.present ? data.id.value : this.id,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      username: data.username.present ? data.username.value : this.username,
      email: data.email.present ? data.email.value : this.email,
      bio: data.bio.present ? data.bio.value : this.bio,
      gender: data.gender.present ? data.gender.value : this.gender,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      backgroundUrl: data.backgroundUrl.present
          ? data.backgroundUrl.value
          : this.backgroundUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedUserTableData(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('bio: $bio, ')
          ..write('gender: $gender, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('backgroundUrl: $backgroundUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fullName,
    username,
    email,
    bio,
    gender,
    dateOfBirth,
    phoneNumber,
    avatarUrl,
    backgroundUrl,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedUserTableData &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.username == this.username &&
          other.email == this.email &&
          other.bio == this.bio &&
          other.gender == this.gender &&
          other.dateOfBirth == this.dateOfBirth &&
          other.phoneNumber == this.phoneNumber &&
          other.avatarUrl == this.avatarUrl &&
          other.backgroundUrl == this.backgroundUrl);
}

class CachedUserTableCompanion extends UpdateCompanion<CachedUserTableData> {
  final Value<String> id;
  final Value<String> fullName;
  final Value<String> username;
  final Value<String> email;
  final Value<String?> bio;
  final Value<String?> gender;
  final Value<String?> dateOfBirth;
  final Value<String?> phoneNumber;
  final Value<String?> avatarUrl;
  final Value<String?> backgroundUrl;
  final Value<int> rowid;
  const CachedUserTableCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.bio = const Value.absent(),
    this.gender = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.backgroundUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedUserTableCompanion.insert({
    required String id,
    required String fullName,
    required String username,
    required String email,
    this.bio = const Value.absent(),
    this.gender = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.backgroundUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fullName = Value(fullName),
       username = Value(username),
       email = Value(email);
  static Insertable<CachedUserTableData> custom({
    Expression<String>? id,
    Expression<String>? fullName,
    Expression<String>? username,
    Expression<String>? email,
    Expression<String>? bio,
    Expression<String>? gender,
    Expression<String>? dateOfBirth,
    Expression<String>? phoneNumber,
    Expression<String>? avatarUrl,
    Expression<String>? backgroundUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (bio != null) 'bio': bio,
      if (gender != null) 'gender': gender,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (backgroundUrl != null) 'background_url': backgroundUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedUserTableCompanion copyWith({
    Value<String>? id,
    Value<String>? fullName,
    Value<String>? username,
    Value<String>? email,
    Value<String?>? bio,
    Value<String?>? gender,
    Value<String?>? dateOfBirth,
    Value<String?>? phoneNumber,
    Value<String?>? avatarUrl,
    Value<String?>? backgroundUrl,
    Value<int>? rowid,
  }) {
    return CachedUserTableCompanion(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      backgroundUrl: backgroundUrl ?? this.backgroundUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<String>(dateOfBirth.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (backgroundUrl.present) {
      map['background_url'] = Variable<String>(backgroundUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedUserTableCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('bio: $bio, ')
          ..write('gender: $gender, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('backgroundUrl: $backgroundUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedNotificationTableTable extends CachedNotificationTable
    with TableInfo<$CachedNotificationTableTable, CachedNotificationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedNotificationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, type, payload, isRead, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_notification_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedNotificationTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedNotificationTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedNotificationTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CachedNotificationTableTable createAlias(String alias) {
    return $CachedNotificationTableTable(attachedDatabase, alias);
  }
}

class CachedNotificationTableData extends DataClass
    implements Insertable<CachedNotificationTableData> {
  final String id;
  final String type;
  final String payload;
  final bool isRead;
  final String createdAt;
  const CachedNotificationTableData({
    required this.id,
    required this.type,
    required this.payload,
    required this.isRead,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['payload'] = Variable<String>(payload);
    map['is_read'] = Variable<bool>(isRead);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  CachedNotificationTableCompanion toCompanion(bool nullToAbsent) {
    return CachedNotificationTableCompanion(
      id: Value(id),
      type: Value(type),
      payload: Value(payload),
      isRead: Value(isRead),
      createdAt: Value(createdAt),
    );
  }

  factory CachedNotificationTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedNotificationTableData(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      payload: serializer.fromJson<String>(json['payload']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'payload': serializer.toJson<String>(payload),
      'isRead': serializer.toJson<bool>(isRead),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  CachedNotificationTableData copyWith({
    String? id,
    String? type,
    String? payload,
    bool? isRead,
    String? createdAt,
  }) => CachedNotificationTableData(
    id: id ?? this.id,
    type: type ?? this.type,
    payload: payload ?? this.payload,
    isRead: isRead ?? this.isRead,
    createdAt: createdAt ?? this.createdAt,
  );
  CachedNotificationTableData copyWithCompanion(
    CachedNotificationTableCompanion data,
  ) {
    return CachedNotificationTableData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      payload: data.payload.present ? data.payload.value : this.payload,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedNotificationTableData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('payload: $payload, ')
          ..write('isRead: $isRead, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, payload, isRead, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedNotificationTableData &&
          other.id == this.id &&
          other.type == this.type &&
          other.payload == this.payload &&
          other.isRead == this.isRead &&
          other.createdAt == this.createdAt);
}

class CachedNotificationTableCompanion
    extends UpdateCompanion<CachedNotificationTableData> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> payload;
  final Value<bool> isRead;
  final Value<String> createdAt;
  final Value<int> rowid;
  const CachedNotificationTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.payload = const Value.absent(),
    this.isRead = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedNotificationTableCompanion.insert({
    required String id,
    required String type,
    required String payload,
    this.isRead = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       payload = Value(payload),
       createdAt = Value(createdAt);
  static Insertable<CachedNotificationTableData> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? payload,
    Expression<bool>? isRead,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (payload != null) 'payload': payload,
      if (isRead != null) 'is_read': isRead,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedNotificationTableCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<String>? payload,
    Value<bool>? isRead,
    Value<String>? createdAt,
    Value<int>? rowid,
  }) {
    return CachedNotificationTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      payload: payload ?? this.payload,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedNotificationTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('payload: $payload, ')
          ..write('isRead: $isRead, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedConversationTableTable extends CachedConversationTable
    with TableInfo<$CachedConversationTableTable, CachedConversationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedConversationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSeqMeta = const VerificationMeta(
    'lastSeq',
  );
  @override
  late final GeneratedColumn<int> lastSeq = GeneratedColumn<int>(
    'last_seq',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastMessageIdMeta = const VerificationMeta(
    'lastMessageId',
  );
  @override
  late final GeneratedColumn<String> lastMessageId = GeneratedColumn<String>(
    'last_message_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMessageContentMeta =
      const VerificationMeta('lastMessageContent');
  @override
  late final GeneratedColumn<String> lastMessageContent =
      GeneratedColumn<String>(
        'last_message_content',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastMessageTypeMeta = const VerificationMeta(
    'lastMessageType',
  );
  @override
  late final GeneratedColumn<String> lastMessageType = GeneratedColumn<String>(
    'last_message_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMessageSenderIdMeta =
      const VerificationMeta('lastMessageSenderId');
  @override
  late final GeneratedColumn<String> lastMessageSenderId =
      GeneratedColumn<String>(
        'last_message_sender_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastMessageSenderNameMeta =
      const VerificationMeta('lastMessageSenderName');
  @override
  late final GeneratedColumn<String> lastMessageSenderName =
      GeneratedColumn<String>(
        'last_message_sender_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastMessageIsDeletedMeta =
      const VerificationMeta('lastMessageIsDeleted');
  @override
  late final GeneratedColumn<bool> lastMessageIsDeleted = GeneratedColumn<bool>(
    'last_message_is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("last_message_is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastMessageCreatedAtMeta =
      const VerificationMeta('lastMessageCreatedAt');
  @override
  late final GeneratedColumn<String> lastMessageCreatedAt =
      GeneratedColumn<String>(
        'last_message_created_at',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    name,
    avatarUrl,
    lastSeq,
    lastMessageId,
    lastMessageContent,
    lastMessageType,
    lastMessageSenderId,
    lastMessageSenderName,
    lastMessageIsDeleted,
    lastMessageCreatedAt,
    updatedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_conversation_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedConversationTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('last_seq')) {
      context.handle(
        _lastSeqMeta,
        lastSeq.isAcceptableOrUnknown(data['last_seq']!, _lastSeqMeta),
      );
    } else if (isInserting) {
      context.missing(_lastSeqMeta);
    }
    if (data.containsKey('last_message_id')) {
      context.handle(
        _lastMessageIdMeta,
        lastMessageId.isAcceptableOrUnknown(
          data['last_message_id']!,
          _lastMessageIdMeta,
        ),
      );
    }
    if (data.containsKey('last_message_content')) {
      context.handle(
        _lastMessageContentMeta,
        lastMessageContent.isAcceptableOrUnknown(
          data['last_message_content']!,
          _lastMessageContentMeta,
        ),
      );
    }
    if (data.containsKey('last_message_type')) {
      context.handle(
        _lastMessageTypeMeta,
        lastMessageType.isAcceptableOrUnknown(
          data['last_message_type']!,
          _lastMessageTypeMeta,
        ),
      );
    }
    if (data.containsKey('last_message_sender_id')) {
      context.handle(
        _lastMessageSenderIdMeta,
        lastMessageSenderId.isAcceptableOrUnknown(
          data['last_message_sender_id']!,
          _lastMessageSenderIdMeta,
        ),
      );
    }
    if (data.containsKey('last_message_sender_name')) {
      context.handle(
        _lastMessageSenderNameMeta,
        lastMessageSenderName.isAcceptableOrUnknown(
          data['last_message_sender_name']!,
          _lastMessageSenderNameMeta,
        ),
      );
    }
    if (data.containsKey('last_message_is_deleted')) {
      context.handle(
        _lastMessageIsDeletedMeta,
        lastMessageIsDeleted.isAcceptableOrUnknown(
          data['last_message_is_deleted']!,
          _lastMessageIsDeletedMeta,
        ),
      );
    }
    if (data.containsKey('last_message_created_at')) {
      context.handle(
        _lastMessageCreatedAtMeta,
        lastMessageCreatedAt.isAcceptableOrUnknown(
          data['last_message_created_at']!,
          _lastMessageCreatedAtMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedConversationTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedConversationTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      lastSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_seq'],
      )!,
      lastMessageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_id'],
      ),
      lastMessageContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_content'],
      ),
      lastMessageType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_type'],
      ),
      lastMessageSenderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_sender_id'],
      ),
      lastMessageSenderName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_sender_name'],
      ),
      lastMessageIsDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}last_message_is_deleted'],
      )!,
      lastMessageCreatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message_created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CachedConversationTableTable createAlias(String alias) {
    return $CachedConversationTableTable(attachedDatabase, alias);
  }
}

class CachedConversationTableData extends DataClass
    implements Insertable<CachedConversationTableData> {
  final String id;
  final String type;
  final String? name;
  final String? avatarUrl;
  final int lastSeq;
  final String? lastMessageId;
  final String? lastMessageContent;
  final String? lastMessageType;
  final String? lastMessageSenderId;
  final String? lastMessageSenderName;
  final bool lastMessageIsDeleted;
  final String? lastMessageCreatedAt;
  final String updatedAt;
  final String createdAt;
  const CachedConversationTableData({
    required this.id,
    required this.type,
    this.name,
    this.avatarUrl,
    required this.lastSeq,
    this.lastMessageId,
    this.lastMessageContent,
    this.lastMessageType,
    this.lastMessageSenderId,
    this.lastMessageSenderName,
    required this.lastMessageIsDeleted,
    this.lastMessageCreatedAt,
    required this.updatedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['last_seq'] = Variable<int>(lastSeq);
    if (!nullToAbsent || lastMessageId != null) {
      map['last_message_id'] = Variable<String>(lastMessageId);
    }
    if (!nullToAbsent || lastMessageContent != null) {
      map['last_message_content'] = Variable<String>(lastMessageContent);
    }
    if (!nullToAbsent || lastMessageType != null) {
      map['last_message_type'] = Variable<String>(lastMessageType);
    }
    if (!nullToAbsent || lastMessageSenderId != null) {
      map['last_message_sender_id'] = Variable<String>(lastMessageSenderId);
    }
    if (!nullToAbsent || lastMessageSenderName != null) {
      map['last_message_sender_name'] = Variable<String>(lastMessageSenderName);
    }
    map['last_message_is_deleted'] = Variable<bool>(lastMessageIsDeleted);
    if (!nullToAbsent || lastMessageCreatedAt != null) {
      map['last_message_created_at'] = Variable<String>(lastMessageCreatedAt);
    }
    map['updated_at'] = Variable<String>(updatedAt);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  CachedConversationTableCompanion toCompanion(bool nullToAbsent) {
    return CachedConversationTableCompanion(
      id: Value(id),
      type: Value(type),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      lastSeq: Value(lastSeq),
      lastMessageId: lastMessageId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageId),
      lastMessageContent: lastMessageContent == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageContent),
      lastMessageType: lastMessageType == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageType),
      lastMessageSenderId: lastMessageSenderId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageSenderId),
      lastMessageSenderName: lastMessageSenderName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageSenderName),
      lastMessageIsDeleted: Value(lastMessageIsDeleted),
      lastMessageCreatedAt: lastMessageCreatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageCreatedAt),
      updatedAt: Value(updatedAt),
      createdAt: Value(createdAt),
    );
  }

  factory CachedConversationTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedConversationTableData(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String?>(json['name']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      lastSeq: serializer.fromJson<int>(json['lastSeq']),
      lastMessageId: serializer.fromJson<String?>(json['lastMessageId']),
      lastMessageContent: serializer.fromJson<String?>(
        json['lastMessageContent'],
      ),
      lastMessageType: serializer.fromJson<String?>(json['lastMessageType']),
      lastMessageSenderId: serializer.fromJson<String?>(
        json['lastMessageSenderId'],
      ),
      lastMessageSenderName: serializer.fromJson<String?>(
        json['lastMessageSenderName'],
      ),
      lastMessageIsDeleted: serializer.fromJson<bool>(
        json['lastMessageIsDeleted'],
      ),
      lastMessageCreatedAt: serializer.fromJson<String?>(
        json['lastMessageCreatedAt'],
      ),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String?>(name),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'lastSeq': serializer.toJson<int>(lastSeq),
      'lastMessageId': serializer.toJson<String?>(lastMessageId),
      'lastMessageContent': serializer.toJson<String?>(lastMessageContent),
      'lastMessageType': serializer.toJson<String?>(lastMessageType),
      'lastMessageSenderId': serializer.toJson<String?>(lastMessageSenderId),
      'lastMessageSenderName': serializer.toJson<String?>(
        lastMessageSenderName,
      ),
      'lastMessageIsDeleted': serializer.toJson<bool>(lastMessageIsDeleted),
      'lastMessageCreatedAt': serializer.toJson<String?>(lastMessageCreatedAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  CachedConversationTableData copyWith({
    String? id,
    String? type,
    Value<String?> name = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
    int? lastSeq,
    Value<String?> lastMessageId = const Value.absent(),
    Value<String?> lastMessageContent = const Value.absent(),
    Value<String?> lastMessageType = const Value.absent(),
    Value<String?> lastMessageSenderId = const Value.absent(),
    Value<String?> lastMessageSenderName = const Value.absent(),
    bool? lastMessageIsDeleted,
    Value<String?> lastMessageCreatedAt = const Value.absent(),
    String? updatedAt,
    String? createdAt,
  }) => CachedConversationTableData(
    id: id ?? this.id,
    type: type ?? this.type,
    name: name.present ? name.value : this.name,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    lastSeq: lastSeq ?? this.lastSeq,
    lastMessageId: lastMessageId.present
        ? lastMessageId.value
        : this.lastMessageId,
    lastMessageContent: lastMessageContent.present
        ? lastMessageContent.value
        : this.lastMessageContent,
    lastMessageType: lastMessageType.present
        ? lastMessageType.value
        : this.lastMessageType,
    lastMessageSenderId: lastMessageSenderId.present
        ? lastMessageSenderId.value
        : this.lastMessageSenderId,
    lastMessageSenderName: lastMessageSenderName.present
        ? lastMessageSenderName.value
        : this.lastMessageSenderName,
    lastMessageIsDeleted: lastMessageIsDeleted ?? this.lastMessageIsDeleted,
    lastMessageCreatedAt: lastMessageCreatedAt.present
        ? lastMessageCreatedAt.value
        : this.lastMessageCreatedAt,
    updatedAt: updatedAt ?? this.updatedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  CachedConversationTableData copyWithCompanion(
    CachedConversationTableCompanion data,
  ) {
    return CachedConversationTableData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      lastSeq: data.lastSeq.present ? data.lastSeq.value : this.lastSeq,
      lastMessageId: data.lastMessageId.present
          ? data.lastMessageId.value
          : this.lastMessageId,
      lastMessageContent: data.lastMessageContent.present
          ? data.lastMessageContent.value
          : this.lastMessageContent,
      lastMessageType: data.lastMessageType.present
          ? data.lastMessageType.value
          : this.lastMessageType,
      lastMessageSenderId: data.lastMessageSenderId.present
          ? data.lastMessageSenderId.value
          : this.lastMessageSenderId,
      lastMessageSenderName: data.lastMessageSenderName.present
          ? data.lastMessageSenderName.value
          : this.lastMessageSenderName,
      lastMessageIsDeleted: data.lastMessageIsDeleted.present
          ? data.lastMessageIsDeleted.value
          : this.lastMessageIsDeleted,
      lastMessageCreatedAt: data.lastMessageCreatedAt.present
          ? data.lastMessageCreatedAt.value
          : this.lastMessageCreatedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedConversationTableData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('lastSeq: $lastSeq, ')
          ..write('lastMessageId: $lastMessageId, ')
          ..write('lastMessageContent: $lastMessageContent, ')
          ..write('lastMessageType: $lastMessageType, ')
          ..write('lastMessageSenderId: $lastMessageSenderId, ')
          ..write('lastMessageSenderName: $lastMessageSenderName, ')
          ..write('lastMessageIsDeleted: $lastMessageIsDeleted, ')
          ..write('lastMessageCreatedAt: $lastMessageCreatedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    name,
    avatarUrl,
    lastSeq,
    lastMessageId,
    lastMessageContent,
    lastMessageType,
    lastMessageSenderId,
    lastMessageSenderName,
    lastMessageIsDeleted,
    lastMessageCreatedAt,
    updatedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedConversationTableData &&
          other.id == this.id &&
          other.type == this.type &&
          other.name == this.name &&
          other.avatarUrl == this.avatarUrl &&
          other.lastSeq == this.lastSeq &&
          other.lastMessageId == this.lastMessageId &&
          other.lastMessageContent == this.lastMessageContent &&
          other.lastMessageType == this.lastMessageType &&
          other.lastMessageSenderId == this.lastMessageSenderId &&
          other.lastMessageSenderName == this.lastMessageSenderName &&
          other.lastMessageIsDeleted == this.lastMessageIsDeleted &&
          other.lastMessageCreatedAt == this.lastMessageCreatedAt &&
          other.updatedAt == this.updatedAt &&
          other.createdAt == this.createdAt);
}

class CachedConversationTableCompanion
    extends UpdateCompanion<CachedConversationTableData> {
  final Value<String> id;
  final Value<String> type;
  final Value<String?> name;
  final Value<String?> avatarUrl;
  final Value<int> lastSeq;
  final Value<String?> lastMessageId;
  final Value<String?> lastMessageContent;
  final Value<String?> lastMessageType;
  final Value<String?> lastMessageSenderId;
  final Value<String?> lastMessageSenderName;
  final Value<bool> lastMessageIsDeleted;
  final Value<String?> lastMessageCreatedAt;
  final Value<String> updatedAt;
  final Value<String> createdAt;
  final Value<int> rowid;
  const CachedConversationTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.lastSeq = const Value.absent(),
    this.lastMessageId = const Value.absent(),
    this.lastMessageContent = const Value.absent(),
    this.lastMessageType = const Value.absent(),
    this.lastMessageSenderId = const Value.absent(),
    this.lastMessageSenderName = const Value.absent(),
    this.lastMessageIsDeleted = const Value.absent(),
    this.lastMessageCreatedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedConversationTableCompanion.insert({
    required String id,
    required String type,
    this.name = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    required int lastSeq,
    this.lastMessageId = const Value.absent(),
    this.lastMessageContent = const Value.absent(),
    this.lastMessageType = const Value.absent(),
    this.lastMessageSenderId = const Value.absent(),
    this.lastMessageSenderName = const Value.absent(),
    this.lastMessageIsDeleted = const Value.absent(),
    this.lastMessageCreatedAt = const Value.absent(),
    required String updatedAt,
    required String createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       lastSeq = Value(lastSeq),
       updatedAt = Value(updatedAt),
       createdAt = Value(createdAt);
  static Insertable<CachedConversationTableData> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? name,
    Expression<String>? avatarUrl,
    Expression<int>? lastSeq,
    Expression<String>? lastMessageId,
    Expression<String>? lastMessageContent,
    Expression<String>? lastMessageType,
    Expression<String>? lastMessageSenderId,
    Expression<String>? lastMessageSenderName,
    Expression<bool>? lastMessageIsDeleted,
    Expression<String>? lastMessageCreatedAt,
    Expression<String>? updatedAt,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (lastSeq != null) 'last_seq': lastSeq,
      if (lastMessageId != null) 'last_message_id': lastMessageId,
      if (lastMessageContent != null)
        'last_message_content': lastMessageContent,
      if (lastMessageType != null) 'last_message_type': lastMessageType,
      if (lastMessageSenderId != null)
        'last_message_sender_id': lastMessageSenderId,
      if (lastMessageSenderName != null)
        'last_message_sender_name': lastMessageSenderName,
      if (lastMessageIsDeleted != null)
        'last_message_is_deleted': lastMessageIsDeleted,
      if (lastMessageCreatedAt != null)
        'last_message_created_at': lastMessageCreatedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedConversationTableCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<String?>? name,
    Value<String?>? avatarUrl,
    Value<int>? lastSeq,
    Value<String?>? lastMessageId,
    Value<String?>? lastMessageContent,
    Value<String?>? lastMessageType,
    Value<String?>? lastMessageSenderId,
    Value<String?>? lastMessageSenderName,
    Value<bool>? lastMessageIsDeleted,
    Value<String?>? lastMessageCreatedAt,
    Value<String>? updatedAt,
    Value<String>? createdAt,
    Value<int>? rowid,
  }) {
    return CachedConversationTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      lastSeq: lastSeq ?? this.lastSeq,
      lastMessageId: lastMessageId ?? this.lastMessageId,
      lastMessageContent: lastMessageContent ?? this.lastMessageContent,
      lastMessageType: lastMessageType ?? this.lastMessageType,
      lastMessageSenderId: lastMessageSenderId ?? this.lastMessageSenderId,
      lastMessageSenderName:
          lastMessageSenderName ?? this.lastMessageSenderName,
      lastMessageIsDeleted: lastMessageIsDeleted ?? this.lastMessageIsDeleted,
      lastMessageCreatedAt: lastMessageCreatedAt ?? this.lastMessageCreatedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (lastSeq.present) {
      map['last_seq'] = Variable<int>(lastSeq.value);
    }
    if (lastMessageId.present) {
      map['last_message_id'] = Variable<String>(lastMessageId.value);
    }
    if (lastMessageContent.present) {
      map['last_message_content'] = Variable<String>(lastMessageContent.value);
    }
    if (lastMessageType.present) {
      map['last_message_type'] = Variable<String>(lastMessageType.value);
    }
    if (lastMessageSenderId.present) {
      map['last_message_sender_id'] = Variable<String>(
        lastMessageSenderId.value,
      );
    }
    if (lastMessageSenderName.present) {
      map['last_message_sender_name'] = Variable<String>(
        lastMessageSenderName.value,
      );
    }
    if (lastMessageIsDeleted.present) {
      map['last_message_is_deleted'] = Variable<bool>(
        lastMessageIsDeleted.value,
      );
    }
    if (lastMessageCreatedAt.present) {
      map['last_message_created_at'] = Variable<String>(
        lastMessageCreatedAt.value,
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedConversationTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('lastSeq: $lastSeq, ')
          ..write('lastMessageId: $lastMessageId, ')
          ..write('lastMessageContent: $lastMessageContent, ')
          ..write('lastMessageType: $lastMessageType, ')
          ..write('lastMessageSenderId: $lastMessageSenderId, ')
          ..write('lastMessageSenderName: $lastMessageSenderName, ')
          ..write('lastMessageIsDeleted: $lastMessageIsDeleted, ')
          ..write('lastMessageCreatedAt: $lastMessageCreatedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedParticipantTableTable extends CachedParticipantTable
    with TableInfo<$CachedParticipantTableTable, CachedParticipantTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedParticipantTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastReadSeqMeta = const VerificationMeta(
    'lastReadSeq',
  );
  @override
  late final GeneratedColumn<int> lastReadSeq = GeneratedColumn<int>(
    'last_read_seq',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _leftAtMeta = const VerificationMeta('leftAt');
  @override
  late final GeneratedColumn<String> leftAt = GeneratedColumn<String>(
    'left_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    conversationId,
    userId,
    fullName,
    avatarUrl,
    role,
    lastReadSeq,
    leftAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_participant_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedParticipantTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('last_read_seq')) {
      context.handle(
        _lastReadSeqMeta,
        lastReadSeq.isAcceptableOrUnknown(
          data['last_read_seq']!,
          _lastReadSeqMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastReadSeqMeta);
    }
    if (data.containsKey('left_at')) {
      context.handle(
        _leftAtMeta,
        leftAt.isAcceptableOrUnknown(data['left_at']!, _leftAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {conversationId, userId};
  @override
  CachedParticipantTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedParticipantTableData(
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conversation_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      lastReadSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_read_seq'],
      )!,
      leftAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}left_at'],
      ),
    );
  }

  @override
  $CachedParticipantTableTable createAlias(String alias) {
    return $CachedParticipantTableTable(attachedDatabase, alias);
  }
}

class CachedParticipantTableData extends DataClass
    implements Insertable<CachedParticipantTableData> {
  final String conversationId;
  final String userId;
  final String fullName;
  final String? avatarUrl;
  final String role;
  final int lastReadSeq;
  final String? leftAt;
  const CachedParticipantTableData({
    required this.conversationId,
    required this.userId,
    required this.fullName,
    this.avatarUrl,
    required this.role,
    required this.lastReadSeq,
    this.leftAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['conversation_id'] = Variable<String>(conversationId);
    map['user_id'] = Variable<String>(userId);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    map['role'] = Variable<String>(role);
    map['last_read_seq'] = Variable<int>(lastReadSeq);
    if (!nullToAbsent || leftAt != null) {
      map['left_at'] = Variable<String>(leftAt);
    }
    return map;
  }

  CachedParticipantTableCompanion toCompanion(bool nullToAbsent) {
    return CachedParticipantTableCompanion(
      conversationId: Value(conversationId),
      userId: Value(userId),
      fullName: Value(fullName),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      role: Value(role),
      lastReadSeq: Value(lastReadSeq),
      leftAt: leftAt == null && nullToAbsent
          ? const Value.absent()
          : Value(leftAt),
    );
  }

  factory CachedParticipantTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedParticipantTableData(
      conversationId: serializer.fromJson<String>(json['conversationId']),
      userId: serializer.fromJson<String>(json['userId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      role: serializer.fromJson<String>(json['role']),
      lastReadSeq: serializer.fromJson<int>(json['lastReadSeq']),
      leftAt: serializer.fromJson<String?>(json['leftAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'conversationId': serializer.toJson<String>(conversationId),
      'userId': serializer.toJson<String>(userId),
      'fullName': serializer.toJson<String>(fullName),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'role': serializer.toJson<String>(role),
      'lastReadSeq': serializer.toJson<int>(lastReadSeq),
      'leftAt': serializer.toJson<String?>(leftAt),
    };
  }

  CachedParticipantTableData copyWith({
    String? conversationId,
    String? userId,
    String? fullName,
    Value<String?> avatarUrl = const Value.absent(),
    String? role,
    int? lastReadSeq,
    Value<String?> leftAt = const Value.absent(),
  }) => CachedParticipantTableData(
    conversationId: conversationId ?? this.conversationId,
    userId: userId ?? this.userId,
    fullName: fullName ?? this.fullName,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    role: role ?? this.role,
    lastReadSeq: lastReadSeq ?? this.lastReadSeq,
    leftAt: leftAt.present ? leftAt.value : this.leftAt,
  );
  CachedParticipantTableData copyWithCompanion(
    CachedParticipantTableCompanion data,
  ) {
    return CachedParticipantTableData(
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      userId: data.userId.present ? data.userId.value : this.userId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      role: data.role.present ? data.role.value : this.role,
      lastReadSeq: data.lastReadSeq.present
          ? data.lastReadSeq.value
          : this.lastReadSeq,
      leftAt: data.leftAt.present ? data.leftAt.value : this.leftAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedParticipantTableData(')
          ..write('conversationId: $conversationId, ')
          ..write('userId: $userId, ')
          ..write('fullName: $fullName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('role: $role, ')
          ..write('lastReadSeq: $lastReadSeq, ')
          ..write('leftAt: $leftAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    conversationId,
    userId,
    fullName,
    avatarUrl,
    role,
    lastReadSeq,
    leftAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedParticipantTableData &&
          other.conversationId == this.conversationId &&
          other.userId == this.userId &&
          other.fullName == this.fullName &&
          other.avatarUrl == this.avatarUrl &&
          other.role == this.role &&
          other.lastReadSeq == this.lastReadSeq &&
          other.leftAt == this.leftAt);
}

class CachedParticipantTableCompanion
    extends UpdateCompanion<CachedParticipantTableData> {
  final Value<String> conversationId;
  final Value<String> userId;
  final Value<String> fullName;
  final Value<String?> avatarUrl;
  final Value<String> role;
  final Value<int> lastReadSeq;
  final Value<String?> leftAt;
  final Value<int> rowid;
  const CachedParticipantTableCompanion({
    this.conversationId = const Value.absent(),
    this.userId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.role = const Value.absent(),
    this.lastReadSeq = const Value.absent(),
    this.leftAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedParticipantTableCompanion.insert({
    required String conversationId,
    required String userId,
    required String fullName,
    this.avatarUrl = const Value.absent(),
    required String role,
    required int lastReadSeq,
    this.leftAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : conversationId = Value(conversationId),
       userId = Value(userId),
       fullName = Value(fullName),
       role = Value(role),
       lastReadSeq = Value(lastReadSeq);
  static Insertable<CachedParticipantTableData> custom({
    Expression<String>? conversationId,
    Expression<String>? userId,
    Expression<String>? fullName,
    Expression<String>? avatarUrl,
    Expression<String>? role,
    Expression<int>? lastReadSeq,
    Expression<String>? leftAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (conversationId != null) 'conversation_id': conversationId,
      if (userId != null) 'user_id': userId,
      if (fullName != null) 'full_name': fullName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (role != null) 'role': role,
      if (lastReadSeq != null) 'last_read_seq': lastReadSeq,
      if (leftAt != null) 'left_at': leftAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedParticipantTableCompanion copyWith({
    Value<String>? conversationId,
    Value<String>? userId,
    Value<String>? fullName,
    Value<String?>? avatarUrl,
    Value<String>? role,
    Value<int>? lastReadSeq,
    Value<String?>? leftAt,
    Value<int>? rowid,
  }) {
    return CachedParticipantTableCompanion(
      conversationId: conversationId ?? this.conversationId,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      lastReadSeq: lastReadSeq ?? this.lastReadSeq,
      leftAt: leftAt ?? this.leftAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (lastReadSeq.present) {
      map['last_read_seq'] = Variable<int>(lastReadSeq.value);
    }
    if (leftAt.present) {
      map['left_at'] = Variable<String>(leftAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedParticipantTableCompanion(')
          ..write('conversationId: $conversationId, ')
          ..write('userId: $userId, ')
          ..write('fullName: $fullName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('role: $role, ')
          ..write('lastReadSeq: $lastReadSeq, ')
          ..write('leftAt: $leftAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedMessageTableTable extends CachedMessageTable
    with TableInfo<$CachedMessageTableTable, CachedMessageTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedMessageTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seqMeta = const VerificationMeta('seq');
  @override
  late final GeneratedColumn<int> seq = GeneratedColumn<int>(
    'seq',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderIdMeta = const VerificationMeta(
    'senderId',
  );
  @override
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
    'sender_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isEditedMeta = const VerificationMeta(
    'isEdited',
  );
  @override
  late final GeneratedColumn<bool> isEdited = GeneratedColumn<bool>(
    'is_edited',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_edited" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reactionsJsonMeta = const VerificationMeta(
    'reactionsJson',
  );
  @override
  late final GeneratedColumn<String> reactionsJson = GeneratedColumn<String>(
    'reactions_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _replyToIdMeta = const VerificationMeta(
    'replyToId',
  );
  @override
  late final GeneratedColumn<String> replyToId = GeneratedColumn<String>(
    'reply_to_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    conversationId,
    seq,
    content,
    type,
    senderId,
    isEdited,
    isDeleted,
    reactionsJson,
    replyToId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_message_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedMessageTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('seq')) {
      context.handle(
        _seqMeta,
        seq.isAcceptableOrUnknown(data['seq']!, _seqMeta),
      );
    } else if (isInserting) {
      context.missing(_seqMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(
        _senderIdMeta,
        senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_senderIdMeta);
    }
    if (data.containsKey('is_edited')) {
      context.handle(
        _isEditedMeta,
        isEdited.isAcceptableOrUnknown(data['is_edited']!, _isEditedMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('reactions_json')) {
      context.handle(
        _reactionsJsonMeta,
        reactionsJson.isAcceptableOrUnknown(
          data['reactions_json']!,
          _reactionsJsonMeta,
        ),
      );
    }
    if (data.containsKey('reply_to_id')) {
      context.handle(
        _replyToIdMeta,
        replyToId.isAcceptableOrUnknown(data['reply_to_id']!, _replyToIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedMessageTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedMessageTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conversation_id'],
      )!,
      seq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seq'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      senderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_id'],
      )!,
      isEdited: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_edited'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      reactionsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reactions_json'],
      )!,
      replyToId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reply_to_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CachedMessageTableTable createAlias(String alias) {
    return $CachedMessageTableTable(attachedDatabase, alias);
  }
}

class CachedMessageTableData extends DataClass
    implements Insertable<CachedMessageTableData> {
  final String id;
  final String conversationId;
  final int seq;
  final String? content;
  final String type;
  final String senderId;
  final bool isEdited;
  final bool isDeleted;
  final String reactionsJson;
  final String? replyToId;
  final String createdAt;
  const CachedMessageTableData({
    required this.id,
    required this.conversationId,
    required this.seq,
    this.content,
    required this.type,
    required this.senderId,
    required this.isEdited,
    required this.isDeleted,
    required this.reactionsJson,
    this.replyToId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['conversation_id'] = Variable<String>(conversationId);
    map['seq'] = Variable<int>(seq);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    map['type'] = Variable<String>(type);
    map['sender_id'] = Variable<String>(senderId);
    map['is_edited'] = Variable<bool>(isEdited);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['reactions_json'] = Variable<String>(reactionsJson);
    if (!nullToAbsent || replyToId != null) {
      map['reply_to_id'] = Variable<String>(replyToId);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  CachedMessageTableCompanion toCompanion(bool nullToAbsent) {
    return CachedMessageTableCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      seq: Value(seq),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      type: Value(type),
      senderId: Value(senderId),
      isEdited: Value(isEdited),
      isDeleted: Value(isDeleted),
      reactionsJson: Value(reactionsJson),
      replyToId: replyToId == null && nullToAbsent
          ? const Value.absent()
          : Value(replyToId),
      createdAt: Value(createdAt),
    );
  }

  factory CachedMessageTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedMessageTableData(
      id: serializer.fromJson<String>(json['id']),
      conversationId: serializer.fromJson<String>(json['conversationId']),
      seq: serializer.fromJson<int>(json['seq']),
      content: serializer.fromJson<String?>(json['content']),
      type: serializer.fromJson<String>(json['type']),
      senderId: serializer.fromJson<String>(json['senderId']),
      isEdited: serializer.fromJson<bool>(json['isEdited']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      reactionsJson: serializer.fromJson<String>(json['reactionsJson']),
      replyToId: serializer.fromJson<String?>(json['replyToId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'conversationId': serializer.toJson<String>(conversationId),
      'seq': serializer.toJson<int>(seq),
      'content': serializer.toJson<String?>(content),
      'type': serializer.toJson<String>(type),
      'senderId': serializer.toJson<String>(senderId),
      'isEdited': serializer.toJson<bool>(isEdited),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'reactionsJson': serializer.toJson<String>(reactionsJson),
      'replyToId': serializer.toJson<String?>(replyToId),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  CachedMessageTableData copyWith({
    String? id,
    String? conversationId,
    int? seq,
    Value<String?> content = const Value.absent(),
    String? type,
    String? senderId,
    bool? isEdited,
    bool? isDeleted,
    String? reactionsJson,
    Value<String?> replyToId = const Value.absent(),
    String? createdAt,
  }) => CachedMessageTableData(
    id: id ?? this.id,
    conversationId: conversationId ?? this.conversationId,
    seq: seq ?? this.seq,
    content: content.present ? content.value : this.content,
    type: type ?? this.type,
    senderId: senderId ?? this.senderId,
    isEdited: isEdited ?? this.isEdited,
    isDeleted: isDeleted ?? this.isDeleted,
    reactionsJson: reactionsJson ?? this.reactionsJson,
    replyToId: replyToId.present ? replyToId.value : this.replyToId,
    createdAt: createdAt ?? this.createdAt,
  );
  CachedMessageTableData copyWithCompanion(CachedMessageTableCompanion data) {
    return CachedMessageTableData(
      id: data.id.present ? data.id.value : this.id,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      seq: data.seq.present ? data.seq.value : this.seq,
      content: data.content.present ? data.content.value : this.content,
      type: data.type.present ? data.type.value : this.type,
      senderId: data.senderId.present ? data.senderId.value : this.senderId,
      isEdited: data.isEdited.present ? data.isEdited.value : this.isEdited,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      reactionsJson: data.reactionsJson.present
          ? data.reactionsJson.value
          : this.reactionsJson,
      replyToId: data.replyToId.present ? data.replyToId.value : this.replyToId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedMessageTableData(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('seq: $seq, ')
          ..write('content: $content, ')
          ..write('type: $type, ')
          ..write('senderId: $senderId, ')
          ..write('isEdited: $isEdited, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('reactionsJson: $reactionsJson, ')
          ..write('replyToId: $replyToId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    conversationId,
    seq,
    content,
    type,
    senderId,
    isEdited,
    isDeleted,
    reactionsJson,
    replyToId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedMessageTableData &&
          other.id == this.id &&
          other.conversationId == this.conversationId &&
          other.seq == this.seq &&
          other.content == this.content &&
          other.type == this.type &&
          other.senderId == this.senderId &&
          other.isEdited == this.isEdited &&
          other.isDeleted == this.isDeleted &&
          other.reactionsJson == this.reactionsJson &&
          other.replyToId == this.replyToId &&
          other.createdAt == this.createdAt);
}

class CachedMessageTableCompanion
    extends UpdateCompanion<CachedMessageTableData> {
  final Value<String> id;
  final Value<String> conversationId;
  final Value<int> seq;
  final Value<String?> content;
  final Value<String> type;
  final Value<String> senderId;
  final Value<bool> isEdited;
  final Value<bool> isDeleted;
  final Value<String> reactionsJson;
  final Value<String?> replyToId;
  final Value<String> createdAt;
  final Value<int> rowid;
  const CachedMessageTableCompanion({
    this.id = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.seq = const Value.absent(),
    this.content = const Value.absent(),
    this.type = const Value.absent(),
    this.senderId = const Value.absent(),
    this.isEdited = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.reactionsJson = const Value.absent(),
    this.replyToId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedMessageTableCompanion.insert({
    required String id,
    required String conversationId,
    required int seq,
    this.content = const Value.absent(),
    required String type,
    required String senderId,
    this.isEdited = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.reactionsJson = const Value.absent(),
    this.replyToId = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       conversationId = Value(conversationId),
       seq = Value(seq),
       type = Value(type),
       senderId = Value(senderId),
       createdAt = Value(createdAt);
  static Insertable<CachedMessageTableData> custom({
    Expression<String>? id,
    Expression<String>? conversationId,
    Expression<int>? seq,
    Expression<String>? content,
    Expression<String>? type,
    Expression<String>? senderId,
    Expression<bool>? isEdited,
    Expression<bool>? isDeleted,
    Expression<String>? reactionsJson,
    Expression<String>? replyToId,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conversationId != null) 'conversation_id': conversationId,
      if (seq != null) 'seq': seq,
      if (content != null) 'content': content,
      if (type != null) 'type': type,
      if (senderId != null) 'sender_id': senderId,
      if (isEdited != null) 'is_edited': isEdited,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (reactionsJson != null) 'reactions_json': reactionsJson,
      if (replyToId != null) 'reply_to_id': replyToId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedMessageTableCompanion copyWith({
    Value<String>? id,
    Value<String>? conversationId,
    Value<int>? seq,
    Value<String?>? content,
    Value<String>? type,
    Value<String>? senderId,
    Value<bool>? isEdited,
    Value<bool>? isDeleted,
    Value<String>? reactionsJson,
    Value<String?>? replyToId,
    Value<String>? createdAt,
    Value<int>? rowid,
  }) {
    return CachedMessageTableCompanion(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      seq: seq ?? this.seq,
      content: content ?? this.content,
      type: type ?? this.type,
      senderId: senderId ?? this.senderId,
      isEdited: isEdited ?? this.isEdited,
      isDeleted: isDeleted ?? this.isDeleted,
      reactionsJson: reactionsJson ?? this.reactionsJson,
      replyToId: replyToId ?? this.replyToId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (seq.present) {
      map['seq'] = Variable<int>(seq.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<String>(senderId.value);
    }
    if (isEdited.present) {
      map['is_edited'] = Variable<bool>(isEdited.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (reactionsJson.present) {
      map['reactions_json'] = Variable<String>(reactionsJson.value);
    }
    if (replyToId.present) {
      map['reply_to_id'] = Variable<String>(replyToId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedMessageTableCompanion(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('seq: $seq, ')
          ..write('content: $content, ')
          ..write('type: $type, ')
          ..write('senderId: $senderId, ')
          ..write('isEdited: $isEdited, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('reactionsJson: $reactionsJson, ')
          ..write('replyToId: $replyToId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedUserTableTable cachedUserTable = $CachedUserTableTable(
    this,
  );
  late final $CachedNotificationTableTable cachedNotificationTable =
      $CachedNotificationTableTable(this);
  late final $CachedConversationTableTable cachedConversationTable =
      $CachedConversationTableTable(this);
  late final $CachedParticipantTableTable cachedParticipantTable =
      $CachedParticipantTableTable(this);
  late final $CachedMessageTableTable cachedMessageTable =
      $CachedMessageTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedUserTable,
    cachedNotificationTable,
    cachedConversationTable,
    cachedParticipantTable,
    cachedMessageTable,
  ];
}

typedef $$CachedUserTableTableCreateCompanionBuilder =
    CachedUserTableCompanion Function({
      required String id,
      required String fullName,
      required String username,
      required String email,
      Value<String?> bio,
      Value<String?> gender,
      Value<String?> dateOfBirth,
      Value<String?> phoneNumber,
      Value<String?> avatarUrl,
      Value<String?> backgroundUrl,
      Value<int> rowid,
    });
typedef $$CachedUserTableTableUpdateCompanionBuilder =
    CachedUserTableCompanion Function({
      Value<String> id,
      Value<String> fullName,
      Value<String> username,
      Value<String> email,
      Value<String?> bio,
      Value<String?> gender,
      Value<String?> dateOfBirth,
      Value<String?> phoneNumber,
      Value<String?> avatarUrl,
      Value<String?> backgroundUrl,
      Value<int> rowid,
    });

class $$CachedUserTableTableFilterComposer
    extends Composer<_$AppDatabase, $CachedUserTableTable> {
  $$CachedUserTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backgroundUrl => $composableBuilder(
    column: $table.backgroundUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedUserTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedUserTableTable> {
  $$CachedUserTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backgroundUrl => $composableBuilder(
    column: $table.backgroundUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedUserTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedUserTableTable> {
  $$CachedUserTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get bio =>
      $composableBuilder(column: $table.bio, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get backgroundUrl => $composableBuilder(
    column: $table.backgroundUrl,
    builder: (column) => column,
  );
}

class $$CachedUserTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedUserTableTable,
          CachedUserTableData,
          $$CachedUserTableTableFilterComposer,
          $$CachedUserTableTableOrderingComposer,
          $$CachedUserTableTableAnnotationComposer,
          $$CachedUserTableTableCreateCompanionBuilder,
          $$CachedUserTableTableUpdateCompanionBuilder,
          (
            CachedUserTableData,
            BaseReferences<
              _$AppDatabase,
              $CachedUserTableTable,
              CachedUserTableData
            >,
          ),
          CachedUserTableData,
          PrefetchHooks Function()
        > {
  $$CachedUserTableTableTableManager(
    _$AppDatabase db,
    $CachedUserTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedUserTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedUserTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedUserTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<String?> dateOfBirth = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> backgroundUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedUserTableCompanion(
                id: id,
                fullName: fullName,
                username: username,
                email: email,
                bio: bio,
                gender: gender,
                dateOfBirth: dateOfBirth,
                phoneNumber: phoneNumber,
                avatarUrl: avatarUrl,
                backgroundUrl: backgroundUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fullName,
                required String username,
                required String email,
                Value<String?> bio = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<String?> dateOfBirth = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> backgroundUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedUserTableCompanion.insert(
                id: id,
                fullName: fullName,
                username: username,
                email: email,
                bio: bio,
                gender: gender,
                dateOfBirth: dateOfBirth,
                phoneNumber: phoneNumber,
                avatarUrl: avatarUrl,
                backgroundUrl: backgroundUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedUserTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedUserTableTable,
      CachedUserTableData,
      $$CachedUserTableTableFilterComposer,
      $$CachedUserTableTableOrderingComposer,
      $$CachedUserTableTableAnnotationComposer,
      $$CachedUserTableTableCreateCompanionBuilder,
      $$CachedUserTableTableUpdateCompanionBuilder,
      (
        CachedUserTableData,
        BaseReferences<
          _$AppDatabase,
          $CachedUserTableTable,
          CachedUserTableData
        >,
      ),
      CachedUserTableData,
      PrefetchHooks Function()
    >;
typedef $$CachedNotificationTableTableCreateCompanionBuilder =
    CachedNotificationTableCompanion Function({
      required String id,
      required String type,
      required String payload,
      Value<bool> isRead,
      required String createdAt,
      Value<int> rowid,
    });
typedef $$CachedNotificationTableTableUpdateCompanionBuilder =
    CachedNotificationTableCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<String> payload,
      Value<bool> isRead,
      Value<String> createdAt,
      Value<int> rowid,
    });

class $$CachedNotificationTableTableFilterComposer
    extends Composer<_$AppDatabase, $CachedNotificationTableTable> {
  $$CachedNotificationTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedNotificationTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedNotificationTableTable> {
  $$CachedNotificationTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedNotificationTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedNotificationTableTable> {
  $$CachedNotificationTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CachedNotificationTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedNotificationTableTable,
          CachedNotificationTableData,
          $$CachedNotificationTableTableFilterComposer,
          $$CachedNotificationTableTableOrderingComposer,
          $$CachedNotificationTableTableAnnotationComposer,
          $$CachedNotificationTableTableCreateCompanionBuilder,
          $$CachedNotificationTableTableUpdateCompanionBuilder,
          (
            CachedNotificationTableData,
            BaseReferences<
              _$AppDatabase,
              $CachedNotificationTableTable,
              CachedNotificationTableData
            >,
          ),
          CachedNotificationTableData,
          PrefetchHooks Function()
        > {
  $$CachedNotificationTableTableTableManager(
    _$AppDatabase db,
    $CachedNotificationTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedNotificationTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CachedNotificationTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CachedNotificationTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedNotificationTableCompanion(
                id: id,
                type: type,
                payload: payload,
                isRead: isRead,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required String payload,
                Value<bool> isRead = const Value.absent(),
                required String createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedNotificationTableCompanion.insert(
                id: id,
                type: type,
                payload: payload,
                isRead: isRead,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedNotificationTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedNotificationTableTable,
      CachedNotificationTableData,
      $$CachedNotificationTableTableFilterComposer,
      $$CachedNotificationTableTableOrderingComposer,
      $$CachedNotificationTableTableAnnotationComposer,
      $$CachedNotificationTableTableCreateCompanionBuilder,
      $$CachedNotificationTableTableUpdateCompanionBuilder,
      (
        CachedNotificationTableData,
        BaseReferences<
          _$AppDatabase,
          $CachedNotificationTableTable,
          CachedNotificationTableData
        >,
      ),
      CachedNotificationTableData,
      PrefetchHooks Function()
    >;
typedef $$CachedConversationTableTableCreateCompanionBuilder =
    CachedConversationTableCompanion Function({
      required String id,
      required String type,
      Value<String?> name,
      Value<String?> avatarUrl,
      required int lastSeq,
      Value<String?> lastMessageId,
      Value<String?> lastMessageContent,
      Value<String?> lastMessageType,
      Value<String?> lastMessageSenderId,
      Value<String?> lastMessageSenderName,
      Value<bool> lastMessageIsDeleted,
      Value<String?> lastMessageCreatedAt,
      required String updatedAt,
      required String createdAt,
      Value<int> rowid,
    });
typedef $$CachedConversationTableTableUpdateCompanionBuilder =
    CachedConversationTableCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<String?> name,
      Value<String?> avatarUrl,
      Value<int> lastSeq,
      Value<String?> lastMessageId,
      Value<String?> lastMessageContent,
      Value<String?> lastMessageType,
      Value<String?> lastMessageSenderId,
      Value<String?> lastMessageSenderName,
      Value<bool> lastMessageIsDeleted,
      Value<String?> lastMessageCreatedAt,
      Value<String> updatedAt,
      Value<String> createdAt,
      Value<int> rowid,
    });

class $$CachedConversationTableTableFilterComposer
    extends Composer<_$AppDatabase, $CachedConversationTableTable> {
  $$CachedConversationTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastSeq => $composableBuilder(
    column: $table.lastSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageId => $composableBuilder(
    column: $table.lastMessageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageContent => $composableBuilder(
    column: $table.lastMessageContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageType => $composableBuilder(
    column: $table.lastMessageType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageSenderId => $composableBuilder(
    column: $table.lastMessageSenderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageSenderName => $composableBuilder(
    column: $table.lastMessageSenderName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get lastMessageIsDeleted => $composableBuilder(
    column: $table.lastMessageIsDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessageCreatedAt => $composableBuilder(
    column: $table.lastMessageCreatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedConversationTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedConversationTableTable> {
  $$CachedConversationTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastSeq => $composableBuilder(
    column: $table.lastSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageId => $composableBuilder(
    column: $table.lastMessageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageContent => $composableBuilder(
    column: $table.lastMessageContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageType => $composableBuilder(
    column: $table.lastMessageType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageSenderId => $composableBuilder(
    column: $table.lastMessageSenderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageSenderName => $composableBuilder(
    column: $table.lastMessageSenderName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get lastMessageIsDeleted => $composableBuilder(
    column: $table.lastMessageIsDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessageCreatedAt => $composableBuilder(
    column: $table.lastMessageCreatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedConversationTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedConversationTableTable> {
  $$CachedConversationTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<int> get lastSeq =>
      $composableBuilder(column: $table.lastSeq, builder: (column) => column);

  GeneratedColumn<String> get lastMessageId => $composableBuilder(
    column: $table.lastMessageId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageContent => $composableBuilder(
    column: $table.lastMessageContent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageType => $composableBuilder(
    column: $table.lastMessageType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageSenderId => $composableBuilder(
    column: $table.lastMessageSenderId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageSenderName => $composableBuilder(
    column: $table.lastMessageSenderName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get lastMessageIsDeleted => $composableBuilder(
    column: $table.lastMessageIsDeleted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessageCreatedAt => $composableBuilder(
    column: $table.lastMessageCreatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CachedConversationTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedConversationTableTable,
          CachedConversationTableData,
          $$CachedConversationTableTableFilterComposer,
          $$CachedConversationTableTableOrderingComposer,
          $$CachedConversationTableTableAnnotationComposer,
          $$CachedConversationTableTableCreateCompanionBuilder,
          $$CachedConversationTableTableUpdateCompanionBuilder,
          (
            CachedConversationTableData,
            BaseReferences<
              _$AppDatabase,
              $CachedConversationTableTable,
              CachedConversationTableData
            >,
          ),
          CachedConversationTableData,
          PrefetchHooks Function()
        > {
  $$CachedConversationTableTableTableManager(
    _$AppDatabase db,
    $CachedConversationTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedConversationTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CachedConversationTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CachedConversationTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<int> lastSeq = const Value.absent(),
                Value<String?> lastMessageId = const Value.absent(),
                Value<String?> lastMessageContent = const Value.absent(),
                Value<String?> lastMessageType = const Value.absent(),
                Value<String?> lastMessageSenderId = const Value.absent(),
                Value<String?> lastMessageSenderName = const Value.absent(),
                Value<bool> lastMessageIsDeleted = const Value.absent(),
                Value<String?> lastMessageCreatedAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedConversationTableCompanion(
                id: id,
                type: type,
                name: name,
                avatarUrl: avatarUrl,
                lastSeq: lastSeq,
                lastMessageId: lastMessageId,
                lastMessageContent: lastMessageContent,
                lastMessageType: lastMessageType,
                lastMessageSenderId: lastMessageSenderId,
                lastMessageSenderName: lastMessageSenderName,
                lastMessageIsDeleted: lastMessageIsDeleted,
                lastMessageCreatedAt: lastMessageCreatedAt,
                updatedAt: updatedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                Value<String?> name = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                required int lastSeq,
                Value<String?> lastMessageId = const Value.absent(),
                Value<String?> lastMessageContent = const Value.absent(),
                Value<String?> lastMessageType = const Value.absent(),
                Value<String?> lastMessageSenderId = const Value.absent(),
                Value<String?> lastMessageSenderName = const Value.absent(),
                Value<bool> lastMessageIsDeleted = const Value.absent(),
                Value<String?> lastMessageCreatedAt = const Value.absent(),
                required String updatedAt,
                required String createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedConversationTableCompanion.insert(
                id: id,
                type: type,
                name: name,
                avatarUrl: avatarUrl,
                lastSeq: lastSeq,
                lastMessageId: lastMessageId,
                lastMessageContent: lastMessageContent,
                lastMessageType: lastMessageType,
                lastMessageSenderId: lastMessageSenderId,
                lastMessageSenderName: lastMessageSenderName,
                lastMessageIsDeleted: lastMessageIsDeleted,
                lastMessageCreatedAt: lastMessageCreatedAt,
                updatedAt: updatedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedConversationTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedConversationTableTable,
      CachedConversationTableData,
      $$CachedConversationTableTableFilterComposer,
      $$CachedConversationTableTableOrderingComposer,
      $$CachedConversationTableTableAnnotationComposer,
      $$CachedConversationTableTableCreateCompanionBuilder,
      $$CachedConversationTableTableUpdateCompanionBuilder,
      (
        CachedConversationTableData,
        BaseReferences<
          _$AppDatabase,
          $CachedConversationTableTable,
          CachedConversationTableData
        >,
      ),
      CachedConversationTableData,
      PrefetchHooks Function()
    >;
typedef $$CachedParticipantTableTableCreateCompanionBuilder =
    CachedParticipantTableCompanion Function({
      required String conversationId,
      required String userId,
      required String fullName,
      Value<String?> avatarUrl,
      required String role,
      required int lastReadSeq,
      Value<String?> leftAt,
      Value<int> rowid,
    });
typedef $$CachedParticipantTableTableUpdateCompanionBuilder =
    CachedParticipantTableCompanion Function({
      Value<String> conversationId,
      Value<String> userId,
      Value<String> fullName,
      Value<String?> avatarUrl,
      Value<String> role,
      Value<int> lastReadSeq,
      Value<String?> leftAt,
      Value<int> rowid,
    });

class $$CachedParticipantTableTableFilterComposer
    extends Composer<_$AppDatabase, $CachedParticipantTableTable> {
  $$CachedParticipantTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastReadSeq => $composableBuilder(
    column: $table.lastReadSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get leftAt => $composableBuilder(
    column: $table.leftAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedParticipantTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedParticipantTableTable> {
  $$CachedParticipantTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastReadSeq => $composableBuilder(
    column: $table.lastReadSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get leftAt => $composableBuilder(
    column: $table.leftAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedParticipantTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedParticipantTableTable> {
  $$CachedParticipantTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<int> get lastReadSeq => $composableBuilder(
    column: $table.lastReadSeq,
    builder: (column) => column,
  );

  GeneratedColumn<String> get leftAt =>
      $composableBuilder(column: $table.leftAt, builder: (column) => column);
}

class $$CachedParticipantTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedParticipantTableTable,
          CachedParticipantTableData,
          $$CachedParticipantTableTableFilterComposer,
          $$CachedParticipantTableTableOrderingComposer,
          $$CachedParticipantTableTableAnnotationComposer,
          $$CachedParticipantTableTableCreateCompanionBuilder,
          $$CachedParticipantTableTableUpdateCompanionBuilder,
          (
            CachedParticipantTableData,
            BaseReferences<
              _$AppDatabase,
              $CachedParticipantTableTable,
              CachedParticipantTableData
            >,
          ),
          CachedParticipantTableData,
          PrefetchHooks Function()
        > {
  $$CachedParticipantTableTableTableManager(
    _$AppDatabase db,
    $CachedParticipantTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedParticipantTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CachedParticipantTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CachedParticipantTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> conversationId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<int> lastReadSeq = const Value.absent(),
                Value<String?> leftAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedParticipantTableCompanion(
                conversationId: conversationId,
                userId: userId,
                fullName: fullName,
                avatarUrl: avatarUrl,
                role: role,
                lastReadSeq: lastReadSeq,
                leftAt: leftAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String conversationId,
                required String userId,
                required String fullName,
                Value<String?> avatarUrl = const Value.absent(),
                required String role,
                required int lastReadSeq,
                Value<String?> leftAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedParticipantTableCompanion.insert(
                conversationId: conversationId,
                userId: userId,
                fullName: fullName,
                avatarUrl: avatarUrl,
                role: role,
                lastReadSeq: lastReadSeq,
                leftAt: leftAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedParticipantTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedParticipantTableTable,
      CachedParticipantTableData,
      $$CachedParticipantTableTableFilterComposer,
      $$CachedParticipantTableTableOrderingComposer,
      $$CachedParticipantTableTableAnnotationComposer,
      $$CachedParticipantTableTableCreateCompanionBuilder,
      $$CachedParticipantTableTableUpdateCompanionBuilder,
      (
        CachedParticipantTableData,
        BaseReferences<
          _$AppDatabase,
          $CachedParticipantTableTable,
          CachedParticipantTableData
        >,
      ),
      CachedParticipantTableData,
      PrefetchHooks Function()
    >;
typedef $$CachedMessageTableTableCreateCompanionBuilder =
    CachedMessageTableCompanion Function({
      required String id,
      required String conversationId,
      required int seq,
      Value<String?> content,
      required String type,
      required String senderId,
      Value<bool> isEdited,
      Value<bool> isDeleted,
      Value<String> reactionsJson,
      Value<String?> replyToId,
      required String createdAt,
      Value<int> rowid,
    });
typedef $$CachedMessageTableTableUpdateCompanionBuilder =
    CachedMessageTableCompanion Function({
      Value<String> id,
      Value<String> conversationId,
      Value<int> seq,
      Value<String?> content,
      Value<String> type,
      Value<String> senderId,
      Value<bool> isEdited,
      Value<bool> isDeleted,
      Value<String> reactionsJson,
      Value<String?> replyToId,
      Value<String> createdAt,
      Value<int> rowid,
    });

class $$CachedMessageTableTableFilterComposer
    extends Composer<_$AppDatabase, $CachedMessageTableTable> {
  $$CachedMessageTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEdited => $composableBuilder(
    column: $table.isEdited,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reactionsJson => $composableBuilder(
    column: $table.reactionsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get replyToId => $composableBuilder(
    column: $table.replyToId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedMessageTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedMessageTableTable> {
  $$CachedMessageTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEdited => $composableBuilder(
    column: $table.isEdited,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reactionsJson => $composableBuilder(
    column: $table.reactionsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get replyToId => $composableBuilder(
    column: $table.replyToId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedMessageTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedMessageTableTable> {
  $$CachedMessageTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get seq =>
      $composableBuilder(column: $table.seq, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get senderId =>
      $composableBuilder(column: $table.senderId, builder: (column) => column);

  GeneratedColumn<bool> get isEdited =>
      $composableBuilder(column: $table.isEdited, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<String> get reactionsJson => $composableBuilder(
    column: $table.reactionsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get replyToId =>
      $composableBuilder(column: $table.replyToId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CachedMessageTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedMessageTableTable,
          CachedMessageTableData,
          $$CachedMessageTableTableFilterComposer,
          $$CachedMessageTableTableOrderingComposer,
          $$CachedMessageTableTableAnnotationComposer,
          $$CachedMessageTableTableCreateCompanionBuilder,
          $$CachedMessageTableTableUpdateCompanionBuilder,
          (
            CachedMessageTableData,
            BaseReferences<
              _$AppDatabase,
              $CachedMessageTableTable,
              CachedMessageTableData
            >,
          ),
          CachedMessageTableData,
          PrefetchHooks Function()
        > {
  $$CachedMessageTableTableTableManager(
    _$AppDatabase db,
    $CachedMessageTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedMessageTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedMessageTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedMessageTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> conversationId = const Value.absent(),
                Value<int> seq = const Value.absent(),
                Value<String?> content = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> senderId = const Value.absent(),
                Value<bool> isEdited = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String> reactionsJson = const Value.absent(),
                Value<String?> replyToId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedMessageTableCompanion(
                id: id,
                conversationId: conversationId,
                seq: seq,
                content: content,
                type: type,
                senderId: senderId,
                isEdited: isEdited,
                isDeleted: isDeleted,
                reactionsJson: reactionsJson,
                replyToId: replyToId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String conversationId,
                required int seq,
                Value<String?> content = const Value.absent(),
                required String type,
                required String senderId,
                Value<bool> isEdited = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<String> reactionsJson = const Value.absent(),
                Value<String?> replyToId = const Value.absent(),
                required String createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedMessageTableCompanion.insert(
                id: id,
                conversationId: conversationId,
                seq: seq,
                content: content,
                type: type,
                senderId: senderId,
                isEdited: isEdited,
                isDeleted: isDeleted,
                reactionsJson: reactionsJson,
                replyToId: replyToId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedMessageTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedMessageTableTable,
      CachedMessageTableData,
      $$CachedMessageTableTableFilterComposer,
      $$CachedMessageTableTableOrderingComposer,
      $$CachedMessageTableTableAnnotationComposer,
      $$CachedMessageTableTableCreateCompanionBuilder,
      $$CachedMessageTableTableUpdateCompanionBuilder,
      (
        CachedMessageTableData,
        BaseReferences<
          _$AppDatabase,
          $CachedMessageTableTable,
          CachedMessageTableData
        >,
      ),
      CachedMessageTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedUserTableTableTableManager get cachedUserTable =>
      $$CachedUserTableTableTableManager(_db, _db.cachedUserTable);
  $$CachedNotificationTableTableTableManager get cachedNotificationTable =>
      $$CachedNotificationTableTableTableManager(
        _db,
        _db.cachedNotificationTable,
      );
  $$CachedConversationTableTableTableManager get cachedConversationTable =>
      $$CachedConversationTableTableTableManager(
        _db,
        _db.cachedConversationTable,
      );
  $$CachedParticipantTableTableTableManager get cachedParticipantTable =>
      $$CachedParticipantTableTableTableManager(
        _db,
        _db.cachedParticipantTable,
      );
  $$CachedMessageTableTableTableManager get cachedMessageTable =>
      $$CachedMessageTableTableTableManager(_db, _db.cachedMessageTable);
}
