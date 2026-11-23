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

/// The kind of quiz presented to the learner.
class QuizType extends $pb.ProtobufEnum {
  static const QuizType QUIZ_TYPE_UNSPECIFIED =
      QuizType._(0, _omitEnumNames ? '' : 'QUIZ_TYPE_UNSPECIFIED');
  static const QuizType QUIZ_TYPE_MULTIPLE_CHOICE =
      QuizType._(1, _omitEnumNames ? '' : 'QUIZ_TYPE_MULTIPLE_CHOICE');
  static const QuizType QUIZ_TYPE_FILL_IN_THE_BLANK =
      QuizType._(2, _omitEnumNames ? '' : 'QUIZ_TYPE_FILL_IN_THE_BLANK');
  static const QuizType QUIZ_TYPE_MATCHING =
      QuizType._(3, _omitEnumNames ? '' : 'QUIZ_TYPE_MATCHING');
  static const QuizType QUIZ_TYPE_TRUE_FALSE =
      QuizType._(4, _omitEnumNames ? '' : 'QUIZ_TYPE_TRUE_FALSE');

  /// Front on `question`, back on `explanation`; `options` are unused.
  static const QuizType QUIZ_TYPE_FLASHCARD =
      QuizType._(5, _omitEnumNames ? '' : 'QUIZ_TYPE_FLASHCARD');

  static const $core.List<QuizType> values = <QuizType>[
    QUIZ_TYPE_UNSPECIFIED,
    QUIZ_TYPE_MULTIPLE_CHOICE,
    QUIZ_TYPE_FILL_IN_THE_BLANK,
    QUIZ_TYPE_MATCHING,
    QUIZ_TYPE_TRUE_FALSE,
    QUIZ_TYPE_FLASHCARD,
  ];

  static final $core.List<QuizType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static QuizType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const QuizType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
