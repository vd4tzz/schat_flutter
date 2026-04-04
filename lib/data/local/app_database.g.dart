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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedUserTableTable cachedUserTable = $CachedUserTableTable(
    this,
  );
  late final $CachedNotificationTableTable cachedNotificationTable =
      $CachedNotificationTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedUserTable,
    cachedNotificationTable,
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
}
