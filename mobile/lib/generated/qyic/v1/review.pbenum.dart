// This is a generated file - do not edit.
//
// Generated from qyic/v1/review.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// FSRS grade given by the learner (or inferred from speed in timed modes).
class ReviewRating extends $pb.ProtobufEnum {
  static const ReviewRating REVIEW_RATING_UNSPECIFIED =
      ReviewRating._(0, _omitEnumNames ? '' : 'REVIEW_RATING_UNSPECIFIED');
  static const ReviewRating REVIEW_RATING_AGAIN =
      ReviewRating._(1, _omitEnumNames ? '' : 'REVIEW_RATING_AGAIN');
  static const ReviewRating REVIEW_RATING_HARD =
      ReviewRating._(2, _omitEnumNames ? '' : 'REVIEW_RATING_HARD');
  static const ReviewRating REVIEW_RATING_GOOD =
      ReviewRating._(3, _omitEnumNames ? '' : 'REVIEW_RATING_GOOD');
  static const ReviewRating REVIEW_RATING_EASY =
      ReviewRating._(4, _omitEnumNames ? '' : 'REVIEW_RATING_EASY');

  static const $core.List<ReviewRating> values = <ReviewRating>[
    REVIEW_RATING_UNSPECIFIED,
    REVIEW_RATING_AGAIN,
    REVIEW_RATING_HARD,
    REVIEW_RATING_GOOD,
    REVIEW_RATING_EASY,
  ];

  static final $core.List<ReviewRating?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static ReviewRating? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ReviewRating._(super.value, super.name);
}

/// How the review was performed. Every mode reschedules the card the same way;
/// the mode only feeds statistics and history.
class ReviewMode extends $pb.ProtobufEnum {
  /// Events written before this field existed; treat as STANDARD.
  static const ReviewMode REVIEW_MODE_UNSPECIFIED =
      ReviewMode._(0, _omitEnumNames ? '' : 'REVIEW_MODE_UNSPECIFIED');

  /// Regular study of the due queue.
  static const ReviewMode REVIEW_MODE_STANDARD =
      ReviewMode._(1, _omitEnumNames ? '' : 'REVIEW_MODE_STANDARD');

  /// Exam mode: a configured, optionally timed session that may include cards
  /// that are not due yet.
  static const ReviewMode REVIEW_MODE_EXAM =
      ReviewMode._(2, _omitEnumNames ? '' : 'REVIEW_MODE_EXAM');

  static const $core.List<ReviewMode> values = <ReviewMode>[
    REVIEW_MODE_UNSPECIFIED,
    REVIEW_MODE_STANDARD,
    REVIEW_MODE_EXAM,
  ];

  static final $core.List<ReviewMode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static ReviewMode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ReviewMode._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
