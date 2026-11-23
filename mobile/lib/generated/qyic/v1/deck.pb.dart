// This is a generated file - do not edit.
//
// Generated from qyic/v1/deck.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'deck.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'deck.pbenum.dart';

/// A single answer alternative. Per-type semantics (docs/deck-format.md §3):
/// - FILL_IN_THE_BLANK: each option is an accepted answer (`is_correct` = true).
/// - MATCHING: each option is one pair — `prompt` is the left-hand term and
///   `text` is its match.
/// - TRUE_FALSE: exactly two options with ids "true" and "false".
class Option extends $pb.GeneratedMessage {
  factory Option({
    $core.String? id,
    $core.String? text,
    $core.String? mediaPath,
    $core.bool? isCorrect,
    $core.String? prompt,
  }) {
    final result = Option._();
    if (id != null) result.id = id;
    if (text != null) result.text = text;
    if (mediaPath != null) result.mediaPath = mediaPath;
    if (isCorrect != null) result.isCorrect = isCorrect;
    if (prompt != null) result.prompt = prompt;
    return result;
  }

  Option._();

  factory Option.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Option()..mergeFromBuffer(data, registry);
  factory Option.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Option()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Option',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'qyic.v1'),
      createEmptyInstance: Option.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'text')
    ..aOS(3, _omitFieldNames ? '' : 'mediaPath')
    ..aOB(4, _omitFieldNames ? '' : 'isCorrect')
    ..aOS(5, _omitFieldNames ? '' : 'prompt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Option clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Option copyWith(void Function(Option) updates) =>
      super.copyWith((message) => updates(message as Option)) as Option;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Option() / Option.new instead')
  static Option create() => Option._();
  static $pb.GeneratedMessage $_createMessage() => Option._();
  @$core.override
  Option createEmptyInstance() => Option._();
  @$core.pragma('dart2js:noInline')
  static Option getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Option>(Option.$_createMessage);
  static Option? _defaultInstance;

  /// Stable id within the quiz (e.g. "opt_a").
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// Human-readable text.
  @$pb.TagNumber(2)
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(2)
  set text($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(2)
  void clearText() => $_clearField(2);

  /// Optional media asset, archive-relative (e.g. "media/img_01.png").
  @$pb.TagNumber(3)
  $core.String get mediaPath => $_getSZ(2);
  @$pb.TagNumber(3)
  set mediaPath($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMediaPath() => $_has(2);
  @$pb.TagNumber(3)
  void clearMediaPath() => $_clearField(3);

  /// Whether this option is a correct answer.
  @$pb.TagNumber(4)
  $core.bool get isCorrect => $_getBF(3);
  @$pb.TagNumber(4)
  set isCorrect($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasIsCorrect() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsCorrect() => $_clearField(4);

  /// MATCHING only: the left-hand term paired with `text`. Empty otherwise.
  @$pb.TagNumber(5)
  $core.String get prompt => $_getSZ(4);
  @$pb.TagNumber(5)
  set prompt($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPrompt() => $_has(4);
  @$pb.TagNumber(5)
  void clearPrompt() => $_clearField(5);
}

/// One quiz item.
class Quiz extends $pb.GeneratedMessage {
  factory Quiz({
    $core.String? id,
    QuizType? type,
    $core.String? question,
    $core.String? explanation,
    $core.Iterable<Option>? options,
    $core.double? difficulty,
    $core.double? stability,
    $core.String? hint,
  }) {
    final result = Quiz._();
    if (id != null) result.id = id;
    if (type != null) result.type = type;
    if (question != null) result.question = question;
    if (explanation != null) result.explanation = explanation;
    if (options != null) result.options.addAll(options);
    if (difficulty != null) result.difficulty = difficulty;
    if (stability != null) result.stability = stability;
    if (hint != null) result.hint = hint;
    return result;
  }

  Quiz._();

  factory Quiz.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Quiz()..mergeFromBuffer(data, registry);
  factory Quiz.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Quiz()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Quiz',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'qyic.v1'),
      createEmptyInstance: Quiz.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aE<QuizType>(2, _omitFieldNames ? '' : 'type',
        enumValues: QuizType.values)
    ..aOS(3, _omitFieldNames ? '' : 'question')
    ..aOS(4, _omitFieldNames ? '' : 'explanation')
    ..pPM<Option>(5, _omitFieldNames ? '' : 'options',
        subBuilder: Option.$_createMessage)
    ..aD(6, _omitFieldNames ? '' : 'difficulty', fieldType: $pb.PbFieldType.OF)
    ..aD(7, _omitFieldNames ? '' : 'stability', fieldType: $pb.PbFieldType.OF)
    ..aOS(8, _omitFieldNames ? '' : 'hint')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Quiz clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Quiz copyWith(void Function(Quiz) updates) =>
      super.copyWith((message) => updates(message as Quiz)) as Quiz;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Quiz() / Quiz.new instead')
  static Quiz create() => Quiz._();
  static $pb.GeneratedMessage $_createMessage() => Quiz._();
  @$core.override
  Quiz createEmptyInstance() => Quiz._();
  @$core.pragma('dart2js:noInline')
  static Quiz getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Quiz>(Quiz.$_createMessage);
  static Quiz? _defaultInstance;

  /// Stable id (uuid) — constant across exports/imports.
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  QuizType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(QuizType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  /// The prompt shown to the learner.
  @$pb.TagNumber(3)
  $core.String get question => $_getSZ(2);
  @$pb.TagNumber(3)
  set question($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuestion() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuestion() => $_clearField(3);

  /// Shown after answering, regardless of correctness.
  @$pb.TagNumber(4)
  $core.String get explanation => $_getSZ(3);
  @$pb.TagNumber(4)
  set explanation($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasExplanation() => $_has(3);
  @$pb.TagNumber(4)
  void clearExplanation() => $_clearField(4);

  /// Answer alternatives (>= 2 for choice-based types).
  @$pb.TagNumber(5)
  $pb.PbList<Option> get options => $_getList(4);

  /// --- Optional study history (included only when the exporter opts in) ---
  /// FSRS difficulty parameter at export time.
  @$pb.TagNumber(6)
  $core.double get difficulty => $_getN(5);
  @$pb.TagNumber(6)
  set difficulty($core.double value) => $_setFloat(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDifficulty() => $_has(5);
  @$pb.TagNumber(6)
  void clearDifficulty() => $_clearField(6);

  /// FSRS stability (days) at export time.
  @$pb.TagNumber(7)
  $core.double get stability => $_getN(6);
  @$pb.TagNumber(7)
  set stability($core.double value) => $_setFloat(6, value);
  @$pb.TagNumber(7)
  $core.bool hasStability() => $_has(6);
  @$pb.TagNumber(7)
  void clearStability() => $_clearField(7);

  /// Optional context shown with the question, visually secondary (e.g. the
  /// translation of a fill-in-the-blank sentence). Never reveals the answer.
  @$pb.TagNumber(8)
  $core.String get hint => $_getSZ(7);
  @$pb.TagNumber(8)
  set hint($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasHint() => $_has(7);
  @$pb.TagNumber(8)
  void clearHint() => $_clearField(8);
}

/// A shareable deck.
class Deck extends $pb.GeneratedMessage {
  factory Deck({
    $core.String? id,
    $core.String? title,
    $core.String? description,
    $core.String? author,
    $core.int? version,
    $core.Iterable<Quiz>? quizzes,
    $core.String? locale,
  }) {
    final result = Deck._();
    if (id != null) result.id = id;
    if (title != null) result.title = title;
    if (description != null) result.description = description;
    if (author != null) result.author = author;
    if (version != null) result.version = version;
    if (quizzes != null) result.quizzes.addAll(quizzes);
    if (locale != null) result.locale = locale;
    return result;
  }

  Deck._();

  factory Deck.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Deck()..mergeFromBuffer(data, registry);
  factory Deck.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Deck()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Deck',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'qyic.v1'),
      createEmptyInstance: Deck.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'author')
    ..aI(5, _omitFieldNames ? '' : 'version')
    ..pPM<Quiz>(6, _omitFieldNames ? '' : 'quizzes',
        subBuilder: Quiz.$_createMessage)
    ..aOS(7, _omitFieldNames ? '' : 'locale')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deck clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Deck copyWith(void Function(Deck) updates) =>
      super.copyWith((message) => updates(message as Deck)) as Deck;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Deck() / Deck.new instead')
  static Deck create() => Deck._();
  static $pb.GeneratedMessage $_createMessage() => Deck._();
  @$core.override
  Deck createEmptyInstance() => Deck._();
  @$core.pragma('dart2js:noInline')
  static Deck getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Deck>(Deck.$_createMessage);
  static Deck? _defaultInstance;

  /// Stable id (uuid).
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get author => $_getSZ(3);
  @$pb.TagNumber(4)
  set author($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAuthor() => $_has(3);
  @$pb.TagNumber(4)
  void clearAuthor() => $_clearField(4);

  /// Deck content version, bumped by the author on export.
  @$pb.TagNumber(5)
  $core.int get version => $_getIZ(4);
  @$pb.TagNumber(5)
  set version($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearVersion() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<Quiz> get quizzes => $_getList(5);

  /// BCP-47 content language, e.g. "en", "pt-BR".
  @$pb.TagNumber(7)
  $core.String get locale => $_getSZ(6);
  @$pb.TagNumber(7)
  set locale($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLocale() => $_has(6);
  @$pb.TagNumber(7)
  void clearLocale() => $_clearField(7);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
