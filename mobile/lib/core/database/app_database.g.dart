// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DecksTable extends Decks with TableInfo<$DecksTable, DeckRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DecksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
    'locale',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('en'),
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMsMeta = const VerificationMeta(
    'deletedAtMs',
  );
  @override
  late final GeneratedColumn<int> deletedAtMs = GeneratedColumn<int>(
    'deleted_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    author,
    locale,
    version,
    createdAtMs,
    updatedAtMs,
    deletedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'decks';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeckRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('locale')) {
      context.handle(
        _localeMeta,
        locale.isAcceptableOrUnknown(data['locale']!, _localeMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('deleted_at_ms')) {
      context.handle(
        _deletedAtMsMeta,
        deletedAtMs.isAcceptableOrUnknown(
          data['deleted_at_ms']!,
          _deletedAtMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeckRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeckRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      )!,
      locale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      deletedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at_ms'],
      ),
    );
  }

  @override
  $DecksTable createAlias(String alias) {
    return $DecksTable(attachedDatabase, alias);
  }
}

class DeckRow extends DataClass implements Insertable<DeckRow> {
  final String id;
  final String title;
  final String description;
  final String author;
  final String locale;
  final int version;
  final int createdAtMs;
  final int updatedAtMs;
  final int? deletedAtMs;
  const DeckRow({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.locale,
    required this.version,
    required this.createdAtMs,
    required this.updatedAtMs,
    this.deletedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['author'] = Variable<String>(author);
    map['locale'] = Variable<String>(locale);
    map['version'] = Variable<int>(version);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    if (!nullToAbsent || deletedAtMs != null) {
      map['deleted_at_ms'] = Variable<int>(deletedAtMs);
    }
    return map;
  }

  DecksCompanion toCompanion(bool nullToAbsent) {
    return DecksCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      author: Value(author),
      locale: Value(locale),
      version: Value(version),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
      deletedAtMs: deletedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAtMs),
    );
  }

  factory DeckRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeckRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      author: serializer.fromJson<String>(json['author']),
      locale: serializer.fromJson<String>(json['locale']),
      version: serializer.fromJson<int>(json['version']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      deletedAtMs: serializer.fromJson<int?>(json['deletedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'author': serializer.toJson<String>(author),
      'locale': serializer.toJson<String>(locale),
      'version': serializer.toJson<int>(version),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'deletedAtMs': serializer.toJson<int?>(deletedAtMs),
    };
  }

  DeckRow copyWith({
    String? id,
    String? title,
    String? description,
    String? author,
    String? locale,
    int? version,
    int? createdAtMs,
    int? updatedAtMs,
    Value<int?> deletedAtMs = const Value.absent(),
  }) => DeckRow(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    author: author ?? this.author,
    locale: locale ?? this.locale,
    version: version ?? this.version,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    deletedAtMs: deletedAtMs.present ? deletedAtMs.value : this.deletedAtMs,
  );
  DeckRow copyWithCompanion(DecksCompanion data) {
    return DeckRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      author: data.author.present ? data.author.value : this.author,
      locale: data.locale.present ? data.locale.value : this.locale,
      version: data.version.present ? data.version.value : this.version,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      deletedAtMs: data.deletedAtMs.present
          ? data.deletedAtMs.value
          : this.deletedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeckRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('author: $author, ')
          ..write('locale: $locale, ')
          ..write('version: $version, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('deletedAtMs: $deletedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    author,
    locale,
    version,
    createdAtMs,
    updatedAtMs,
    deletedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeckRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.author == this.author &&
          other.locale == this.locale &&
          other.version == this.version &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.deletedAtMs == this.deletedAtMs);
}

class DecksCompanion extends UpdateCompanion<DeckRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> author;
  final Value<String> locale;
  final Value<int> version;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<int?> deletedAtMs;
  final Value<int> rowid;
  const DecksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.author = const Value.absent(),
    this.locale = const Value.absent(),
    this.version = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.deletedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DecksCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    this.author = const Value.absent(),
    this.locale = const Value.absent(),
    this.version = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.deletedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<DeckRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? author,
    Expression<String>? locale,
    Expression<int>? version,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<int>? deletedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (author != null) 'author': author,
      if (locale != null) 'locale': locale,
      if (version != null) 'version': version,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (deletedAtMs != null) 'deleted_at_ms': deletedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DecksCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<String>? author,
    Value<String>? locale,
    Value<int>? version,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<int?>? deletedAtMs,
    Value<int>? rowid,
  }) {
    return DecksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      author: author ?? this.author,
      locale: locale ?? this.locale,
      version: version ?? this.version,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      deletedAtMs: deletedAtMs ?? this.deletedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (deletedAtMs.present) {
      map['deleted_at_ms'] = Variable<int>(deletedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DecksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('author: $author, ')
          ..write('locale: $locale, ')
          ..write('version: $version, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('deletedAtMs: $deletedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuizzesTable extends Quizzes with TableInfo<$QuizzesTable, QuizRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuizzesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deckIdMeta = const VerificationMeta('deckId');
  @override
  late final GeneratedColumn<String> deckId = GeneratedColumn<String>(
    'deck_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES decks (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionMeta = const VerificationMeta(
    'question',
  );
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
    'question',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _explanationMeta = const VerificationMeta(
    'explanation',
  );
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
    'explanation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _hintMeta = const VerificationMeta('hint');
  @override
  late final GeneratedColumn<String> hint = GeneratedColumn<String>(
    'hint',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMsMeta = const VerificationMeta(
    'deletedAtMs',
  );
  @override
  late final GeneratedColumn<int> deletedAtMs = GeneratedColumn<int>(
    'deleted_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    deckId,
    type,
    position,
    question,
    explanation,
    hint,
    createdAtMs,
    updatedAtMs,
    deletedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quizzes';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuizRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('deck_id')) {
      context.handle(
        _deckIdMeta,
        deckId.isAcceptableOrUnknown(data['deck_id']!, _deckIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deckIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('question')) {
      context.handle(
        _questionMeta,
        question.isAcceptableOrUnknown(data['question']!, _questionMeta),
      );
    } else if (isInserting) {
      context.missing(_questionMeta);
    }
    if (data.containsKey('explanation')) {
      context.handle(
        _explanationMeta,
        explanation.isAcceptableOrUnknown(
          data['explanation']!,
          _explanationMeta,
        ),
      );
    }
    if (data.containsKey('hint')) {
      context.handle(
        _hintMeta,
        hint.isAcceptableOrUnknown(data['hint']!, _hintMeta),
      );
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    if (data.containsKey('deleted_at_ms')) {
      context.handle(
        _deletedAtMsMeta,
        deletedAtMs.isAcceptableOrUnknown(
          data['deleted_at_ms']!,
          _deletedAtMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuizRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuizRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      deckId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deck_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      question: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question'],
      )!,
      explanation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explanation'],
      )!,
      hint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hint'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
      deletedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deleted_at_ms'],
      ),
    );
  }

  @override
  $QuizzesTable createAlias(String alias) {
    return $QuizzesTable(attachedDatabase, alias);
  }
}

class QuizRow extends DataClass implements Insertable<QuizRow> {
  final String id;
  final String deckId;

  /// `qyic.v1.QuizType` value.
  final int type;
  final int position;
  final String question;
  final String explanation;

  /// Secondary context shown with the question (schema v2).
  final String hint;
  final int createdAtMs;
  final int updatedAtMs;
  final int? deletedAtMs;
  const QuizRow({
    required this.id,
    required this.deckId,
    required this.type,
    required this.position,
    required this.question,
    required this.explanation,
    required this.hint,
    required this.createdAtMs,
    required this.updatedAtMs,
    this.deletedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['deck_id'] = Variable<String>(deckId);
    map['type'] = Variable<int>(type);
    map['position'] = Variable<int>(position);
    map['question'] = Variable<String>(question);
    map['explanation'] = Variable<String>(explanation);
    map['hint'] = Variable<String>(hint);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    if (!nullToAbsent || deletedAtMs != null) {
      map['deleted_at_ms'] = Variable<int>(deletedAtMs);
    }
    return map;
  }

  QuizzesCompanion toCompanion(bool nullToAbsent) {
    return QuizzesCompanion(
      id: Value(id),
      deckId: Value(deckId),
      type: Value(type),
      position: Value(position),
      question: Value(question),
      explanation: Value(explanation),
      hint: Value(hint),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
      deletedAtMs: deletedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAtMs),
    );
  }

  factory QuizRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuizRow(
      id: serializer.fromJson<String>(json['id']),
      deckId: serializer.fromJson<String>(json['deckId']),
      type: serializer.fromJson<int>(json['type']),
      position: serializer.fromJson<int>(json['position']),
      question: serializer.fromJson<String>(json['question']),
      explanation: serializer.fromJson<String>(json['explanation']),
      hint: serializer.fromJson<String>(json['hint']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
      deletedAtMs: serializer.fromJson<int?>(json['deletedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'deckId': serializer.toJson<String>(deckId),
      'type': serializer.toJson<int>(type),
      'position': serializer.toJson<int>(position),
      'question': serializer.toJson<String>(question),
      'explanation': serializer.toJson<String>(explanation),
      'hint': serializer.toJson<String>(hint),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
      'deletedAtMs': serializer.toJson<int?>(deletedAtMs),
    };
  }

  QuizRow copyWith({
    String? id,
    String? deckId,
    int? type,
    int? position,
    String? question,
    String? explanation,
    String? hint,
    int? createdAtMs,
    int? updatedAtMs,
    Value<int?> deletedAtMs = const Value.absent(),
  }) => QuizRow(
    id: id ?? this.id,
    deckId: deckId ?? this.deckId,
    type: type ?? this.type,
    position: position ?? this.position,
    question: question ?? this.question,
    explanation: explanation ?? this.explanation,
    hint: hint ?? this.hint,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    deletedAtMs: deletedAtMs.present ? deletedAtMs.value : this.deletedAtMs,
  );
  QuizRow copyWithCompanion(QuizzesCompanion data) {
    return QuizRow(
      id: data.id.present ? data.id.value : this.id,
      deckId: data.deckId.present ? data.deckId.value : this.deckId,
      type: data.type.present ? data.type.value : this.type,
      position: data.position.present ? data.position.value : this.position,
      question: data.question.present ? data.question.value : this.question,
      explanation: data.explanation.present
          ? data.explanation.value
          : this.explanation,
      hint: data.hint.present ? data.hint.value : this.hint,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
      deletedAtMs: data.deletedAtMs.present
          ? data.deletedAtMs.value
          : this.deletedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuizRow(')
          ..write('id: $id, ')
          ..write('deckId: $deckId, ')
          ..write('type: $type, ')
          ..write('position: $position, ')
          ..write('question: $question, ')
          ..write('explanation: $explanation, ')
          ..write('hint: $hint, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('deletedAtMs: $deletedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    deckId,
    type,
    position,
    question,
    explanation,
    hint,
    createdAtMs,
    updatedAtMs,
    deletedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuizRow &&
          other.id == this.id &&
          other.deckId == this.deckId &&
          other.type == this.type &&
          other.position == this.position &&
          other.question == this.question &&
          other.explanation == this.explanation &&
          other.hint == this.hint &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs &&
          other.deletedAtMs == this.deletedAtMs);
}

class QuizzesCompanion extends UpdateCompanion<QuizRow> {
  final Value<String> id;
  final Value<String> deckId;
  final Value<int> type;
  final Value<int> position;
  final Value<String> question;
  final Value<String> explanation;
  final Value<String> hint;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<int?> deletedAtMs;
  final Value<int> rowid;
  const QuizzesCompanion({
    this.id = const Value.absent(),
    this.deckId = const Value.absent(),
    this.type = const Value.absent(),
    this.position = const Value.absent(),
    this.question = const Value.absent(),
    this.explanation = const Value.absent(),
    this.hint = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.deletedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuizzesCompanion.insert({
    required String id,
    required String deckId,
    required int type,
    required int position,
    required String question,
    this.explanation = const Value.absent(),
    this.hint = const Value.absent(),
    required int createdAtMs,
    required int updatedAtMs,
    this.deletedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       deckId = Value(deckId),
       type = Value(type),
       position = Value(position),
       question = Value(question),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<QuizRow> custom({
    Expression<String>? id,
    Expression<String>? deckId,
    Expression<int>? type,
    Expression<int>? position,
    Expression<String>? question,
    Expression<String>? explanation,
    Expression<String>? hint,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<int>? deletedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deckId != null) 'deck_id': deckId,
      if (type != null) 'type': type,
      if (position != null) 'position': position,
      if (question != null) 'question': question,
      if (explanation != null) 'explanation': explanation,
      if (hint != null) 'hint': hint,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (deletedAtMs != null) 'deleted_at_ms': deletedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuizzesCompanion copyWith({
    Value<String>? id,
    Value<String>? deckId,
    Value<int>? type,
    Value<int>? position,
    Value<String>? question,
    Value<String>? explanation,
    Value<String>? hint,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<int?>? deletedAtMs,
    Value<int>? rowid,
  }) {
    return QuizzesCompanion(
      id: id ?? this.id,
      deckId: deckId ?? this.deckId,
      type: type ?? this.type,
      position: position ?? this.position,
      question: question ?? this.question,
      explanation: explanation ?? this.explanation,
      hint: hint ?? this.hint,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      deletedAtMs: deletedAtMs ?? this.deletedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (deckId.present) {
      map['deck_id'] = Variable<String>(deckId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (hint.present) {
      map['hint'] = Variable<String>(hint.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (deletedAtMs.present) {
      map['deleted_at_ms'] = Variable<int>(deletedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuizzesCompanion(')
          ..write('id: $id, ')
          ..write('deckId: $deckId, ')
          ..write('type: $type, ')
          ..write('position: $position, ')
          ..write('question: $question, ')
          ..write('explanation: $explanation, ')
          ..write('hint: $hint, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('deletedAtMs: $deletedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuizOptionsTable extends QuizOptions
    with TableInfo<$QuizOptionsTable, QuizOptionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuizOptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _quizIdMeta = const VerificationMeta('quizId');
  @override
  late final GeneratedColumn<String> quizId = GeneratedColumn<String>(
    'quiz_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES quizzes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _promptMeta = const VerificationMeta('prompt');
  @override
  late final GeneratedColumn<String> prompt = GeneratedColumn<String>(
    'prompt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _mediaPathMeta = const VerificationMeta(
    'mediaPath',
  );
  @override
  late final GeneratedColumn<String> mediaPath = GeneratedColumn<String>(
    'media_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isCorrectMeta = const VerificationMeta(
    'isCorrect',
  );
  @override
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
    'is_correct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_correct" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    quizId,
    id,
    position,
    body,
    prompt,
    mediaPath,
    isCorrect,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quiz_options';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuizOptionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('quiz_id')) {
      context.handle(
        _quizIdMeta,
        quizId.isAcceptableOrUnknown(data['quiz_id']!, _quizIdMeta),
      );
    } else if (isInserting) {
      context.missing(_quizIdMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('text')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['text']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('prompt')) {
      context.handle(
        _promptMeta,
        prompt.isAcceptableOrUnknown(data['prompt']!, _promptMeta),
      );
    }
    if (data.containsKey('media_path')) {
      context.handle(
        _mediaPathMeta,
        mediaPath.isAcceptableOrUnknown(data['media_path']!, _mediaPathMeta),
      );
    }
    if (data.containsKey('is_correct')) {
      context.handle(
        _isCorrectMeta,
        isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {quizId, id};
  @override
  QuizOptionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuizOptionRow(
      quizId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quiz_id'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text'],
      )!,
      prompt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt'],
      )!,
      mediaPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_path'],
      )!,
      isCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_correct'],
      )!,
    );
  }

  @override
  $QuizOptionsTable createAlias(String alias) {
    return $QuizOptionsTable(attachedDatabase, alias);
  }
}

class QuizOptionRow extends DataClass implements Insertable<QuizOptionRow> {
  final String quizId;
  final String id;
  final int position;
  final String body;
  final String prompt;
  final String mediaPath;
  final bool isCorrect;
  const QuizOptionRow({
    required this.quizId,
    required this.id,
    required this.position,
    required this.body,
    required this.prompt,
    required this.mediaPath,
    required this.isCorrect,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['quiz_id'] = Variable<String>(quizId);
    map['id'] = Variable<String>(id);
    map['position'] = Variable<int>(position);
    map['text'] = Variable<String>(body);
    map['prompt'] = Variable<String>(prompt);
    map['media_path'] = Variable<String>(mediaPath);
    map['is_correct'] = Variable<bool>(isCorrect);
    return map;
  }

  QuizOptionsCompanion toCompanion(bool nullToAbsent) {
    return QuizOptionsCompanion(
      quizId: Value(quizId),
      id: Value(id),
      position: Value(position),
      body: Value(body),
      prompt: Value(prompt),
      mediaPath: Value(mediaPath),
      isCorrect: Value(isCorrect),
    );
  }

  factory QuizOptionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuizOptionRow(
      quizId: serializer.fromJson<String>(json['quizId']),
      id: serializer.fromJson<String>(json['id']),
      position: serializer.fromJson<int>(json['position']),
      body: serializer.fromJson<String>(json['body']),
      prompt: serializer.fromJson<String>(json['prompt']),
      mediaPath: serializer.fromJson<String>(json['mediaPath']),
      isCorrect: serializer.fromJson<bool>(json['isCorrect']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'quizId': serializer.toJson<String>(quizId),
      'id': serializer.toJson<String>(id),
      'position': serializer.toJson<int>(position),
      'body': serializer.toJson<String>(body),
      'prompt': serializer.toJson<String>(prompt),
      'mediaPath': serializer.toJson<String>(mediaPath),
      'isCorrect': serializer.toJson<bool>(isCorrect),
    };
  }

  QuizOptionRow copyWith({
    String? quizId,
    String? id,
    int? position,
    String? body,
    String? prompt,
    String? mediaPath,
    bool? isCorrect,
  }) => QuizOptionRow(
    quizId: quizId ?? this.quizId,
    id: id ?? this.id,
    position: position ?? this.position,
    body: body ?? this.body,
    prompt: prompt ?? this.prompt,
    mediaPath: mediaPath ?? this.mediaPath,
    isCorrect: isCorrect ?? this.isCorrect,
  );
  QuizOptionRow copyWithCompanion(QuizOptionsCompanion data) {
    return QuizOptionRow(
      quizId: data.quizId.present ? data.quizId.value : this.quizId,
      id: data.id.present ? data.id.value : this.id,
      position: data.position.present ? data.position.value : this.position,
      body: data.body.present ? data.body.value : this.body,
      prompt: data.prompt.present ? data.prompt.value : this.prompt,
      mediaPath: data.mediaPath.present ? data.mediaPath.value : this.mediaPath,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuizOptionRow(')
          ..write('quizId: $quizId, ')
          ..write('id: $id, ')
          ..write('position: $position, ')
          ..write('body: $body, ')
          ..write('prompt: $prompt, ')
          ..write('mediaPath: $mediaPath, ')
          ..write('isCorrect: $isCorrect')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(quizId, id, position, body, prompt, mediaPath, isCorrect);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuizOptionRow &&
          other.quizId == this.quizId &&
          other.id == this.id &&
          other.position == this.position &&
          other.body == this.body &&
          other.prompt == this.prompt &&
          other.mediaPath == this.mediaPath &&
          other.isCorrect == this.isCorrect);
}

class QuizOptionsCompanion extends UpdateCompanion<QuizOptionRow> {
  final Value<String> quizId;
  final Value<String> id;
  final Value<int> position;
  final Value<String> body;
  final Value<String> prompt;
  final Value<String> mediaPath;
  final Value<bool> isCorrect;
  final Value<int> rowid;
  const QuizOptionsCompanion({
    this.quizId = const Value.absent(),
    this.id = const Value.absent(),
    this.position = const Value.absent(),
    this.body = const Value.absent(),
    this.prompt = const Value.absent(),
    this.mediaPath = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuizOptionsCompanion.insert({
    required String quizId,
    required String id,
    required int position,
    required String body,
    this.prompt = const Value.absent(),
    this.mediaPath = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : quizId = Value(quizId),
       id = Value(id),
       position = Value(position),
       body = Value(body);
  static Insertable<QuizOptionRow> custom({
    Expression<String>? quizId,
    Expression<String>? id,
    Expression<int>? position,
    Expression<String>? body,
    Expression<String>? prompt,
    Expression<String>? mediaPath,
    Expression<bool>? isCorrect,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (quizId != null) 'quiz_id': quizId,
      if (id != null) 'id': id,
      if (position != null) 'position': position,
      if (body != null) 'text': body,
      if (prompt != null) 'prompt': prompt,
      if (mediaPath != null) 'media_path': mediaPath,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuizOptionsCompanion copyWith({
    Value<String>? quizId,
    Value<String>? id,
    Value<int>? position,
    Value<String>? body,
    Value<String>? prompt,
    Value<String>? mediaPath,
    Value<bool>? isCorrect,
    Value<int>? rowid,
  }) {
    return QuizOptionsCompanion(
      quizId: quizId ?? this.quizId,
      id: id ?? this.id,
      position: position ?? this.position,
      body: body ?? this.body,
      prompt: prompt ?? this.prompt,
      mediaPath: mediaPath ?? this.mediaPath,
      isCorrect: isCorrect ?? this.isCorrect,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (quizId.present) {
      map['quiz_id'] = Variable<String>(quizId.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (body.present) {
      map['text'] = Variable<String>(body.value);
    }
    if (prompt.present) {
      map['prompt'] = Variable<String>(prompt.value);
    }
    if (mediaPath.present) {
      map['media_path'] = Variable<String>(mediaPath.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuizOptionsCompanion(')
          ..write('quizId: $quizId, ')
          ..write('id: $id, ')
          ..write('position: $position, ')
          ..write('body: $body, ')
          ..write('prompt: $prompt, ')
          ..write('mediaPath: $mediaPath, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CardStatesTable extends CardStates
    with TableInfo<$CardStatesTable, CardStateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _quizIdMeta = const VerificationMeta('quizId');
  @override
  late final GeneratedColumn<String> quizId = GeneratedColumn<String>(
    'quiz_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES quizzes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _deckIdMeta = const VerificationMeta('deckId');
  @override
  late final GeneratedColumn<String> deckId = GeneratedColumn<String>(
    'deck_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES decks (id)',
    ),
  );
  static const VerificationMeta _phaseMeta = const VerificationMeta('phase');
  @override
  late final GeneratedColumn<int> phase = GeneratedColumn<int>(
    'phase',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepMeta = const VerificationMeta('step');
  @override
  late final GeneratedColumn<int> step = GeneratedColumn<int>(
    'step',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stabilityMeta = const VerificationMeta(
    'stability',
  );
  @override
  late final GeneratedColumn<double> stability = GeneratedColumn<double>(
    'stability',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<double> difficulty = GeneratedColumn<double>(
    'difficulty',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueAtMsMeta = const VerificationMeta(
    'dueAtMs',
  );
  @override
  late final GeneratedColumn<int> dueAtMs = GeneratedColumn<int>(
    'due_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastReviewedAtMsMeta = const VerificationMeta(
    'lastReviewedAtMs',
  );
  @override
  late final GeneratedColumn<int> lastReviewedAtMs = GeneratedColumn<int>(
    'last_reviewed_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lapsesMeta = const VerificationMeta('lapses');
  @override
  late final GeneratedColumn<int> lapses = GeneratedColumn<int>(
    'lapses',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    quizId,
    deckId,
    phase,
    step,
    stability,
    difficulty,
    dueAtMs,
    lastReviewedAtMs,
    reps,
    lapses,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<CardStateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('quiz_id')) {
      context.handle(
        _quizIdMeta,
        quizId.isAcceptableOrUnknown(data['quiz_id']!, _quizIdMeta),
      );
    } else if (isInserting) {
      context.missing(_quizIdMeta);
    }
    if (data.containsKey('deck_id')) {
      context.handle(
        _deckIdMeta,
        deckId.isAcceptableOrUnknown(data['deck_id']!, _deckIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deckIdMeta);
    }
    if (data.containsKey('phase')) {
      context.handle(
        _phaseMeta,
        phase.isAcceptableOrUnknown(data['phase']!, _phaseMeta),
      );
    } else if (isInserting) {
      context.missing(_phaseMeta);
    }
    if (data.containsKey('step')) {
      context.handle(
        _stepMeta,
        step.isAcceptableOrUnknown(data['step']!, _stepMeta),
      );
    }
    if (data.containsKey('stability')) {
      context.handle(
        _stabilityMeta,
        stability.isAcceptableOrUnknown(data['stability']!, _stabilityMeta),
      );
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('due_at_ms')) {
      context.handle(
        _dueAtMsMeta,
        dueAtMs.isAcceptableOrUnknown(data['due_at_ms']!, _dueAtMsMeta),
      );
    } else if (isInserting) {
      context.missing(_dueAtMsMeta);
    }
    if (data.containsKey('last_reviewed_at_ms')) {
      context.handle(
        _lastReviewedAtMsMeta,
        lastReviewedAtMs.isAcceptableOrUnknown(
          data['last_reviewed_at_ms']!,
          _lastReviewedAtMsMeta,
        ),
      );
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    }
    if (data.containsKey('lapses')) {
      context.handle(
        _lapsesMeta,
        lapses.isAcceptableOrUnknown(data['lapses']!, _lapsesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {quizId};
  @override
  CardStateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardStateRow(
      quizId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quiz_id'],
      )!,
      deckId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deck_id'],
      )!,
      phase: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}phase'],
      )!,
      step: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step'],
      ),
      stability: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}stability'],
      ),
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}difficulty'],
      ),
      dueAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_at_ms'],
      )!,
      lastReviewedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_reviewed_at_ms'],
      ),
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      lapses: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lapses'],
      )!,
    );
  }

  @override
  $CardStatesTable createAlias(String alias) {
    return $CardStatesTable(attachedDatabase, alias);
  }
}

class CardStateRow extends DataClass implements Insertable<CardStateRow> {
  final String quizId;
  final String deckId;

  /// `CardPhase` value.
  final int phase;
  final int? step;
  final double? stability;
  final double? difficulty;
  final int dueAtMs;
  final int? lastReviewedAtMs;
  final int reps;
  final int lapses;
  const CardStateRow({
    required this.quizId,
    required this.deckId,
    required this.phase,
    this.step,
    this.stability,
    this.difficulty,
    required this.dueAtMs,
    this.lastReviewedAtMs,
    required this.reps,
    required this.lapses,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['quiz_id'] = Variable<String>(quizId);
    map['deck_id'] = Variable<String>(deckId);
    map['phase'] = Variable<int>(phase);
    if (!nullToAbsent || step != null) {
      map['step'] = Variable<int>(step);
    }
    if (!nullToAbsent || stability != null) {
      map['stability'] = Variable<double>(stability);
    }
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<double>(difficulty);
    }
    map['due_at_ms'] = Variable<int>(dueAtMs);
    if (!nullToAbsent || lastReviewedAtMs != null) {
      map['last_reviewed_at_ms'] = Variable<int>(lastReviewedAtMs);
    }
    map['reps'] = Variable<int>(reps);
    map['lapses'] = Variable<int>(lapses);
    return map;
  }

  CardStatesCompanion toCompanion(bool nullToAbsent) {
    return CardStatesCompanion(
      quizId: Value(quizId),
      deckId: Value(deckId),
      phase: Value(phase),
      step: step == null && nullToAbsent ? const Value.absent() : Value(step),
      stability: stability == null && nullToAbsent
          ? const Value.absent()
          : Value(stability),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
      dueAtMs: Value(dueAtMs),
      lastReviewedAtMs: lastReviewedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewedAtMs),
      reps: Value(reps),
      lapses: Value(lapses),
    );
  }

  factory CardStateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardStateRow(
      quizId: serializer.fromJson<String>(json['quizId']),
      deckId: serializer.fromJson<String>(json['deckId']),
      phase: serializer.fromJson<int>(json['phase']),
      step: serializer.fromJson<int?>(json['step']),
      stability: serializer.fromJson<double?>(json['stability']),
      difficulty: serializer.fromJson<double?>(json['difficulty']),
      dueAtMs: serializer.fromJson<int>(json['dueAtMs']),
      lastReviewedAtMs: serializer.fromJson<int?>(json['lastReviewedAtMs']),
      reps: serializer.fromJson<int>(json['reps']),
      lapses: serializer.fromJson<int>(json['lapses']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'quizId': serializer.toJson<String>(quizId),
      'deckId': serializer.toJson<String>(deckId),
      'phase': serializer.toJson<int>(phase),
      'step': serializer.toJson<int?>(step),
      'stability': serializer.toJson<double?>(stability),
      'difficulty': serializer.toJson<double?>(difficulty),
      'dueAtMs': serializer.toJson<int>(dueAtMs),
      'lastReviewedAtMs': serializer.toJson<int?>(lastReviewedAtMs),
      'reps': serializer.toJson<int>(reps),
      'lapses': serializer.toJson<int>(lapses),
    };
  }

  CardStateRow copyWith({
    String? quizId,
    String? deckId,
    int? phase,
    Value<int?> step = const Value.absent(),
    Value<double?> stability = const Value.absent(),
    Value<double?> difficulty = const Value.absent(),
    int? dueAtMs,
    Value<int?> lastReviewedAtMs = const Value.absent(),
    int? reps,
    int? lapses,
  }) => CardStateRow(
    quizId: quizId ?? this.quizId,
    deckId: deckId ?? this.deckId,
    phase: phase ?? this.phase,
    step: step.present ? step.value : this.step,
    stability: stability.present ? stability.value : this.stability,
    difficulty: difficulty.present ? difficulty.value : this.difficulty,
    dueAtMs: dueAtMs ?? this.dueAtMs,
    lastReviewedAtMs: lastReviewedAtMs.present
        ? lastReviewedAtMs.value
        : this.lastReviewedAtMs,
    reps: reps ?? this.reps,
    lapses: lapses ?? this.lapses,
  );
  CardStateRow copyWithCompanion(CardStatesCompanion data) {
    return CardStateRow(
      quizId: data.quizId.present ? data.quizId.value : this.quizId,
      deckId: data.deckId.present ? data.deckId.value : this.deckId,
      phase: data.phase.present ? data.phase.value : this.phase,
      step: data.step.present ? data.step.value : this.step,
      stability: data.stability.present ? data.stability.value : this.stability,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      dueAtMs: data.dueAtMs.present ? data.dueAtMs.value : this.dueAtMs,
      lastReviewedAtMs: data.lastReviewedAtMs.present
          ? data.lastReviewedAtMs.value
          : this.lastReviewedAtMs,
      reps: data.reps.present ? data.reps.value : this.reps,
      lapses: data.lapses.present ? data.lapses.value : this.lapses,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardStateRow(')
          ..write('quizId: $quizId, ')
          ..write('deckId: $deckId, ')
          ..write('phase: $phase, ')
          ..write('step: $step, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty, ')
          ..write('dueAtMs: $dueAtMs, ')
          ..write('lastReviewedAtMs: $lastReviewedAtMs, ')
          ..write('reps: $reps, ')
          ..write('lapses: $lapses')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    quizId,
    deckId,
    phase,
    step,
    stability,
    difficulty,
    dueAtMs,
    lastReviewedAtMs,
    reps,
    lapses,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardStateRow &&
          other.quizId == this.quizId &&
          other.deckId == this.deckId &&
          other.phase == this.phase &&
          other.step == this.step &&
          other.stability == this.stability &&
          other.difficulty == this.difficulty &&
          other.dueAtMs == this.dueAtMs &&
          other.lastReviewedAtMs == this.lastReviewedAtMs &&
          other.reps == this.reps &&
          other.lapses == this.lapses);
}

class CardStatesCompanion extends UpdateCompanion<CardStateRow> {
  final Value<String> quizId;
  final Value<String> deckId;
  final Value<int> phase;
  final Value<int?> step;
  final Value<double?> stability;
  final Value<double?> difficulty;
  final Value<int> dueAtMs;
  final Value<int?> lastReviewedAtMs;
  final Value<int> reps;
  final Value<int> lapses;
  final Value<int> rowid;
  const CardStatesCompanion({
    this.quizId = const Value.absent(),
    this.deckId = const Value.absent(),
    this.phase = const Value.absent(),
    this.step = const Value.absent(),
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.dueAtMs = const Value.absent(),
    this.lastReviewedAtMs = const Value.absent(),
    this.reps = const Value.absent(),
    this.lapses = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CardStatesCompanion.insert({
    required String quizId,
    required String deckId,
    required int phase,
    this.step = const Value.absent(),
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
    required int dueAtMs,
    this.lastReviewedAtMs = const Value.absent(),
    this.reps = const Value.absent(),
    this.lapses = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : quizId = Value(quizId),
       deckId = Value(deckId),
       phase = Value(phase),
       dueAtMs = Value(dueAtMs);
  static Insertable<CardStateRow> custom({
    Expression<String>? quizId,
    Expression<String>? deckId,
    Expression<int>? phase,
    Expression<int>? step,
    Expression<double>? stability,
    Expression<double>? difficulty,
    Expression<int>? dueAtMs,
    Expression<int>? lastReviewedAtMs,
    Expression<int>? reps,
    Expression<int>? lapses,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (quizId != null) 'quiz_id': quizId,
      if (deckId != null) 'deck_id': deckId,
      if (phase != null) 'phase': phase,
      if (step != null) 'step': step,
      if (stability != null) 'stability': stability,
      if (difficulty != null) 'difficulty': difficulty,
      if (dueAtMs != null) 'due_at_ms': dueAtMs,
      if (lastReviewedAtMs != null) 'last_reviewed_at_ms': lastReviewedAtMs,
      if (reps != null) 'reps': reps,
      if (lapses != null) 'lapses': lapses,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CardStatesCompanion copyWith({
    Value<String>? quizId,
    Value<String>? deckId,
    Value<int>? phase,
    Value<int?>? step,
    Value<double?>? stability,
    Value<double?>? difficulty,
    Value<int>? dueAtMs,
    Value<int?>? lastReviewedAtMs,
    Value<int>? reps,
    Value<int>? lapses,
    Value<int>? rowid,
  }) {
    return CardStatesCompanion(
      quizId: quizId ?? this.quizId,
      deckId: deckId ?? this.deckId,
      phase: phase ?? this.phase,
      step: step ?? this.step,
      stability: stability ?? this.stability,
      difficulty: difficulty ?? this.difficulty,
      dueAtMs: dueAtMs ?? this.dueAtMs,
      lastReviewedAtMs: lastReviewedAtMs ?? this.lastReviewedAtMs,
      reps: reps ?? this.reps,
      lapses: lapses ?? this.lapses,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (quizId.present) {
      map['quiz_id'] = Variable<String>(quizId.value);
    }
    if (deckId.present) {
      map['deck_id'] = Variable<String>(deckId.value);
    }
    if (phase.present) {
      map['phase'] = Variable<int>(phase.value);
    }
    if (step.present) {
      map['step'] = Variable<int>(step.value);
    }
    if (stability.present) {
      map['stability'] = Variable<double>(stability.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<double>(difficulty.value);
    }
    if (dueAtMs.present) {
      map['due_at_ms'] = Variable<int>(dueAtMs.value);
    }
    if (lastReviewedAtMs.present) {
      map['last_reviewed_at_ms'] = Variable<int>(lastReviewedAtMs.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (lapses.present) {
      map['lapses'] = Variable<int>(lapses.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardStatesCompanion(')
          ..write('quizId: $quizId, ')
          ..write('deckId: $deckId, ')
          ..write('phase: $phase, ')
          ..write('step: $step, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty, ')
          ..write('dueAtMs: $dueAtMs, ')
          ..write('lastReviewedAtMs: $lastReviewedAtMs, ')
          ..write('reps: $reps, ')
          ..write('lapses: $lapses, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReviewEventsTable extends ReviewEvents
    with TableInfo<$ReviewEventsTable, ReviewEventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientSeqMeta = const VerificationMeta(
    'clientSeq',
  );
  @override
  late final GeneratedColumn<int> clientSeq = GeneratedColumn<int>(
    'client_seq',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quizIdMeta = const VerificationMeta('quizId');
  @override
  late final GeneratedColumn<String> quizId = GeneratedColumn<String>(
    'quiz_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deckIdMeta = const VerificationMeta('deckId');
  @override
  late final GeneratedColumn<String> deckId = GeneratedColumn<String>(
    'deck_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reviewedAtMsMeta = const VerificationMeta(
    'reviewedAtMs',
  );
  @override
  late final GeneratedColumn<int> reviewedAtMs = GeneratedColumn<int>(
    'reviewed_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<int> mode = GeneratedColumn<int>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clientId,
    clientSeq,
    quizId,
    deckId,
    rating,
    reviewedAtMs,
    durationMs,
    mode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReviewEventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('client_seq')) {
      context.handle(
        _clientSeqMeta,
        clientSeq.isAcceptableOrUnknown(data['client_seq']!, _clientSeqMeta),
      );
    } else if (isInserting) {
      context.missing(_clientSeqMeta);
    }
    if (data.containsKey('quiz_id')) {
      context.handle(
        _quizIdMeta,
        quizId.isAcceptableOrUnknown(data['quiz_id']!, _quizIdMeta),
      );
    } else if (isInserting) {
      context.missing(_quizIdMeta);
    }
    if (data.containsKey('deck_id')) {
      context.handle(
        _deckIdMeta,
        deckId.isAcceptableOrUnknown(data['deck_id']!, _deckIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deckIdMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('reviewed_at_ms')) {
      context.handle(
        _reviewedAtMsMeta,
        reviewedAtMs.isAcceptableOrUnknown(
          data['reviewed_at_ms']!,
          _reviewedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reviewedAtMsMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMsMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {clientId, clientSeq},
  ];
  @override
  ReviewEventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewEventRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      clientSeq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_seq'],
      )!,
      quizId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quiz_id'],
      )!,
      deckId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deck_id'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
      reviewedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reviewed_at_ms'],
      )!,
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mode'],
      )!,
    );
  }

  @override
  $ReviewEventsTable createAlias(String alias) {
    return $ReviewEventsTable(attachedDatabase, alias);
  }
}

class ReviewEventRow extends DataClass implements Insertable<ReviewEventRow> {
  final int id;
  final String clientId;
  final int clientSeq;
  final String quizId;
  final String deckId;

  /// `qyic.v1.ReviewRating` value.
  final int rating;
  final int reviewedAtMs;
  final int durationMs;

  /// `qyic.v1.ReviewMode` value (schema v2).
  final int mode;
  const ReviewEventRow({
    required this.id,
    required this.clientId,
    required this.clientSeq,
    required this.quizId,
    required this.deckId,
    required this.rating,
    required this.reviewedAtMs,
    required this.durationMs,
    required this.mode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<String>(clientId);
    map['client_seq'] = Variable<int>(clientSeq);
    map['quiz_id'] = Variable<String>(quizId);
    map['deck_id'] = Variable<String>(deckId);
    map['rating'] = Variable<int>(rating);
    map['reviewed_at_ms'] = Variable<int>(reviewedAtMs);
    map['duration_ms'] = Variable<int>(durationMs);
    map['mode'] = Variable<int>(mode);
    return map;
  }

  ReviewEventsCompanion toCompanion(bool nullToAbsent) {
    return ReviewEventsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      clientSeq: Value(clientSeq),
      quizId: Value(quizId),
      deckId: Value(deckId),
      rating: Value(rating),
      reviewedAtMs: Value(reviewedAtMs),
      durationMs: Value(durationMs),
      mode: Value(mode),
    );
  }

  factory ReviewEventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewEventRow(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<String>(json['clientId']),
      clientSeq: serializer.fromJson<int>(json['clientSeq']),
      quizId: serializer.fromJson<String>(json['quizId']),
      deckId: serializer.fromJson<String>(json['deckId']),
      rating: serializer.fromJson<int>(json['rating']),
      reviewedAtMs: serializer.fromJson<int>(json['reviewedAtMs']),
      durationMs: serializer.fromJson<int>(json['durationMs']),
      mode: serializer.fromJson<int>(json['mode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<String>(clientId),
      'clientSeq': serializer.toJson<int>(clientSeq),
      'quizId': serializer.toJson<String>(quizId),
      'deckId': serializer.toJson<String>(deckId),
      'rating': serializer.toJson<int>(rating),
      'reviewedAtMs': serializer.toJson<int>(reviewedAtMs),
      'durationMs': serializer.toJson<int>(durationMs),
      'mode': serializer.toJson<int>(mode),
    };
  }

  ReviewEventRow copyWith({
    int? id,
    String? clientId,
    int? clientSeq,
    String? quizId,
    String? deckId,
    int? rating,
    int? reviewedAtMs,
    int? durationMs,
    int? mode,
  }) => ReviewEventRow(
    id: id ?? this.id,
    clientId: clientId ?? this.clientId,
    clientSeq: clientSeq ?? this.clientSeq,
    quizId: quizId ?? this.quizId,
    deckId: deckId ?? this.deckId,
    rating: rating ?? this.rating,
    reviewedAtMs: reviewedAtMs ?? this.reviewedAtMs,
    durationMs: durationMs ?? this.durationMs,
    mode: mode ?? this.mode,
  );
  ReviewEventRow copyWithCompanion(ReviewEventsCompanion data) {
    return ReviewEventRow(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      clientSeq: data.clientSeq.present ? data.clientSeq.value : this.clientSeq,
      quizId: data.quizId.present ? data.quizId.value : this.quizId,
      deckId: data.deckId.present ? data.deckId.value : this.deckId,
      rating: data.rating.present ? data.rating.value : this.rating,
      reviewedAtMs: data.reviewedAtMs.present
          ? data.reviewedAtMs.value
          : this.reviewedAtMs,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      mode: data.mode.present ? data.mode.value : this.mode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewEventRow(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('clientSeq: $clientSeq, ')
          ..write('quizId: $quizId, ')
          ..write('deckId: $deckId, ')
          ..write('rating: $rating, ')
          ..write('reviewedAtMs: $reviewedAtMs, ')
          ..write('durationMs: $durationMs, ')
          ..write('mode: $mode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    clientId,
    clientSeq,
    quizId,
    deckId,
    rating,
    reviewedAtMs,
    durationMs,
    mode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewEventRow &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.clientSeq == this.clientSeq &&
          other.quizId == this.quizId &&
          other.deckId == this.deckId &&
          other.rating == this.rating &&
          other.reviewedAtMs == this.reviewedAtMs &&
          other.durationMs == this.durationMs &&
          other.mode == this.mode);
}

class ReviewEventsCompanion extends UpdateCompanion<ReviewEventRow> {
  final Value<int> id;
  final Value<String> clientId;
  final Value<int> clientSeq;
  final Value<String> quizId;
  final Value<String> deckId;
  final Value<int> rating;
  final Value<int> reviewedAtMs;
  final Value<int> durationMs;
  final Value<int> mode;
  const ReviewEventsCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.clientSeq = const Value.absent(),
    this.quizId = const Value.absent(),
    this.deckId = const Value.absent(),
    this.rating = const Value.absent(),
    this.reviewedAtMs = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.mode = const Value.absent(),
  });
  ReviewEventsCompanion.insert({
    this.id = const Value.absent(),
    required String clientId,
    required int clientSeq,
    required String quizId,
    required String deckId,
    required int rating,
    required int reviewedAtMs,
    required int durationMs,
    this.mode = const Value.absent(),
  }) : clientId = Value(clientId),
       clientSeq = Value(clientSeq),
       quizId = Value(quizId),
       deckId = Value(deckId),
       rating = Value(rating),
       reviewedAtMs = Value(reviewedAtMs),
       durationMs = Value(durationMs);
  static Insertable<ReviewEventRow> custom({
    Expression<int>? id,
    Expression<String>? clientId,
    Expression<int>? clientSeq,
    Expression<String>? quizId,
    Expression<String>? deckId,
    Expression<int>? rating,
    Expression<int>? reviewedAtMs,
    Expression<int>? durationMs,
    Expression<int>? mode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (clientSeq != null) 'client_seq': clientSeq,
      if (quizId != null) 'quiz_id': quizId,
      if (deckId != null) 'deck_id': deckId,
      if (rating != null) 'rating': rating,
      if (reviewedAtMs != null) 'reviewed_at_ms': reviewedAtMs,
      if (durationMs != null) 'duration_ms': durationMs,
      if (mode != null) 'mode': mode,
    });
  }

  ReviewEventsCompanion copyWith({
    Value<int>? id,
    Value<String>? clientId,
    Value<int>? clientSeq,
    Value<String>? quizId,
    Value<String>? deckId,
    Value<int>? rating,
    Value<int>? reviewedAtMs,
    Value<int>? durationMs,
    Value<int>? mode,
  }) {
    return ReviewEventsCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      clientSeq: clientSeq ?? this.clientSeq,
      quizId: quizId ?? this.quizId,
      deckId: deckId ?? this.deckId,
      rating: rating ?? this.rating,
      reviewedAtMs: reviewedAtMs ?? this.reviewedAtMs,
      durationMs: durationMs ?? this.durationMs,
      mode: mode ?? this.mode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (clientSeq.present) {
      map['client_seq'] = Variable<int>(clientSeq.value);
    }
    if (quizId.present) {
      map['quiz_id'] = Variable<String>(quizId.value);
    }
    if (deckId.present) {
      map['deck_id'] = Variable<String>(deckId.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (reviewedAtMs.present) {
      map['reviewed_at_ms'] = Variable<int>(reviewedAtMs.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (mode.present) {
      map['mode'] = Variable<int>(mode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewEventsCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('clientSeq: $clientSeq, ')
          ..write('quizId: $quizId, ')
          ..write('deckId: $deckId, ')
          ..write('rating: $rating, ')
          ..write('reviewedAtMs: $reviewedAtMs, ')
          ..write('durationMs: $durationMs, ')
          ..write('mode: $mode')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings
    with TableInfo<$SettingsTable, SettingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class SettingRow extends DataClass implements Insertable<SettingRow> {
  final String key;
  final String value;
  const SettingRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(key: Value(key), value: Value(value));
  }

  factory SettingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SettingRow copyWith({String? key, String? value}) =>
      SettingRow(key: key ?? this.key, value: value ?? this.value);
  SettingRow copyWithCompanion(SettingsCompanion data) {
    return SettingRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingRow &&
          other.key == this.key &&
          other.value == this.value);
}

class SettingsCompanion extends UpdateCompanion<SettingRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<SettingRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, ReminderRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _minuteOfDayMeta = const VerificationMeta(
    'minuteOfDay',
  );
  @override
  late final GeneratedColumn<int> minuteOfDay = GeneratedColumn<int>(
    'minute_of_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekdaysMeta = const VerificationMeta(
    'weekdays',
  );
  @override
  late final GeneratedColumn<int> weekdays = GeneratedColumn<int>(
    'weekdays',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, minuteOfDay, weekdays, enabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('minute_of_day')) {
      context.handle(
        _minuteOfDayMeta,
        minuteOfDay.isAcceptableOrUnknown(
          data['minute_of_day']!,
          _minuteOfDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_minuteOfDayMeta);
    }
    if (data.containsKey('weekdays')) {
      context.handle(
        _weekdaysMeta,
        weekdays.isAcceptableOrUnknown(data['weekdays']!, _weekdaysMeta),
      );
    } else if (isInserting) {
      context.missing(_weekdaysMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      minuteOfDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minute_of_day'],
      )!,
      weekdays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekdays'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class ReminderRow extends DataClass implements Insertable<ReminderRow> {
  final int id;

  /// Local wall-clock time, minutes after midnight.
  final int minuteOfDay;

  /// Bit `n` set = weekday `n + 1` (`DateTime.monday` … `DateTime.sunday`).
  final int weekdays;
  final bool enabled;
  const ReminderRow({
    required this.id,
    required this.minuteOfDay,
    required this.weekdays,
    required this.enabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['minute_of_day'] = Variable<int>(minuteOfDay);
    map['weekdays'] = Variable<int>(weekdays);
    map['enabled'] = Variable<bool>(enabled);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      minuteOfDay: Value(minuteOfDay),
      weekdays: Value(weekdays),
      enabled: Value(enabled),
    );
  }

  factory ReminderRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderRow(
      id: serializer.fromJson<int>(json['id']),
      minuteOfDay: serializer.fromJson<int>(json['minuteOfDay']),
      weekdays: serializer.fromJson<int>(json['weekdays']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'minuteOfDay': serializer.toJson<int>(minuteOfDay),
      'weekdays': serializer.toJson<int>(weekdays),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  ReminderRow copyWith({
    int? id,
    int? minuteOfDay,
    int? weekdays,
    bool? enabled,
  }) => ReminderRow(
    id: id ?? this.id,
    minuteOfDay: minuteOfDay ?? this.minuteOfDay,
    weekdays: weekdays ?? this.weekdays,
    enabled: enabled ?? this.enabled,
  );
  ReminderRow copyWithCompanion(RemindersCompanion data) {
    return ReminderRow(
      id: data.id.present ? data.id.value : this.id,
      minuteOfDay: data.minuteOfDay.present
          ? data.minuteOfDay.value
          : this.minuteOfDay,
      weekdays: data.weekdays.present ? data.weekdays.value : this.weekdays,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderRow(')
          ..write('id: $id, ')
          ..write('minuteOfDay: $minuteOfDay, ')
          ..write('weekdays: $weekdays, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, minuteOfDay, weekdays, enabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderRow &&
          other.id == this.id &&
          other.minuteOfDay == this.minuteOfDay &&
          other.weekdays == this.weekdays &&
          other.enabled == this.enabled);
}

class RemindersCompanion extends UpdateCompanion<ReminderRow> {
  final Value<int> id;
  final Value<int> minuteOfDay;
  final Value<int> weekdays;
  final Value<bool> enabled;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.minuteOfDay = const Value.absent(),
    this.weekdays = const Value.absent(),
    this.enabled = const Value.absent(),
  });
  RemindersCompanion.insert({
    this.id = const Value.absent(),
    required int minuteOfDay,
    required int weekdays,
    this.enabled = const Value.absent(),
  }) : minuteOfDay = Value(minuteOfDay),
       weekdays = Value(weekdays);
  static Insertable<ReminderRow> custom({
    Expression<int>? id,
    Expression<int>? minuteOfDay,
    Expression<int>? weekdays,
    Expression<bool>? enabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (minuteOfDay != null) 'minute_of_day': minuteOfDay,
      if (weekdays != null) 'weekdays': weekdays,
      if (enabled != null) 'enabled': enabled,
    });
  }

  RemindersCompanion copyWith({
    Value<int>? id,
    Value<int>? minuteOfDay,
    Value<int>? weekdays,
    Value<bool>? enabled,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      minuteOfDay: minuteOfDay ?? this.minuteOfDay,
      weekdays: weekdays ?? this.weekdays,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (minuteOfDay.present) {
      map['minute_of_day'] = Variable<int>(minuteOfDay.value);
    }
    if (weekdays.present) {
      map['weekdays'] = Variable<int>(weekdays.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('minuteOfDay: $minuteOfDay, ')
          ..write('weekdays: $weekdays, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }
}

class $ExamPresetsTable extends ExamPresets
    with TableInfo<$ExamPresetsTable, ExamPresetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamPresetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _selectionMeta = const VerificationMeta(
    'selection',
  );
  @override
  late final GeneratedColumn<int> selection = GeneratedColumn<int>(
    'selection',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionCountMeta = const VerificationMeta(
    'questionCount',
  );
  @override
  late final GeneratedColumn<int> questionCount = GeneratedColumn<int>(
    'question_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeLimitSecondsMeta = const VerificationMeta(
    'timeLimitSeconds',
  );
  @override
  late final GeneratedColumn<int> timeLimitSeconds = GeneratedColumn<int>(
    'time_limit_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _secondsPerQuestionMeta =
      const VerificationMeta('secondsPerQuestion');
  @override
  late final GeneratedColumn<int> secondsPerQuestion = GeneratedColumn<int>(
    'seconds_per_question',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quizTypesMeta = const VerificationMeta(
    'quizTypes',
  );
  @override
  late final GeneratedColumn<int> quizTypes = GeneratedColumn<int>(
    'quiz_types',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _includeNewMeta = const VerificationMeta(
    'includeNew',
  );
  @override
  late final GeneratedColumn<bool> includeNew = GeneratedColumn<bool>(
    'include_new',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("include_new" IN (0, 1))',
    ),
  );
  static const VerificationMeta _autoRateMeta = const VerificationMeta(
    'autoRate',
  );
  @override
  late final GeneratedColumn<bool> autoRate = GeneratedColumn<bool>(
    'auto_rate',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_rate" IN (0, 1))',
    ),
  );
  static const VerificationMeta _allowHintsMeta = const VerificationMeta(
    'allowHints',
  );
  @override
  late final GeneratedColumn<bool> allowHints = GeneratedColumn<bool>(
    'allow_hints',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("allow_hints" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    selection,
    questionCount,
    timeLimitSeconds,
    secondsPerQuestion,
    quizTypes,
    includeNew,
    autoRate,
    allowHints,
    createdAtMs,
    updatedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exam_presets';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExamPresetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('selection')) {
      context.handle(
        _selectionMeta,
        selection.isAcceptableOrUnknown(data['selection']!, _selectionMeta),
      );
    } else if (isInserting) {
      context.missing(_selectionMeta);
    }
    if (data.containsKey('question_count')) {
      context.handle(
        _questionCountMeta,
        questionCount.isAcceptableOrUnknown(
          data['question_count']!,
          _questionCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionCountMeta);
    }
    if (data.containsKey('time_limit_seconds')) {
      context.handle(
        _timeLimitSecondsMeta,
        timeLimitSeconds.isAcceptableOrUnknown(
          data['time_limit_seconds']!,
          _timeLimitSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timeLimitSecondsMeta);
    }
    if (data.containsKey('seconds_per_question')) {
      context.handle(
        _secondsPerQuestionMeta,
        secondsPerQuestion.isAcceptableOrUnknown(
          data['seconds_per_question']!,
          _secondsPerQuestionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_secondsPerQuestionMeta);
    }
    if (data.containsKey('quiz_types')) {
      context.handle(
        _quizTypesMeta,
        quizTypes.isAcceptableOrUnknown(data['quiz_types']!, _quizTypesMeta),
      );
    } else if (isInserting) {
      context.missing(_quizTypesMeta);
    }
    if (data.containsKey('include_new')) {
      context.handle(
        _includeNewMeta,
        includeNew.isAcceptableOrUnknown(data['include_new']!, _includeNewMeta),
      );
    } else if (isInserting) {
      context.missing(_includeNewMeta);
    }
    if (data.containsKey('auto_rate')) {
      context.handle(
        _autoRateMeta,
        autoRate.isAcceptableOrUnknown(data['auto_rate']!, _autoRateMeta),
      );
    } else if (isInserting) {
      context.missing(_autoRateMeta);
    }
    if (data.containsKey('allow_hints')) {
      context.handle(
        _allowHintsMeta,
        allowHints.isAcceptableOrUnknown(data['allow_hints']!, _allowHintsMeta),
      );
    } else if (isInserting) {
      context.missing(_allowHintsMeta);
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExamPresetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExamPresetRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      selection: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}selection'],
      )!,
      questionCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}question_count'],
      )!,
      timeLimitSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}time_limit_seconds'],
      )!,
      secondsPerQuestion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seconds_per_question'],
      )!,
      quizTypes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quiz_types'],
      )!,
      includeNew: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}include_new'],
      )!,
      autoRate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_rate'],
      )!,
      allowHints: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}allow_hints'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
    );
  }

  @override
  $ExamPresetsTable createAlias(String alias) {
    return $ExamPresetsTable(attachedDatabase, alias);
  }
}

class ExamPresetRow extends DataClass implements Insertable<ExamPresetRow> {
  final String id;
  final String name;

  /// `ExamSelection` value.
  final int selection;
  final int questionCount;

  /// Whole-exam limit; 0 = untimed.
  final int timeLimitSeconds;

  /// Per-question limit; 0 = untimed.
  final int secondsPerQuestion;

  /// Bit `1 << QuizType.value` per included quiz type.
  final int quizTypes;
  final bool includeNew;
  final bool autoRate;
  final bool allowHints;
  final int createdAtMs;
  final int updatedAtMs;
  const ExamPresetRow({
    required this.id,
    required this.name,
    required this.selection,
    required this.questionCount,
    required this.timeLimitSeconds,
    required this.secondsPerQuestion,
    required this.quizTypes,
    required this.includeNew,
    required this.autoRate,
    required this.allowHints,
    required this.createdAtMs,
    required this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['selection'] = Variable<int>(selection);
    map['question_count'] = Variable<int>(questionCount);
    map['time_limit_seconds'] = Variable<int>(timeLimitSeconds);
    map['seconds_per_question'] = Variable<int>(secondsPerQuestion);
    map['quiz_types'] = Variable<int>(quizTypes);
    map['include_new'] = Variable<bool>(includeNew);
    map['auto_rate'] = Variable<bool>(autoRate);
    map['allow_hints'] = Variable<bool>(allowHints);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  ExamPresetsCompanion toCompanion(bool nullToAbsent) {
    return ExamPresetsCompanion(
      id: Value(id),
      name: Value(name),
      selection: Value(selection),
      questionCount: Value(questionCount),
      timeLimitSeconds: Value(timeLimitSeconds),
      secondsPerQuestion: Value(secondsPerQuestion),
      quizTypes: Value(quizTypes),
      includeNew: Value(includeNew),
      autoRate: Value(autoRate),
      allowHints: Value(allowHints),
      createdAtMs: Value(createdAtMs),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory ExamPresetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExamPresetRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      selection: serializer.fromJson<int>(json['selection']),
      questionCount: serializer.fromJson<int>(json['questionCount']),
      timeLimitSeconds: serializer.fromJson<int>(json['timeLimitSeconds']),
      secondsPerQuestion: serializer.fromJson<int>(json['secondsPerQuestion']),
      quizTypes: serializer.fromJson<int>(json['quizTypes']),
      includeNew: serializer.fromJson<bool>(json['includeNew']),
      autoRate: serializer.fromJson<bool>(json['autoRate']),
      allowHints: serializer.fromJson<bool>(json['allowHints']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'selection': serializer.toJson<int>(selection),
      'questionCount': serializer.toJson<int>(questionCount),
      'timeLimitSeconds': serializer.toJson<int>(timeLimitSeconds),
      'secondsPerQuestion': serializer.toJson<int>(secondsPerQuestion),
      'quizTypes': serializer.toJson<int>(quizTypes),
      'includeNew': serializer.toJson<bool>(includeNew),
      'autoRate': serializer.toJson<bool>(autoRate),
      'allowHints': serializer.toJson<bool>(allowHints),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  ExamPresetRow copyWith({
    String? id,
    String? name,
    int? selection,
    int? questionCount,
    int? timeLimitSeconds,
    int? secondsPerQuestion,
    int? quizTypes,
    bool? includeNew,
    bool? autoRate,
    bool? allowHints,
    int? createdAtMs,
    int? updatedAtMs,
  }) => ExamPresetRow(
    id: id ?? this.id,
    name: name ?? this.name,
    selection: selection ?? this.selection,
    questionCount: questionCount ?? this.questionCount,
    timeLimitSeconds: timeLimitSeconds ?? this.timeLimitSeconds,
    secondsPerQuestion: secondsPerQuestion ?? this.secondsPerQuestion,
    quizTypes: quizTypes ?? this.quizTypes,
    includeNew: includeNew ?? this.includeNew,
    autoRate: autoRate ?? this.autoRate,
    allowHints: allowHints ?? this.allowHints,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
  );
  ExamPresetRow copyWithCompanion(ExamPresetsCompanion data) {
    return ExamPresetRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      selection: data.selection.present ? data.selection.value : this.selection,
      questionCount: data.questionCount.present
          ? data.questionCount.value
          : this.questionCount,
      timeLimitSeconds: data.timeLimitSeconds.present
          ? data.timeLimitSeconds.value
          : this.timeLimitSeconds,
      secondsPerQuestion: data.secondsPerQuestion.present
          ? data.secondsPerQuestion.value
          : this.secondsPerQuestion,
      quizTypes: data.quizTypes.present ? data.quizTypes.value : this.quizTypes,
      includeNew: data.includeNew.present
          ? data.includeNew.value
          : this.includeNew,
      autoRate: data.autoRate.present ? data.autoRate.value : this.autoRate,
      allowHints: data.allowHints.present
          ? data.allowHints.value
          : this.allowHints,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExamPresetRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('selection: $selection, ')
          ..write('questionCount: $questionCount, ')
          ..write('timeLimitSeconds: $timeLimitSeconds, ')
          ..write('secondsPerQuestion: $secondsPerQuestion, ')
          ..write('quizTypes: $quizTypes, ')
          ..write('includeNew: $includeNew, ')
          ..write('autoRate: $autoRate, ')
          ..write('allowHints: $allowHints, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    selection,
    questionCount,
    timeLimitSeconds,
    secondsPerQuestion,
    quizTypes,
    includeNew,
    autoRate,
    allowHints,
    createdAtMs,
    updatedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamPresetRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.selection == this.selection &&
          other.questionCount == this.questionCount &&
          other.timeLimitSeconds == this.timeLimitSeconds &&
          other.secondsPerQuestion == this.secondsPerQuestion &&
          other.quizTypes == this.quizTypes &&
          other.includeNew == this.includeNew &&
          other.autoRate == this.autoRate &&
          other.allowHints == this.allowHints &&
          other.createdAtMs == this.createdAtMs &&
          other.updatedAtMs == this.updatedAtMs);
}

class ExamPresetsCompanion extends UpdateCompanion<ExamPresetRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> selection;
  final Value<int> questionCount;
  final Value<int> timeLimitSeconds;
  final Value<int> secondsPerQuestion;
  final Value<int> quizTypes;
  final Value<bool> includeNew;
  final Value<bool> autoRate;
  final Value<bool> allowHints;
  final Value<int> createdAtMs;
  final Value<int> updatedAtMs;
  final Value<int> rowid;
  const ExamPresetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.selection = const Value.absent(),
    this.questionCount = const Value.absent(),
    this.timeLimitSeconds = const Value.absent(),
    this.secondsPerQuestion = const Value.absent(),
    this.quizTypes = const Value.absent(),
    this.includeNew = const Value.absent(),
    this.autoRate = const Value.absent(),
    this.allowHints = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExamPresetsCompanion.insert({
    required String id,
    required String name,
    required int selection,
    required int questionCount,
    required int timeLimitSeconds,
    required int secondsPerQuestion,
    required int quizTypes,
    required bool includeNew,
    required bool autoRate,
    required bool allowHints,
    required int createdAtMs,
    required int updatedAtMs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       selection = Value(selection),
       questionCount = Value(questionCount),
       timeLimitSeconds = Value(timeLimitSeconds),
       secondsPerQuestion = Value(secondsPerQuestion),
       quizTypes = Value(quizTypes),
       includeNew = Value(includeNew),
       autoRate = Value(autoRate),
       allowHints = Value(allowHints),
       createdAtMs = Value(createdAtMs),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<ExamPresetRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? selection,
    Expression<int>? questionCount,
    Expression<int>? timeLimitSeconds,
    Expression<int>? secondsPerQuestion,
    Expression<int>? quizTypes,
    Expression<bool>? includeNew,
    Expression<bool>? autoRate,
    Expression<bool>? allowHints,
    Expression<int>? createdAtMs,
    Expression<int>? updatedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (selection != null) 'selection': selection,
      if (questionCount != null) 'question_count': questionCount,
      if (timeLimitSeconds != null) 'time_limit_seconds': timeLimitSeconds,
      if (secondsPerQuestion != null)
        'seconds_per_question': secondsPerQuestion,
      if (quizTypes != null) 'quiz_types': quizTypes,
      if (includeNew != null) 'include_new': includeNew,
      if (autoRate != null) 'auto_rate': autoRate,
      if (allowHints != null) 'allow_hints': allowHints,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExamPresetsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? selection,
    Value<int>? questionCount,
    Value<int>? timeLimitSeconds,
    Value<int>? secondsPerQuestion,
    Value<int>? quizTypes,
    Value<bool>? includeNew,
    Value<bool>? autoRate,
    Value<bool>? allowHints,
    Value<int>? createdAtMs,
    Value<int>? updatedAtMs,
    Value<int>? rowid,
  }) {
    return ExamPresetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      selection: selection ?? this.selection,
      questionCount: questionCount ?? this.questionCount,
      timeLimitSeconds: timeLimitSeconds ?? this.timeLimitSeconds,
      secondsPerQuestion: secondsPerQuestion ?? this.secondsPerQuestion,
      quizTypes: quizTypes ?? this.quizTypes,
      includeNew: includeNew ?? this.includeNew,
      autoRate: autoRate ?? this.autoRate,
      allowHints: allowHints ?? this.allowHints,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (selection.present) {
      map['selection'] = Variable<int>(selection.value);
    }
    if (questionCount.present) {
      map['question_count'] = Variable<int>(questionCount.value);
    }
    if (timeLimitSeconds.present) {
      map['time_limit_seconds'] = Variable<int>(timeLimitSeconds.value);
    }
    if (secondsPerQuestion.present) {
      map['seconds_per_question'] = Variable<int>(secondsPerQuestion.value);
    }
    if (quizTypes.present) {
      map['quiz_types'] = Variable<int>(quizTypes.value);
    }
    if (includeNew.present) {
      map['include_new'] = Variable<bool>(includeNew.value);
    }
    if (autoRate.present) {
      map['auto_rate'] = Variable<bool>(autoRate.value);
    }
    if (allowHints.present) {
      map['allow_hints'] = Variable<bool>(allowHints.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamPresetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('selection: $selection, ')
          ..write('questionCount: $questionCount, ')
          ..write('timeLimitSeconds: $timeLimitSeconds, ')
          ..write('secondsPerQuestion: $secondsPerQuestion, ')
          ..write('quizTypes: $quizTypes, ')
          ..write('includeNew: $includeNew, ')
          ..write('autoRate: $autoRate, ')
          ..write('allowHints: $allowHints, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('updatedAtMs: $updatedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExamPresetDecksTable extends ExamPresetDecks
    with TableInfo<$ExamPresetDecksTable, ExamPresetDeckRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamPresetDecksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _presetIdMeta = const VerificationMeta(
    'presetId',
  );
  @override
  late final GeneratedColumn<String> presetId = GeneratedColumn<String>(
    'preset_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exam_presets (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _deckIdMeta = const VerificationMeta('deckId');
  @override
  late final GeneratedColumn<String> deckId = GeneratedColumn<String>(
    'deck_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES decks (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [presetId, deckId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exam_preset_decks';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExamPresetDeckRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('preset_id')) {
      context.handle(
        _presetIdMeta,
        presetId.isAcceptableOrUnknown(data['preset_id']!, _presetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_presetIdMeta);
    }
    if (data.containsKey('deck_id')) {
      context.handle(
        _deckIdMeta,
        deckId.isAcceptableOrUnknown(data['deck_id']!, _deckIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deckIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {presetId, deckId};
  @override
  ExamPresetDeckRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExamPresetDeckRow(
      presetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preset_id'],
      )!,
      deckId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deck_id'],
      )!,
    );
  }

  @override
  $ExamPresetDecksTable createAlias(String alias) {
    return $ExamPresetDecksTable(attachedDatabase, alias);
  }
}

class ExamPresetDeckRow extends DataClass
    implements Insertable<ExamPresetDeckRow> {
  final String presetId;
  final String deckId;
  const ExamPresetDeckRow({required this.presetId, required this.deckId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['preset_id'] = Variable<String>(presetId);
    map['deck_id'] = Variable<String>(deckId);
    return map;
  }

  ExamPresetDecksCompanion toCompanion(bool nullToAbsent) {
    return ExamPresetDecksCompanion(
      presetId: Value(presetId),
      deckId: Value(deckId),
    );
  }

  factory ExamPresetDeckRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExamPresetDeckRow(
      presetId: serializer.fromJson<String>(json['presetId']),
      deckId: serializer.fromJson<String>(json['deckId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'presetId': serializer.toJson<String>(presetId),
      'deckId': serializer.toJson<String>(deckId),
    };
  }

  ExamPresetDeckRow copyWith({String? presetId, String? deckId}) =>
      ExamPresetDeckRow(
        presetId: presetId ?? this.presetId,
        deckId: deckId ?? this.deckId,
      );
  ExamPresetDeckRow copyWithCompanion(ExamPresetDecksCompanion data) {
    return ExamPresetDeckRow(
      presetId: data.presetId.present ? data.presetId.value : this.presetId,
      deckId: data.deckId.present ? data.deckId.value : this.deckId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExamPresetDeckRow(')
          ..write('presetId: $presetId, ')
          ..write('deckId: $deckId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(presetId, deckId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamPresetDeckRow &&
          other.presetId == this.presetId &&
          other.deckId == this.deckId);
}

class ExamPresetDecksCompanion extends UpdateCompanion<ExamPresetDeckRow> {
  final Value<String> presetId;
  final Value<String> deckId;
  final Value<int> rowid;
  const ExamPresetDecksCompanion({
    this.presetId = const Value.absent(),
    this.deckId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExamPresetDecksCompanion.insert({
    required String presetId,
    required String deckId,
    this.rowid = const Value.absent(),
  }) : presetId = Value(presetId),
       deckId = Value(deckId);
  static Insertable<ExamPresetDeckRow> custom({
    Expression<String>? presetId,
    Expression<String>? deckId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (presetId != null) 'preset_id': presetId,
      if (deckId != null) 'deck_id': deckId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExamPresetDecksCompanion copyWith({
    Value<String>? presetId,
    Value<String>? deckId,
    Value<int>? rowid,
  }) {
    return ExamPresetDecksCompanion(
      presetId: presetId ?? this.presetId,
      deckId: deckId ?? this.deckId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (presetId.present) {
      map['preset_id'] = Variable<String>(presetId.value);
    }
    if (deckId.present) {
      map['deck_id'] = Variable<String>(deckId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamPresetDecksCompanion(')
          ..write('presetId: $presetId, ')
          ..write('deckId: $deckId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExamRunsTable extends ExamRuns
    with TableInfo<$ExamRunsTable, ExamRunRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamRunsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _presetIdMeta = const VerificationMeta(
    'presetId',
  );
  @override
  late final GeneratedColumn<String> presetId = GeneratedColumn<String>(
    'preset_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMsMeta = const VerificationMeta(
    'startedAtMs',
  );
  @override
  late final GeneratedColumn<int> startedAtMs = GeneratedColumn<int>(
    'started_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _finishedAtMsMeta = const VerificationMeta(
    'finishedAtMs',
  );
  @override
  late final GeneratedColumn<int> finishedAtMs = GeneratedColumn<int>(
    'finished_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionCountMeta = const VerificationMeta(
    'questionCount',
  );
  @override
  late final GeneratedColumn<int> questionCount = GeneratedColumn<int>(
    'question_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answeredCountMeta = const VerificationMeta(
    'answeredCount',
  );
  @override
  late final GeneratedColumn<int> answeredCount = GeneratedColumn<int>(
    'answered_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endReasonMeta = const VerificationMeta(
    'endReason',
  );
  @override
  late final GeneratedColumn<int> endReason = GeneratedColumn<int>(
    'end_reason',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    presetId,
    name,
    startedAtMs,
    finishedAtMs,
    questionCount,
    answeredCount,
    correctCount,
    endReason,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exam_runs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExamRunRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('preset_id')) {
      context.handle(
        _presetIdMeta,
        presetId.isAcceptableOrUnknown(data['preset_id']!, _presetIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('started_at_ms')) {
      context.handle(
        _startedAtMsMeta,
        startedAtMs.isAcceptableOrUnknown(
          data['started_at_ms']!,
          _startedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startedAtMsMeta);
    }
    if (data.containsKey('finished_at_ms')) {
      context.handle(
        _finishedAtMsMeta,
        finishedAtMs.isAcceptableOrUnknown(
          data['finished_at_ms']!,
          _finishedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_finishedAtMsMeta);
    }
    if (data.containsKey('question_count')) {
      context.handle(
        _questionCountMeta,
        questionCount.isAcceptableOrUnknown(
          data['question_count']!,
          _questionCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionCountMeta);
    }
    if (data.containsKey('answered_count')) {
      context.handle(
        _answeredCountMeta,
        answeredCount.isAcceptableOrUnknown(
          data['answered_count']!,
          _answeredCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_answeredCountMeta);
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctCountMeta);
    }
    if (data.containsKey('end_reason')) {
      context.handle(
        _endReasonMeta,
        endReason.isAcceptableOrUnknown(data['end_reason']!, _endReasonMeta),
      );
    } else if (isInserting) {
      context.missing(_endReasonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExamRunRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExamRunRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      presetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preset_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      startedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}started_at_ms'],
      )!,
      finishedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}finished_at_ms'],
      )!,
      questionCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}question_count'],
      )!,
      answeredCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}answered_count'],
      )!,
      correctCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_count'],
      )!,
      endReason: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_reason'],
      )!,
    );
  }

  @override
  $ExamRunsTable createAlias(String alias) {
    return $ExamRunsTable(attachedDatabase, alias);
  }
}

class ExamRunRow extends DataClass implements Insertable<ExamRunRow> {
  final String id;
  final String? presetId;
  final String name;
  final int startedAtMs;
  final int finishedAtMs;
  final int questionCount;
  final int answeredCount;
  final int correctCount;

  /// `ExamEndReason` value.
  final int endReason;
  const ExamRunRow({
    required this.id,
    this.presetId,
    required this.name,
    required this.startedAtMs,
    required this.finishedAtMs,
    required this.questionCount,
    required this.answeredCount,
    required this.correctCount,
    required this.endReason,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || presetId != null) {
      map['preset_id'] = Variable<String>(presetId);
    }
    map['name'] = Variable<String>(name);
    map['started_at_ms'] = Variable<int>(startedAtMs);
    map['finished_at_ms'] = Variable<int>(finishedAtMs);
    map['question_count'] = Variable<int>(questionCount);
    map['answered_count'] = Variable<int>(answeredCount);
    map['correct_count'] = Variable<int>(correctCount);
    map['end_reason'] = Variable<int>(endReason);
    return map;
  }

  ExamRunsCompanion toCompanion(bool nullToAbsent) {
    return ExamRunsCompanion(
      id: Value(id),
      presetId: presetId == null && nullToAbsent
          ? const Value.absent()
          : Value(presetId),
      name: Value(name),
      startedAtMs: Value(startedAtMs),
      finishedAtMs: Value(finishedAtMs),
      questionCount: Value(questionCount),
      answeredCount: Value(answeredCount),
      correctCount: Value(correctCount),
      endReason: Value(endReason),
    );
  }

  factory ExamRunRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExamRunRow(
      id: serializer.fromJson<String>(json['id']),
      presetId: serializer.fromJson<String?>(json['presetId']),
      name: serializer.fromJson<String>(json['name']),
      startedAtMs: serializer.fromJson<int>(json['startedAtMs']),
      finishedAtMs: serializer.fromJson<int>(json['finishedAtMs']),
      questionCount: serializer.fromJson<int>(json['questionCount']),
      answeredCount: serializer.fromJson<int>(json['answeredCount']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      endReason: serializer.fromJson<int>(json['endReason']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'presetId': serializer.toJson<String?>(presetId),
      'name': serializer.toJson<String>(name),
      'startedAtMs': serializer.toJson<int>(startedAtMs),
      'finishedAtMs': serializer.toJson<int>(finishedAtMs),
      'questionCount': serializer.toJson<int>(questionCount),
      'answeredCount': serializer.toJson<int>(answeredCount),
      'correctCount': serializer.toJson<int>(correctCount),
      'endReason': serializer.toJson<int>(endReason),
    };
  }

  ExamRunRow copyWith({
    String? id,
    Value<String?> presetId = const Value.absent(),
    String? name,
    int? startedAtMs,
    int? finishedAtMs,
    int? questionCount,
    int? answeredCount,
    int? correctCount,
    int? endReason,
  }) => ExamRunRow(
    id: id ?? this.id,
    presetId: presetId.present ? presetId.value : this.presetId,
    name: name ?? this.name,
    startedAtMs: startedAtMs ?? this.startedAtMs,
    finishedAtMs: finishedAtMs ?? this.finishedAtMs,
    questionCount: questionCount ?? this.questionCount,
    answeredCount: answeredCount ?? this.answeredCount,
    correctCount: correctCount ?? this.correctCount,
    endReason: endReason ?? this.endReason,
  );
  ExamRunRow copyWithCompanion(ExamRunsCompanion data) {
    return ExamRunRow(
      id: data.id.present ? data.id.value : this.id,
      presetId: data.presetId.present ? data.presetId.value : this.presetId,
      name: data.name.present ? data.name.value : this.name,
      startedAtMs: data.startedAtMs.present
          ? data.startedAtMs.value
          : this.startedAtMs,
      finishedAtMs: data.finishedAtMs.present
          ? data.finishedAtMs.value
          : this.finishedAtMs,
      questionCount: data.questionCount.present
          ? data.questionCount.value
          : this.questionCount,
      answeredCount: data.answeredCount.present
          ? data.answeredCount.value
          : this.answeredCount,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      endReason: data.endReason.present ? data.endReason.value : this.endReason,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExamRunRow(')
          ..write('id: $id, ')
          ..write('presetId: $presetId, ')
          ..write('name: $name, ')
          ..write('startedAtMs: $startedAtMs, ')
          ..write('finishedAtMs: $finishedAtMs, ')
          ..write('questionCount: $questionCount, ')
          ..write('answeredCount: $answeredCount, ')
          ..write('correctCount: $correctCount, ')
          ..write('endReason: $endReason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    presetId,
    name,
    startedAtMs,
    finishedAtMs,
    questionCount,
    answeredCount,
    correctCount,
    endReason,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamRunRow &&
          other.id == this.id &&
          other.presetId == this.presetId &&
          other.name == this.name &&
          other.startedAtMs == this.startedAtMs &&
          other.finishedAtMs == this.finishedAtMs &&
          other.questionCount == this.questionCount &&
          other.answeredCount == this.answeredCount &&
          other.correctCount == this.correctCount &&
          other.endReason == this.endReason);
}

class ExamRunsCompanion extends UpdateCompanion<ExamRunRow> {
  final Value<String> id;
  final Value<String?> presetId;
  final Value<String> name;
  final Value<int> startedAtMs;
  final Value<int> finishedAtMs;
  final Value<int> questionCount;
  final Value<int> answeredCount;
  final Value<int> correctCount;
  final Value<int> endReason;
  final Value<int> rowid;
  const ExamRunsCompanion({
    this.id = const Value.absent(),
    this.presetId = const Value.absent(),
    this.name = const Value.absent(),
    this.startedAtMs = const Value.absent(),
    this.finishedAtMs = const Value.absent(),
    this.questionCount = const Value.absent(),
    this.answeredCount = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.endReason = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExamRunsCompanion.insert({
    required String id,
    this.presetId = const Value.absent(),
    required String name,
    required int startedAtMs,
    required int finishedAtMs,
    required int questionCount,
    required int answeredCount,
    required int correctCount,
    required int endReason,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       startedAtMs = Value(startedAtMs),
       finishedAtMs = Value(finishedAtMs),
       questionCount = Value(questionCount),
       answeredCount = Value(answeredCount),
       correctCount = Value(correctCount),
       endReason = Value(endReason);
  static Insertable<ExamRunRow> custom({
    Expression<String>? id,
    Expression<String>? presetId,
    Expression<String>? name,
    Expression<int>? startedAtMs,
    Expression<int>? finishedAtMs,
    Expression<int>? questionCount,
    Expression<int>? answeredCount,
    Expression<int>? correctCount,
    Expression<int>? endReason,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (presetId != null) 'preset_id': presetId,
      if (name != null) 'name': name,
      if (startedAtMs != null) 'started_at_ms': startedAtMs,
      if (finishedAtMs != null) 'finished_at_ms': finishedAtMs,
      if (questionCount != null) 'question_count': questionCount,
      if (answeredCount != null) 'answered_count': answeredCount,
      if (correctCount != null) 'correct_count': correctCount,
      if (endReason != null) 'end_reason': endReason,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExamRunsCompanion copyWith({
    Value<String>? id,
    Value<String?>? presetId,
    Value<String>? name,
    Value<int>? startedAtMs,
    Value<int>? finishedAtMs,
    Value<int>? questionCount,
    Value<int>? answeredCount,
    Value<int>? correctCount,
    Value<int>? endReason,
    Value<int>? rowid,
  }) {
    return ExamRunsCompanion(
      id: id ?? this.id,
      presetId: presetId ?? this.presetId,
      name: name ?? this.name,
      startedAtMs: startedAtMs ?? this.startedAtMs,
      finishedAtMs: finishedAtMs ?? this.finishedAtMs,
      questionCount: questionCount ?? this.questionCount,
      answeredCount: answeredCount ?? this.answeredCount,
      correctCount: correctCount ?? this.correctCount,
      endReason: endReason ?? this.endReason,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (presetId.present) {
      map['preset_id'] = Variable<String>(presetId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startedAtMs.present) {
      map['started_at_ms'] = Variable<int>(startedAtMs.value);
    }
    if (finishedAtMs.present) {
      map['finished_at_ms'] = Variable<int>(finishedAtMs.value);
    }
    if (questionCount.present) {
      map['question_count'] = Variable<int>(questionCount.value);
    }
    if (answeredCount.present) {
      map['answered_count'] = Variable<int>(answeredCount.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (endReason.present) {
      map['end_reason'] = Variable<int>(endReason.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamRunsCompanion(')
          ..write('id: $id, ')
          ..write('presetId: $presetId, ')
          ..write('name: $name, ')
          ..write('startedAtMs: $startedAtMs, ')
          ..write('finishedAtMs: $finishedAtMs, ')
          ..write('questionCount: $questionCount, ')
          ..write('answeredCount: $answeredCount, ')
          ..write('correctCount: $correctCount, ')
          ..write('endReason: $endReason, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DecksTable decks = $DecksTable(this);
  late final $QuizzesTable quizzes = $QuizzesTable(this);
  late final $QuizOptionsTable quizOptions = $QuizOptionsTable(this);
  late final $CardStatesTable cardStates = $CardStatesTable(this);
  late final $ReviewEventsTable reviewEvents = $ReviewEventsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $ExamPresetsTable examPresets = $ExamPresetsTable(this);
  late final $ExamPresetDecksTable examPresetDecks = $ExamPresetDecksTable(
    this,
  );
  late final $ExamRunsTable examRuns = $ExamRunsTable(this);
  late final Index quizzesDeckPositionIdx = Index(
    'quizzes_deck_position_idx',
    'CREATE INDEX quizzes_deck_position_idx ON quizzes (deck_id, position)',
  );
  late final Index cardStatesDeckDueIdx = Index(
    'card_states_deck_due_idx',
    'CREATE INDEX card_states_deck_due_idx ON card_states (deck_id, due_at_ms)',
  );
  late final Index reviewEventsReviewedAtIdx = Index(
    'review_events_reviewed_at_idx',
    'CREATE INDEX review_events_reviewed_at_idx ON review_events (reviewed_at_ms)',
  );
  late final Index reviewEventsQuizIdx = Index(
    'review_events_quiz_idx',
    'CREATE INDEX review_events_quiz_idx ON review_events (quiz_id, reviewed_at_ms)',
  );
  late final Index examRunsStartedIdx = Index(
    'exam_runs_started_idx',
    'CREATE INDEX exam_runs_started_idx ON exam_runs (started_at_ms)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    decks,
    quizzes,
    quizOptions,
    cardStates,
    reviewEvents,
    settings,
    reminders,
    examPresets,
    examPresetDecks,
    examRuns,
    quizzesDeckPositionIdx,
    cardStatesDeckDueIdx,
    reviewEventsReviewedAtIdx,
    reviewEventsQuizIdx,
    examRunsStartedIdx,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'quizzes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('quiz_options', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'quizzes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('card_states', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'exam_presets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('exam_preset_decks', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$DecksTableCreateCompanionBuilder =
    DecksCompanion Function({
      required String id,
      required String title,
      Value<String> description,
      Value<String> author,
      Value<String> locale,
      Value<int> version,
      required int createdAtMs,
      required int updatedAtMs,
      Value<int?> deletedAtMs,
      Value<int> rowid,
    });
typedef $$DecksTableUpdateCompanionBuilder =
    DecksCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> description,
      Value<String> author,
      Value<String> locale,
      Value<int> version,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<int?> deletedAtMs,
      Value<int> rowid,
    });

final class $$DecksTableReferences
    extends BaseReferences<_$AppDatabase, $DecksTable, DeckRow> {
  $$DecksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$QuizzesTable, List<QuizRow>> _quizzesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.quizzes,
    aliasName: 'decks__id__quizzes__deck_id',
  );

  $$QuizzesTableProcessedTableManager get quizzesRefs {
    final manager = $$QuizzesTableTableManager(
      $_db,
      $_db.quizzes,
    ).filter((f) => f.deckId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_quizzesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CardStatesTable, List<CardStateRow>>
  _cardStatesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cardStates,
    aliasName: 'decks__id__card_states__deck_id',
  );

  $$CardStatesTableProcessedTableManager get cardStatesRefs {
    final manager = $$CardStatesTableTableManager(
      $_db,
      $_db.cardStates,
    ).filter((f) => f.deckId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_cardStatesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExamPresetDecksTable, List<ExamPresetDeckRow>>
  _examPresetDecksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.examPresetDecks,
    aliasName: 'decks__id__exam_preset_decks__deck_id',
  );

  $$ExamPresetDecksTableProcessedTableManager get examPresetDecksRefs {
    final manager = $$ExamPresetDecksTableTableManager(
      $_db,
      $_db.examPresetDecks,
    ).filter((f) => f.deckId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _examPresetDecksRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DecksTableFilterComposer extends Composer<_$AppDatabase, $DecksTable> {
  $$DecksTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> quizzesRefs(
    Expression<bool> Function($$QuizzesTableFilterComposer f) f,
  ) {
    final $$QuizzesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quizzes,
      getReferencedColumn: (t) => t.deckId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuizzesTableFilterComposer(
            $db: $db,
            $table: $db.quizzes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cardStatesRefs(
    Expression<bool> Function($$CardStatesTableFilterComposer f) f,
  ) {
    final $$CardStatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardStates,
      getReferencedColumn: (t) => t.deckId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardStatesTableFilterComposer(
            $db: $db,
            $table: $db.cardStates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> examPresetDecksRefs(
    Expression<bool> Function($$ExamPresetDecksTableFilterComposer f) f,
  ) {
    final $$ExamPresetDecksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.examPresetDecks,
      getReferencedColumn: (t) => t.deckId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamPresetDecksTableFilterComposer(
            $db: $db,
            $table: $db.examPresetDecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DecksTableOrderingComposer
    extends Composer<_$AppDatabase, $DecksTable> {
  $$DecksTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DecksTableAnnotationComposer
    extends Composer<_$AppDatabase, $DecksTable> {
  $$DecksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => column,
  );

  Expression<T> quizzesRefs<T extends Object>(
    Expression<T> Function($$QuizzesTableAnnotationComposer a) f,
  ) {
    final $$QuizzesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quizzes,
      getReferencedColumn: (t) => t.deckId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuizzesTableAnnotationComposer(
            $db: $db,
            $table: $db.quizzes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> cardStatesRefs<T extends Object>(
    Expression<T> Function($$CardStatesTableAnnotationComposer a) f,
  ) {
    final $$CardStatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardStates,
      getReferencedColumn: (t) => t.deckId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardStatesTableAnnotationComposer(
            $db: $db,
            $table: $db.cardStates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> examPresetDecksRefs<T extends Object>(
    Expression<T> Function($$ExamPresetDecksTableAnnotationComposer a) f,
  ) {
    final $$ExamPresetDecksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.examPresetDecks,
      getReferencedColumn: (t) => t.deckId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamPresetDecksTableAnnotationComposer(
            $db: $db,
            $table: $db.examPresetDecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DecksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DecksTable,
          DeckRow,
          $$DecksTableFilterComposer,
          $$DecksTableOrderingComposer,
          $$DecksTableAnnotationComposer,
          $$DecksTableCreateCompanionBuilder,
          $$DecksTableUpdateCompanionBuilder,
          (DeckRow, $$DecksTableReferences),
          DeckRow,
          PrefetchHooks Function({
            bool quizzesRefs,
            bool cardStatesRefs,
            bool examPresetDecksRefs,
          })
        > {
  $$DecksTableTableManager(_$AppDatabase db, $DecksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DecksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DecksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DecksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> author = const Value.absent(),
                Value<String> locale = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int?> deletedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DecksCompanion(
                id: id,
                title: title,
                description: description,
                author: author,
                locale: locale,
                version: version,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                deletedAtMs: deletedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String> description = const Value.absent(),
                Value<String> author = const Value.absent(),
                Value<String> locale = const Value.absent(),
                Value<int> version = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<int?> deletedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DecksCompanion.insert(
                id: id,
                title: title,
                description: description,
                author: author,
                locale: locale,
                version: version,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                deletedAtMs: deletedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DecksTable, DeckRow>(table),
                  $$DecksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                quizzesRefs = false,
                cardStatesRefs = false,
                examPresetDecksRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (quizzesRefs) db.quizzes,
                    if (cardStatesRefs) db.cardStates,
                    if (examPresetDecksRefs) db.examPresetDecks,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (quizzesRefs)
                        await $_getPrefetchedDataByColumns<
                          DeckRow,
                          $DecksTable,
                          QuizRow,
                          $QuizzesTable
                        >(
                          currentTable: table,
                          referencedTable: $$DecksTableReferences
                              ._quizzesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DecksTableReferences(db, table, p0).quizzesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'deck_id',
                          typedResults: items,
                        ),
                      if (cardStatesRefs)
                        await $_getPrefetchedDataByColumns<
                          DeckRow,
                          $DecksTable,
                          CardStateRow,
                          $CardStatesTable
                        >(
                          currentTable: table,
                          referencedTable: $$DecksTableReferences
                              ._cardStatesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DecksTableReferences(
                                db,
                                table,
                                p0,
                              ).cardStatesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'deck_id',
                          typedResults: items,
                        ),
                      if (examPresetDecksRefs)
                        await $_getPrefetchedDataByColumns<
                          DeckRow,
                          $DecksTable,
                          ExamPresetDeckRow,
                          $ExamPresetDecksTable
                        >(
                          currentTable: table,
                          referencedTable: $$DecksTableReferences
                              ._examPresetDecksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DecksTableReferences(
                                db,
                                table,
                                p0,
                              ).examPresetDecksRefs,
                          currentColumn: 'id',
                          referencedColumn: 'deck_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DecksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DecksTable,
      DeckRow,
      $$DecksTableFilterComposer,
      $$DecksTableOrderingComposer,
      $$DecksTableAnnotationComposer,
      $$DecksTableCreateCompanionBuilder,
      $$DecksTableUpdateCompanionBuilder,
      (DeckRow, $$DecksTableReferences),
      DeckRow,
      PrefetchHooks Function({
        bool quizzesRefs,
        bool cardStatesRefs,
        bool examPresetDecksRefs,
      })
    >;
typedef $$QuizzesTableCreateCompanionBuilder =
    QuizzesCompanion Function({
      required String id,
      required String deckId,
      required int type,
      required int position,
      required String question,
      Value<String> explanation,
      Value<String> hint,
      required int createdAtMs,
      required int updatedAtMs,
      Value<int?> deletedAtMs,
      Value<int> rowid,
    });
typedef $$QuizzesTableUpdateCompanionBuilder =
    QuizzesCompanion Function({
      Value<String> id,
      Value<String> deckId,
      Value<int> type,
      Value<int> position,
      Value<String> question,
      Value<String> explanation,
      Value<String> hint,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<int?> deletedAtMs,
      Value<int> rowid,
    });

final class $$QuizzesTableReferences
    extends BaseReferences<_$AppDatabase, $QuizzesTable, QuizRow> {
  $$QuizzesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DecksTable _deckIdTable(_$AppDatabase db) =>
      db.decks.createAlias('quizzes__deck_id__decks__id');

  $$DecksTableProcessedTableManager get deckId {
    final $_column = $_itemColumn<String>('deck_id')!;

    final manager = $$DecksTableTableManager(
      $_db,
      $_db.decks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deckIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$QuizOptionsTable, List<QuizOptionRow>>
  _quizOptionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.quizOptions,
    aliasName: 'quizzes__id__quiz_options__quiz_id',
  );

  $$QuizOptionsTableProcessedTableManager get quizOptionsRefs {
    final manager = $$QuizOptionsTableTableManager(
      $_db,
      $_db.quizOptions,
    ).filter((f) => f.quizId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_quizOptionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CardStatesTable, List<CardStateRow>>
  _cardStatesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cardStates,
    aliasName: 'quizzes__id__card_states__quiz_id',
  );

  $$CardStatesTableProcessedTableManager get cardStatesRefs {
    final manager = $$CardStatesTableTableManager(
      $_db,
      $_db.cardStates,
    ).filter((f) => f.quizId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_cardStatesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$QuizzesTableFilterComposer
    extends Composer<_$AppDatabase, $QuizzesTable> {
  $$QuizzesTableFilterComposer({
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

  ColumnFilters<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hint => $composableBuilder(
    column: $table.hint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  $$DecksTableFilterComposer get deckId {
    final $$DecksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableFilterComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> quizOptionsRefs(
    Expression<bool> Function($$QuizOptionsTableFilterComposer f) f,
  ) {
    final $$QuizOptionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quizOptions,
      getReferencedColumn: (t) => t.quizId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuizOptionsTableFilterComposer(
            $db: $db,
            $table: $db.quizOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cardStatesRefs(
    Expression<bool> Function($$CardStatesTableFilterComposer f) f,
  ) {
    final $$CardStatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardStates,
      getReferencedColumn: (t) => t.quizId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardStatesTableFilterComposer(
            $db: $db,
            $table: $db.cardStates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuizzesTableOrderingComposer
    extends Composer<_$AppDatabase, $QuizzesTable> {
  $$QuizzesTableOrderingComposer({
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

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get question => $composableBuilder(
    column: $table.question,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hint => $composableBuilder(
    column: $table.hint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$DecksTableOrderingComposer get deckId {
    final $$DecksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableOrderingComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuizzesTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuizzesTable> {
  $$QuizzesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get question =>
      $composableBuilder(column: $table.question, builder: (column) => column);

  GeneratedColumn<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hint =>
      $composableBuilder(column: $table.hint, builder: (column) => column);

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get deletedAtMs => $composableBuilder(
    column: $table.deletedAtMs,
    builder: (column) => column,
  );

  $$DecksTableAnnotationComposer get deckId {
    final $$DecksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableAnnotationComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> quizOptionsRefs<T extends Object>(
    Expression<T> Function($$QuizOptionsTableAnnotationComposer a) f,
  ) {
    final $$QuizOptionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quizOptions,
      getReferencedColumn: (t) => t.quizId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuizOptionsTableAnnotationComposer(
            $db: $db,
            $table: $db.quizOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> cardStatesRefs<T extends Object>(
    Expression<T> Function($$CardStatesTableAnnotationComposer a) f,
  ) {
    final $$CardStatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardStates,
      getReferencedColumn: (t) => t.quizId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardStatesTableAnnotationComposer(
            $db: $db,
            $table: $db.cardStates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$QuizzesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuizzesTable,
          QuizRow,
          $$QuizzesTableFilterComposer,
          $$QuizzesTableOrderingComposer,
          $$QuizzesTableAnnotationComposer,
          $$QuizzesTableCreateCompanionBuilder,
          $$QuizzesTableUpdateCompanionBuilder,
          (QuizRow, $$QuizzesTableReferences),
          QuizRow,
          PrefetchHooks Function({
            bool deckId,
            bool quizOptionsRefs,
            bool cardStatesRefs,
          })
        > {
  $$QuizzesTableTableManager(_$AppDatabase db, $QuizzesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuizzesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuizzesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuizzesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> deckId = const Value.absent(),
                Value<int> type = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> question = const Value.absent(),
                Value<String> explanation = const Value.absent(),
                Value<String> hint = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int?> deletedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuizzesCompanion(
                id: id,
                deckId: deckId,
                type: type,
                position: position,
                question: question,
                explanation: explanation,
                hint: hint,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                deletedAtMs: deletedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String deckId,
                required int type,
                required int position,
                required String question,
                Value<String> explanation = const Value.absent(),
                Value<String> hint = const Value.absent(),
                required int createdAtMs,
                required int updatedAtMs,
                Value<int?> deletedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuizzesCompanion.insert(
                id: id,
                deckId: deckId,
                type: type,
                position: position,
                question: question,
                explanation: explanation,
                hint: hint,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                deletedAtMs: deletedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QuizzesTable, QuizRow>(table),
                  $$QuizzesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                deckId = false,
                quizOptionsRefs = false,
                cardStatesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (quizOptionsRefs) db.quizOptions,
                    if (cardStatesRefs) db.cardStates,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (deckId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.deckId,
                                    referencedTable: $$QuizzesTableReferences
                                        ._deckIdTable(db),
                                    referencedColumn: $$QuizzesTableReferences
                                        ._deckIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (quizOptionsRefs)
                        await $_getPrefetchedDataByColumns<
                          QuizRow,
                          $QuizzesTable,
                          QuizOptionRow,
                          $QuizOptionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$QuizzesTableReferences
                              ._quizOptionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuizzesTableReferences(
                                db,
                                table,
                                p0,
                              ).quizOptionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'quiz_id',
                          typedResults: items,
                        ),
                      if (cardStatesRefs)
                        await $_getPrefetchedDataByColumns<
                          QuizRow,
                          $QuizzesTable,
                          CardStateRow,
                          $CardStatesTable
                        >(
                          currentTable: table,
                          referencedTable: $$QuizzesTableReferences
                              ._cardStatesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$QuizzesTableReferences(
                                db,
                                table,
                                p0,
                              ).cardStatesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'quiz_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$QuizzesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuizzesTable,
      QuizRow,
      $$QuizzesTableFilterComposer,
      $$QuizzesTableOrderingComposer,
      $$QuizzesTableAnnotationComposer,
      $$QuizzesTableCreateCompanionBuilder,
      $$QuizzesTableUpdateCompanionBuilder,
      (QuizRow, $$QuizzesTableReferences),
      QuizRow,
      PrefetchHooks Function({
        bool deckId,
        bool quizOptionsRefs,
        bool cardStatesRefs,
      })
    >;
typedef $$QuizOptionsTableCreateCompanionBuilder =
    QuizOptionsCompanion Function({
      required String quizId,
      required String id,
      required int position,
      required String body,
      Value<String> prompt,
      Value<String> mediaPath,
      Value<bool> isCorrect,
      Value<int> rowid,
    });
typedef $$QuizOptionsTableUpdateCompanionBuilder =
    QuizOptionsCompanion Function({
      Value<String> quizId,
      Value<String> id,
      Value<int> position,
      Value<String> body,
      Value<String> prompt,
      Value<String> mediaPath,
      Value<bool> isCorrect,
      Value<int> rowid,
    });

final class $$QuizOptionsTableReferences
    extends BaseReferences<_$AppDatabase, $QuizOptionsTable, QuizOptionRow> {
  $$QuizOptionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QuizzesTable _quizIdTable(_$AppDatabase db) =>
      db.quizzes.createAlias('quiz_options__quiz_id__quizzes__id');

  $$QuizzesTableProcessedTableManager get quizId {
    final $_column = $_itemColumn<String>('quiz_id')!;

    final manager = $$QuizzesTableTableManager(
      $_db,
      $_db.quizzes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_quizIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuizOptionsTableFilterComposer
    extends Composer<_$AppDatabase, $QuizOptionsTable> {
  $$QuizOptionsTableFilterComposer({
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

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prompt => $composableBuilder(
    column: $table.prompt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediaPath => $composableBuilder(
    column: $table.mediaPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnFilters(column),
  );

  $$QuizzesTableFilterComposer get quizId {
    final $$QuizzesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quizId,
      referencedTable: $db.quizzes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuizzesTableFilterComposer(
            $db: $db,
            $table: $db.quizzes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuizOptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuizOptionsTable> {
  $$QuizOptionsTableOrderingComposer({
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

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prompt => $composableBuilder(
    column: $table.prompt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaPath => $composableBuilder(
    column: $table.mediaPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuizzesTableOrderingComposer get quizId {
    final $$QuizzesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quizId,
      referencedTable: $db.quizzes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuizzesTableOrderingComposer(
            $db: $db,
            $table: $db.quizzes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuizOptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuizOptionsTable> {
  $$QuizOptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get prompt =>
      $composableBuilder(column: $table.prompt, builder: (column) => column);

  GeneratedColumn<String> get mediaPath =>
      $composableBuilder(column: $table.mediaPath, builder: (column) => column);

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  $$QuizzesTableAnnotationComposer get quizId {
    final $$QuizzesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quizId,
      referencedTable: $db.quizzes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuizzesTableAnnotationComposer(
            $db: $db,
            $table: $db.quizzes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuizOptionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuizOptionsTable,
          QuizOptionRow,
          $$QuizOptionsTableFilterComposer,
          $$QuizOptionsTableOrderingComposer,
          $$QuizOptionsTableAnnotationComposer,
          $$QuizOptionsTableCreateCompanionBuilder,
          $$QuizOptionsTableUpdateCompanionBuilder,
          (QuizOptionRow, $$QuizOptionsTableReferences),
          QuizOptionRow,
          PrefetchHooks Function({bool quizId})
        > {
  $$QuizOptionsTableTableManager(_$AppDatabase db, $QuizOptionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuizOptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuizOptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuizOptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> quizId = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String> prompt = const Value.absent(),
                Value<String> mediaPath = const Value.absent(),
                Value<bool> isCorrect = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuizOptionsCompanion(
                quizId: quizId,
                id: id,
                position: position,
                body: body,
                prompt: prompt,
                mediaPath: mediaPath,
                isCorrect: isCorrect,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String quizId,
                required String id,
                required int position,
                required String body,
                Value<String> prompt = const Value.absent(),
                Value<String> mediaPath = const Value.absent(),
                Value<bool> isCorrect = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuizOptionsCompanion.insert(
                quizId: quizId,
                id: id,
                position: position,
                body: body,
                prompt: prompt,
                mediaPath: mediaPath,
                isCorrect: isCorrect,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QuizOptionsTable, QuizOptionRow>(table),
                  $$QuizOptionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({quizId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (quizId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.quizId,
                                referencedTable: $$QuizOptionsTableReferences
                                    ._quizIdTable(db),
                                referencedColumn: $$QuizOptionsTableReferences
                                    ._quizIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$QuizOptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuizOptionsTable,
      QuizOptionRow,
      $$QuizOptionsTableFilterComposer,
      $$QuizOptionsTableOrderingComposer,
      $$QuizOptionsTableAnnotationComposer,
      $$QuizOptionsTableCreateCompanionBuilder,
      $$QuizOptionsTableUpdateCompanionBuilder,
      (QuizOptionRow, $$QuizOptionsTableReferences),
      QuizOptionRow,
      PrefetchHooks Function({bool quizId})
    >;
typedef $$CardStatesTableCreateCompanionBuilder =
    CardStatesCompanion Function({
      required String quizId,
      required String deckId,
      required int phase,
      Value<int?> step,
      Value<double?> stability,
      Value<double?> difficulty,
      required int dueAtMs,
      Value<int?> lastReviewedAtMs,
      Value<int> reps,
      Value<int> lapses,
      Value<int> rowid,
    });
typedef $$CardStatesTableUpdateCompanionBuilder =
    CardStatesCompanion Function({
      Value<String> quizId,
      Value<String> deckId,
      Value<int> phase,
      Value<int?> step,
      Value<double?> stability,
      Value<double?> difficulty,
      Value<int> dueAtMs,
      Value<int?> lastReviewedAtMs,
      Value<int> reps,
      Value<int> lapses,
      Value<int> rowid,
    });

final class $$CardStatesTableReferences
    extends BaseReferences<_$AppDatabase, $CardStatesTable, CardStateRow> {
  $$CardStatesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QuizzesTable _quizIdTable(_$AppDatabase db) =>
      db.quizzes.createAlias('card_states__quiz_id__quizzes__id');

  $$QuizzesTableProcessedTableManager get quizId {
    final $_column = $_itemColumn<String>('quiz_id')!;

    final manager = $$QuizzesTableTableManager(
      $_db,
      $_db.quizzes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_quizIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DecksTable _deckIdTable(_$AppDatabase db) =>
      db.decks.createAlias('card_states__deck_id__decks__id');

  $$DecksTableProcessedTableManager get deckId {
    final $_column = $_itemColumn<String>('deck_id')!;

    final manager = $$DecksTableTableManager(
      $_db,
      $_db.decks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deckIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CardStatesTableFilterComposer
    extends Composer<_$AppDatabase, $CardStatesTable> {
  $$CardStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get phase => $composableBuilder(
    column: $table.phase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get step => $composableBuilder(
    column: $table.step,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get stability => $composableBuilder(
    column: $table.stability,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueAtMs => $composableBuilder(
    column: $table.dueAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastReviewedAtMs => $composableBuilder(
    column: $table.lastReviewedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lapses => $composableBuilder(
    column: $table.lapses,
    builder: (column) => ColumnFilters(column),
  );

  $$QuizzesTableFilterComposer get quizId {
    final $$QuizzesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quizId,
      referencedTable: $db.quizzes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuizzesTableFilterComposer(
            $db: $db,
            $table: $db.quizzes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DecksTableFilterComposer get deckId {
    final $$DecksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableFilterComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $CardStatesTable> {
  $$CardStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get phase => $composableBuilder(
    column: $table.phase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get step => $composableBuilder(
    column: $table.step,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get stability => $composableBuilder(
    column: $table.stability,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueAtMs => $composableBuilder(
    column: $table.dueAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastReviewedAtMs => $composableBuilder(
    column: $table.lastReviewedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lapses => $composableBuilder(
    column: $table.lapses,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuizzesTableOrderingComposer get quizId {
    final $$QuizzesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quizId,
      referencedTable: $db.quizzes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuizzesTableOrderingComposer(
            $db: $db,
            $table: $db.quizzes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DecksTableOrderingComposer get deckId {
    final $$DecksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableOrderingComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardStatesTable> {
  $$CardStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get phase =>
      $composableBuilder(column: $table.phase, builder: (column) => column);

  GeneratedColumn<int> get step =>
      $composableBuilder(column: $table.step, builder: (column) => column);

  GeneratedColumn<double> get stability =>
      $composableBuilder(column: $table.stability, builder: (column) => column);

  GeneratedColumn<double> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dueAtMs =>
      $composableBuilder(column: $table.dueAtMs, builder: (column) => column);

  GeneratedColumn<int> get lastReviewedAtMs => $composableBuilder(
    column: $table.lastReviewedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<int> get lapses =>
      $composableBuilder(column: $table.lapses, builder: (column) => column);

  $$QuizzesTableAnnotationComposer get quizId {
    final $$QuizzesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quizId,
      referencedTable: $db.quizzes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuizzesTableAnnotationComposer(
            $db: $db,
            $table: $db.quizzes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DecksTableAnnotationComposer get deckId {
    final $$DecksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableAnnotationComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CardStatesTable,
          CardStateRow,
          $$CardStatesTableFilterComposer,
          $$CardStatesTableOrderingComposer,
          $$CardStatesTableAnnotationComposer,
          $$CardStatesTableCreateCompanionBuilder,
          $$CardStatesTableUpdateCompanionBuilder,
          (CardStateRow, $$CardStatesTableReferences),
          CardStateRow,
          PrefetchHooks Function({bool quizId, bool deckId})
        > {
  $$CardStatesTableTableManager(_$AppDatabase db, $CardStatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> quizId = const Value.absent(),
                Value<String> deckId = const Value.absent(),
                Value<int> phase = const Value.absent(),
                Value<int?> step = const Value.absent(),
                Value<double?> stability = const Value.absent(),
                Value<double?> difficulty = const Value.absent(),
                Value<int> dueAtMs = const Value.absent(),
                Value<int?> lastReviewedAtMs = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<int> lapses = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CardStatesCompanion(
                quizId: quizId,
                deckId: deckId,
                phase: phase,
                step: step,
                stability: stability,
                difficulty: difficulty,
                dueAtMs: dueAtMs,
                lastReviewedAtMs: lastReviewedAtMs,
                reps: reps,
                lapses: lapses,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String quizId,
                required String deckId,
                required int phase,
                Value<int?> step = const Value.absent(),
                Value<double?> stability = const Value.absent(),
                Value<double?> difficulty = const Value.absent(),
                required int dueAtMs,
                Value<int?> lastReviewedAtMs = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<int> lapses = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CardStatesCompanion.insert(
                quizId: quizId,
                deckId: deckId,
                phase: phase,
                step: step,
                stability: stability,
                difficulty: difficulty,
                dueAtMs: dueAtMs,
                lastReviewedAtMs: lastReviewedAtMs,
                reps: reps,
                lapses: lapses,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CardStatesTable, CardStateRow>(table),
                  $$CardStatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({quizId = false, deckId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (quizId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.quizId,
                                referencedTable: $$CardStatesTableReferences
                                    ._quizIdTable(db),
                                referencedColumn: $$CardStatesTableReferences
                                    ._quizIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (deckId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.deckId,
                                referencedTable: $$CardStatesTableReferences
                                    ._deckIdTable(db),
                                referencedColumn: $$CardStatesTableReferences
                                    ._deckIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CardStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CardStatesTable,
      CardStateRow,
      $$CardStatesTableFilterComposer,
      $$CardStatesTableOrderingComposer,
      $$CardStatesTableAnnotationComposer,
      $$CardStatesTableCreateCompanionBuilder,
      $$CardStatesTableUpdateCompanionBuilder,
      (CardStateRow, $$CardStatesTableReferences),
      CardStateRow,
      PrefetchHooks Function({bool quizId, bool deckId})
    >;
typedef $$ReviewEventsTableCreateCompanionBuilder =
    ReviewEventsCompanion Function({
      Value<int> id,
      required String clientId,
      required int clientSeq,
      required String quizId,
      required String deckId,
      required int rating,
      required int reviewedAtMs,
      required int durationMs,
      Value<int> mode,
    });
typedef $$ReviewEventsTableUpdateCompanionBuilder =
    ReviewEventsCompanion Function({
      Value<int> id,
      Value<String> clientId,
      Value<int> clientSeq,
      Value<String> quizId,
      Value<String> deckId,
      Value<int> rating,
      Value<int> reviewedAtMs,
      Value<int> durationMs,
      Value<int> mode,
    });

class $$ReviewEventsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewEventsTable> {
  $$ReviewEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get clientSeq => $composableBuilder(
    column: $table.clientSeq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quizId => $composableBuilder(
    column: $table.quizId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deckId => $composableBuilder(
    column: $table.deckId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewedAtMs => $composableBuilder(
    column: $table.reviewedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReviewEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewEventsTable> {
  $$ReviewEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get clientSeq => $composableBuilder(
    column: $table.clientSeq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quizId => $composableBuilder(
    column: $table.quizId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deckId => $composableBuilder(
    column: $table.deckId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewedAtMs => $composableBuilder(
    column: $table.reviewedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReviewEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewEventsTable> {
  $$ReviewEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<int> get clientSeq =>
      $composableBuilder(column: $table.clientSeq, builder: (column) => column);

  GeneratedColumn<String> get quizId =>
      $composableBuilder(column: $table.quizId, builder: (column) => column);

  GeneratedColumn<String> get deckId =>
      $composableBuilder(column: $table.deckId, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<int> get reviewedAtMs => $composableBuilder(
    column: $table.reviewedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);
}

class $$ReviewEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewEventsTable,
          ReviewEventRow,
          $$ReviewEventsTableFilterComposer,
          $$ReviewEventsTableOrderingComposer,
          $$ReviewEventsTableAnnotationComposer,
          $$ReviewEventsTableCreateCompanionBuilder,
          $$ReviewEventsTableUpdateCompanionBuilder,
          (
            ReviewEventRow,
            BaseReferences<_$AppDatabase, $ReviewEventsTable, ReviewEventRow>,
          ),
          ReviewEventRow,
          PrefetchHooks Function()
        > {
  $$ReviewEventsTableTableManager(_$AppDatabase db, $ReviewEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<int> clientSeq = const Value.absent(),
                Value<String> quizId = const Value.absent(),
                Value<String> deckId = const Value.absent(),
                Value<int> rating = const Value.absent(),
                Value<int> reviewedAtMs = const Value.absent(),
                Value<int> durationMs = const Value.absent(),
                Value<int> mode = const Value.absent(),
              }) => ReviewEventsCompanion(
                id: id,
                clientId: clientId,
                clientSeq: clientSeq,
                quizId: quizId,
                deckId: deckId,
                rating: rating,
                reviewedAtMs: reviewedAtMs,
                durationMs: durationMs,
                mode: mode,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String clientId,
                required int clientSeq,
                required String quizId,
                required String deckId,
                required int rating,
                required int reviewedAtMs,
                required int durationMs,
                Value<int> mode = const Value.absent(),
              }) => ReviewEventsCompanion.insert(
                id: id,
                clientId: clientId,
                clientSeq: clientSeq,
                quizId: quizId,
                deckId: deckId,
                rating: rating,
                reviewedAtMs: reviewedAtMs,
                durationMs: durationMs,
                mode: mode,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReviewEventsTable, ReviewEventRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ReviewEventsTable,
                    ReviewEventRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReviewEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewEventsTable,
      ReviewEventRow,
      $$ReviewEventsTableFilterComposer,
      $$ReviewEventsTableOrderingComposer,
      $$ReviewEventsTableAnnotationComposer,
      $$ReviewEventsTableCreateCompanionBuilder,
      $$ReviewEventsTableUpdateCompanionBuilder,
      (
        ReviewEventRow,
        BaseReferences<_$AppDatabase, $ReviewEventsTable, ReviewEventRow>,
      ),
      ReviewEventRow,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          SettingRow,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (
            SettingRow,
            BaseReferences<_$AppDatabase, $SettingsTable, SettingRow>,
          ),
          SettingRow,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingsTable, SettingRow>(table),
                  BaseReferences<_$AppDatabase, $SettingsTable, SettingRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      SettingRow,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (SettingRow, BaseReferences<_$AppDatabase, $SettingsTable, SettingRow>),
      SettingRow,
      PrefetchHooks Function()
    >;
typedef $$RemindersTableCreateCompanionBuilder =
    RemindersCompanion Function({
      Value<int> id,
      required int minuteOfDay,
      required int weekdays,
      Value<bool> enabled,
    });
typedef $$RemindersTableUpdateCompanionBuilder =
    RemindersCompanion Function({
      Value<int> id,
      Value<int> minuteOfDay,
      Value<int> weekdays,
      Value<bool> enabled,
    });

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minuteOfDay => $composableBuilder(
    column: $table.minuteOfDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekdays => $composableBuilder(
    column: $table.weekdays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minuteOfDay => $composableBuilder(
    column: $table.minuteOfDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekdays => $composableBuilder(
    column: $table.weekdays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get minuteOfDay => $composableBuilder(
    column: $table.minuteOfDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weekdays =>
      $composableBuilder(column: $table.weekdays, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          ReminderRow,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (
            ReminderRow,
            BaseReferences<_$AppDatabase, $RemindersTable, ReminderRow>,
          ),
          ReminderRow,
          PrefetchHooks Function()
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> minuteOfDay = const Value.absent(),
                Value<int> weekdays = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                minuteOfDay: minuteOfDay,
                weekdays: weekdays,
                enabled: enabled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int minuteOfDay,
                required int weekdays,
                Value<bool> enabled = const Value.absent(),
              }) => RemindersCompanion.insert(
                id: id,
                minuteOfDay: minuteOfDay,
                weekdays: weekdays,
                enabled: enabled,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RemindersTable, ReminderRow>(table),
                  BaseReferences<_$AppDatabase, $RemindersTable, ReminderRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      ReminderRow,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (
        ReminderRow,
        BaseReferences<_$AppDatabase, $RemindersTable, ReminderRow>,
      ),
      ReminderRow,
      PrefetchHooks Function()
    >;
typedef $$ExamPresetsTableCreateCompanionBuilder =
    ExamPresetsCompanion Function({
      required String id,
      required String name,
      required int selection,
      required int questionCount,
      required int timeLimitSeconds,
      required int secondsPerQuestion,
      required int quizTypes,
      required bool includeNew,
      required bool autoRate,
      required bool allowHints,
      required int createdAtMs,
      required int updatedAtMs,
      Value<int> rowid,
    });
typedef $$ExamPresetsTableUpdateCompanionBuilder =
    ExamPresetsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> selection,
      Value<int> questionCount,
      Value<int> timeLimitSeconds,
      Value<int> secondsPerQuestion,
      Value<int> quizTypes,
      Value<bool> includeNew,
      Value<bool> autoRate,
      Value<bool> allowHints,
      Value<int> createdAtMs,
      Value<int> updatedAtMs,
      Value<int> rowid,
    });

final class $$ExamPresetsTableReferences
    extends BaseReferences<_$AppDatabase, $ExamPresetsTable, ExamPresetRow> {
  $$ExamPresetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ExamPresetDecksTable, List<ExamPresetDeckRow>>
  _examPresetDecksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.examPresetDecks,
    aliasName: 'exam_presets__id__exam_preset_decks__preset_id',
  );

  $$ExamPresetDecksTableProcessedTableManager get examPresetDecksRefs {
    final manager = $$ExamPresetDecksTableTableManager(
      $_db,
      $_db.examPresetDecks,
    ).filter((f) => f.presetId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _examPresetDecksRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExamPresetsTableFilterComposer
    extends Composer<_$AppDatabase, $ExamPresetsTable> {
  $$ExamPresetsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get selection => $composableBuilder(
    column: $table.selection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get questionCount => $composableBuilder(
    column: $table.questionCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeLimitSeconds => $composableBuilder(
    column: $table.timeLimitSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get secondsPerQuestion => $composableBuilder(
    column: $table.secondsPerQuestion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quizTypes => $composableBuilder(
    column: $table.quizTypes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get includeNew => $composableBuilder(
    column: $table.includeNew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autoRate => $composableBuilder(
    column: $table.autoRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get allowHints => $composableBuilder(
    column: $table.allowHints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> examPresetDecksRefs(
    Expression<bool> Function($$ExamPresetDecksTableFilterComposer f) f,
  ) {
    final $$ExamPresetDecksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.examPresetDecks,
      getReferencedColumn: (t) => t.presetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamPresetDecksTableFilterComposer(
            $db: $db,
            $table: $db.examPresetDecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExamPresetsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamPresetsTable> {
  $$ExamPresetsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get selection => $composableBuilder(
    column: $table.selection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get questionCount => $composableBuilder(
    column: $table.questionCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeLimitSeconds => $composableBuilder(
    column: $table.timeLimitSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get secondsPerQuestion => $composableBuilder(
    column: $table.secondsPerQuestion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quizTypes => $composableBuilder(
    column: $table.quizTypes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get includeNew => $composableBuilder(
    column: $table.includeNew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autoRate => $composableBuilder(
    column: $table.autoRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allowHints => $composableBuilder(
    column: $table.allowHints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExamPresetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamPresetsTable> {
  $$ExamPresetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get selection =>
      $composableBuilder(column: $table.selection, builder: (column) => column);

  GeneratedColumn<int> get questionCount => $composableBuilder(
    column: $table.questionCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timeLimitSeconds => $composableBuilder(
    column: $table.timeLimitSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get secondsPerQuestion => $composableBuilder(
    column: $table.secondsPerQuestion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quizTypes =>
      $composableBuilder(column: $table.quizTypes, builder: (column) => column);

  GeneratedColumn<bool> get includeNew => $composableBuilder(
    column: $table.includeNew,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get autoRate =>
      $composableBuilder(column: $table.autoRate, builder: (column) => column);

  GeneratedColumn<bool> get allowHints => $composableBuilder(
    column: $table.allowHints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );

  Expression<T> examPresetDecksRefs<T extends Object>(
    Expression<T> Function($$ExamPresetDecksTableAnnotationComposer a) f,
  ) {
    final $$ExamPresetDecksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.examPresetDecks,
      getReferencedColumn: (t) => t.presetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamPresetDecksTableAnnotationComposer(
            $db: $db,
            $table: $db.examPresetDecks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExamPresetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExamPresetsTable,
          ExamPresetRow,
          $$ExamPresetsTableFilterComposer,
          $$ExamPresetsTableOrderingComposer,
          $$ExamPresetsTableAnnotationComposer,
          $$ExamPresetsTableCreateCompanionBuilder,
          $$ExamPresetsTableUpdateCompanionBuilder,
          (ExamPresetRow, $$ExamPresetsTableReferences),
          ExamPresetRow,
          PrefetchHooks Function({bool examPresetDecksRefs})
        > {
  $$ExamPresetsTableTableManager(_$AppDatabase db, $ExamPresetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamPresetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamPresetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamPresetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> selection = const Value.absent(),
                Value<int> questionCount = const Value.absent(),
                Value<int> timeLimitSeconds = const Value.absent(),
                Value<int> secondsPerQuestion = const Value.absent(),
                Value<int> quizTypes = const Value.absent(),
                Value<bool> includeNew = const Value.absent(),
                Value<bool> autoRate = const Value.absent(),
                Value<bool> allowHints = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExamPresetsCompanion(
                id: id,
                name: name,
                selection: selection,
                questionCount: questionCount,
                timeLimitSeconds: timeLimitSeconds,
                secondsPerQuestion: secondsPerQuestion,
                quizTypes: quizTypes,
                includeNew: includeNew,
                autoRate: autoRate,
                allowHints: allowHints,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int selection,
                required int questionCount,
                required int timeLimitSeconds,
                required int secondsPerQuestion,
                required int quizTypes,
                required bool includeNew,
                required bool autoRate,
                required bool allowHints,
                required int createdAtMs,
                required int updatedAtMs,
                Value<int> rowid = const Value.absent(),
              }) => ExamPresetsCompanion.insert(
                id: id,
                name: name,
                selection: selection,
                questionCount: questionCount,
                timeLimitSeconds: timeLimitSeconds,
                secondsPerQuestion: secondsPerQuestion,
                quizTypes: quizTypes,
                includeNew: includeNew,
                autoRate: autoRate,
                allowHints: allowHints,
                createdAtMs: createdAtMs,
                updatedAtMs: updatedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExamPresetsTable, ExamPresetRow>(table),
                  $$ExamPresetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({examPresetDecksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (examPresetDecksRefs) db.examPresetDecks,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (examPresetDecksRefs)
                    await $_getPrefetchedDataByColumns<
                      ExamPresetRow,
                      $ExamPresetsTable,
                      ExamPresetDeckRow,
                      $ExamPresetDecksTable
                    >(
                      currentTable: table,
                      referencedTable: $$ExamPresetsTableReferences
                          ._examPresetDecksRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ExamPresetsTableReferences(
                            db,
                            table,
                            p0,
                          ).examPresetDecksRefs,
                      currentColumn: 'id',
                      referencedColumn: 'preset_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ExamPresetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExamPresetsTable,
      ExamPresetRow,
      $$ExamPresetsTableFilterComposer,
      $$ExamPresetsTableOrderingComposer,
      $$ExamPresetsTableAnnotationComposer,
      $$ExamPresetsTableCreateCompanionBuilder,
      $$ExamPresetsTableUpdateCompanionBuilder,
      (ExamPresetRow, $$ExamPresetsTableReferences),
      ExamPresetRow,
      PrefetchHooks Function({bool examPresetDecksRefs})
    >;
typedef $$ExamPresetDecksTableCreateCompanionBuilder =
    ExamPresetDecksCompanion Function({
      required String presetId,
      required String deckId,
      Value<int> rowid,
    });
typedef $$ExamPresetDecksTableUpdateCompanionBuilder =
    ExamPresetDecksCompanion Function({
      Value<String> presetId,
      Value<String> deckId,
      Value<int> rowid,
    });

final class $$ExamPresetDecksTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExamPresetDecksTable,
          ExamPresetDeckRow
        > {
  $$ExamPresetDecksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExamPresetsTable _presetIdTable(_$AppDatabase db) => db.examPresets
      .createAlias('exam_preset_decks__preset_id__exam_presets__id');

  $$ExamPresetsTableProcessedTableManager get presetId {
    final $_column = $_itemColumn<String>('preset_id')!;

    final manager = $$ExamPresetsTableTableManager(
      $_db,
      $_db.examPresets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_presetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DecksTable _deckIdTable(_$AppDatabase db) =>
      db.decks.createAlias('exam_preset_decks__deck_id__decks__id');

  $$DecksTableProcessedTableManager get deckId {
    final $_column = $_itemColumn<String>('deck_id')!;

    final manager = $$DecksTableTableManager(
      $_db,
      $_db.decks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deckIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExamPresetDecksTableFilterComposer
    extends Composer<_$AppDatabase, $ExamPresetDecksTable> {
  $$ExamPresetDecksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ExamPresetsTableFilterComposer get presetId {
    final $$ExamPresetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.presetId,
      referencedTable: $db.examPresets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamPresetsTableFilterComposer(
            $db: $db,
            $table: $db.examPresets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DecksTableFilterComposer get deckId {
    final $$DecksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableFilterComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExamPresetDecksTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamPresetDecksTable> {
  $$ExamPresetDecksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ExamPresetsTableOrderingComposer get presetId {
    final $$ExamPresetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.presetId,
      referencedTable: $db.examPresets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamPresetsTableOrderingComposer(
            $db: $db,
            $table: $db.examPresets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DecksTableOrderingComposer get deckId {
    final $$DecksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableOrderingComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExamPresetDecksTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamPresetDecksTable> {
  $$ExamPresetDecksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ExamPresetsTableAnnotationComposer get presetId {
    final $$ExamPresetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.presetId,
      referencedTable: $db.examPresets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExamPresetsTableAnnotationComposer(
            $db: $db,
            $table: $db.examPresets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DecksTableAnnotationComposer get deckId {
    final $$DecksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deckId,
      referencedTable: $db.decks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DecksTableAnnotationComposer(
            $db: $db,
            $table: $db.decks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExamPresetDecksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExamPresetDecksTable,
          ExamPresetDeckRow,
          $$ExamPresetDecksTableFilterComposer,
          $$ExamPresetDecksTableOrderingComposer,
          $$ExamPresetDecksTableAnnotationComposer,
          $$ExamPresetDecksTableCreateCompanionBuilder,
          $$ExamPresetDecksTableUpdateCompanionBuilder,
          (ExamPresetDeckRow, $$ExamPresetDecksTableReferences),
          ExamPresetDeckRow,
          PrefetchHooks Function({bool presetId, bool deckId})
        > {
  $$ExamPresetDecksTableTableManager(
    _$AppDatabase db,
    $ExamPresetDecksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamPresetDecksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamPresetDecksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamPresetDecksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> presetId = const Value.absent(),
                Value<String> deckId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExamPresetDecksCompanion(
                presetId: presetId,
                deckId: deckId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String presetId,
                required String deckId,
                Value<int> rowid = const Value.absent(),
              }) => ExamPresetDecksCompanion.insert(
                presetId: presetId,
                deckId: deckId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExamPresetDecksTable, ExamPresetDeckRow>(table),
                  $$ExamPresetDecksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({presetId = false, deckId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (presetId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.presetId,
                                referencedTable:
                                    $$ExamPresetDecksTableReferences
                                        ._presetIdTable(db),
                                referencedColumn:
                                    $$ExamPresetDecksTableReferences
                                        ._presetIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (deckId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.deckId,
                                referencedTable:
                                    $$ExamPresetDecksTableReferences
                                        ._deckIdTable(db),
                                referencedColumn:
                                    $$ExamPresetDecksTableReferences
                                        ._deckIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExamPresetDecksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExamPresetDecksTable,
      ExamPresetDeckRow,
      $$ExamPresetDecksTableFilterComposer,
      $$ExamPresetDecksTableOrderingComposer,
      $$ExamPresetDecksTableAnnotationComposer,
      $$ExamPresetDecksTableCreateCompanionBuilder,
      $$ExamPresetDecksTableUpdateCompanionBuilder,
      (ExamPresetDeckRow, $$ExamPresetDecksTableReferences),
      ExamPresetDeckRow,
      PrefetchHooks Function({bool presetId, bool deckId})
    >;
typedef $$ExamRunsTableCreateCompanionBuilder =
    ExamRunsCompanion Function({
      required String id,
      Value<String?> presetId,
      required String name,
      required int startedAtMs,
      required int finishedAtMs,
      required int questionCount,
      required int answeredCount,
      required int correctCount,
      required int endReason,
      Value<int> rowid,
    });
typedef $$ExamRunsTableUpdateCompanionBuilder =
    ExamRunsCompanion Function({
      Value<String> id,
      Value<String?> presetId,
      Value<String> name,
      Value<int> startedAtMs,
      Value<int> finishedAtMs,
      Value<int> questionCount,
      Value<int> answeredCount,
      Value<int> correctCount,
      Value<int> endReason,
      Value<int> rowid,
    });

class $$ExamRunsTableFilterComposer
    extends Composer<_$AppDatabase, $ExamRunsTable> {
  $$ExamRunsTableFilterComposer({
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

  ColumnFilters<String> get presetId => $composableBuilder(
    column: $table.presetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startedAtMs => $composableBuilder(
    column: $table.startedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get finishedAtMs => $composableBuilder(
    column: $table.finishedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get questionCount => $composableBuilder(
    column: $table.questionCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get answeredCount => $composableBuilder(
    column: $table.answeredCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endReason => $composableBuilder(
    column: $table.endReason,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExamRunsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamRunsTable> {
  $$ExamRunsTableOrderingComposer({
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

  ColumnOrderings<String> get presetId => $composableBuilder(
    column: $table.presetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startedAtMs => $composableBuilder(
    column: $table.startedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get finishedAtMs => $composableBuilder(
    column: $table.finishedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get questionCount => $composableBuilder(
    column: $table.questionCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get answeredCount => $composableBuilder(
    column: $table.answeredCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endReason => $composableBuilder(
    column: $table.endReason,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExamRunsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamRunsTable> {
  $$ExamRunsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get presetId =>
      $composableBuilder(column: $table.presetId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get startedAtMs => $composableBuilder(
    column: $table.startedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get finishedAtMs => $composableBuilder(
    column: $table.finishedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get questionCount => $composableBuilder(
    column: $table.questionCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get answeredCount => $composableBuilder(
    column: $table.answeredCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endReason =>
      $composableBuilder(column: $table.endReason, builder: (column) => column);
}

class $$ExamRunsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExamRunsTable,
          ExamRunRow,
          $$ExamRunsTableFilterComposer,
          $$ExamRunsTableOrderingComposer,
          $$ExamRunsTableAnnotationComposer,
          $$ExamRunsTableCreateCompanionBuilder,
          $$ExamRunsTableUpdateCompanionBuilder,
          (
            ExamRunRow,
            BaseReferences<_$AppDatabase, $ExamRunsTable, ExamRunRow>,
          ),
          ExamRunRow,
          PrefetchHooks Function()
        > {
  $$ExamRunsTableTableManager(_$AppDatabase db, $ExamRunsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamRunsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamRunsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamRunsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> presetId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> startedAtMs = const Value.absent(),
                Value<int> finishedAtMs = const Value.absent(),
                Value<int> questionCount = const Value.absent(),
                Value<int> answeredCount = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> endReason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExamRunsCompanion(
                id: id,
                presetId: presetId,
                name: name,
                startedAtMs: startedAtMs,
                finishedAtMs: finishedAtMs,
                questionCount: questionCount,
                answeredCount: answeredCount,
                correctCount: correctCount,
                endReason: endReason,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> presetId = const Value.absent(),
                required String name,
                required int startedAtMs,
                required int finishedAtMs,
                required int questionCount,
                required int answeredCount,
                required int correctCount,
                required int endReason,
                Value<int> rowid = const Value.absent(),
              }) => ExamRunsCompanion.insert(
                id: id,
                presetId: presetId,
                name: name,
                startedAtMs: startedAtMs,
                finishedAtMs: finishedAtMs,
                questionCount: questionCount,
                answeredCount: answeredCount,
                correctCount: correctCount,
                endReason: endReason,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExamRunsTable, ExamRunRow>(table),
                  BaseReferences<_$AppDatabase, $ExamRunsTable, ExamRunRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExamRunsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExamRunsTable,
      ExamRunRow,
      $$ExamRunsTableFilterComposer,
      $$ExamRunsTableOrderingComposer,
      $$ExamRunsTableAnnotationComposer,
      $$ExamRunsTableCreateCompanionBuilder,
      $$ExamRunsTableUpdateCompanionBuilder,
      (ExamRunRow, BaseReferences<_$AppDatabase, $ExamRunsTable, ExamRunRow>),
      ExamRunRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DecksTableTableManager get decks =>
      $$DecksTableTableManager(_db, _db.decks);
  $$QuizzesTableTableManager get quizzes =>
      $$QuizzesTableTableManager(_db, _db.quizzes);
  $$QuizOptionsTableTableManager get quizOptions =>
      $$QuizOptionsTableTableManager(_db, _db.quizOptions);
  $$CardStatesTableTableManager get cardStates =>
      $$CardStatesTableTableManager(_db, _db.cardStates);
  $$ReviewEventsTableTableManager get reviewEvents =>
      $$ReviewEventsTableTableManager(_db, _db.reviewEvents);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$ExamPresetsTableTableManager get examPresets =>
      $$ExamPresetsTableTableManager(_db, _db.examPresets);
  $$ExamPresetDecksTableTableManager get examPresetDecks =>
      $$ExamPresetDecksTableTableManager(_db, _db.examPresetDecks);
  $$ExamRunsTableTableManager get examRuns =>
      $$ExamRunsTableTableManager(_db, _db.examRuns);
}
