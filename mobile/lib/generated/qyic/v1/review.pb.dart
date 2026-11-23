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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'review.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'review.pbenum.dart';

/// An immutable, append-only record of a single review.
class ReviewEvent extends $pb.GeneratedMessage {
  factory ReviewEvent({
    $core.String? clientId,
    $fixnum.Int64? clientSeq,
    $core.String? quizId,
    $core.String? deckId,
    ReviewRating? rating,
    $fixnum.Int64? reviewedAtUnixMs,
    $core.int? durationMs,
    ReviewMode? mode,
  }) {
    final result = ReviewEvent._();
    if (clientId != null) result.clientId = clientId;
    if (clientSeq != null) result.clientSeq = clientSeq;
    if (quizId != null) result.quizId = quizId;
    if (deckId != null) result.deckId = deckId;
    if (rating != null) result.rating = rating;
    if (reviewedAtUnixMs != null) result.reviewedAtUnixMs = reviewedAtUnixMs;
    if (durationMs != null) result.durationMs = durationMs;
    if (mode != null) result.mode = mode;
    return result;
  }

  ReviewEvent._();

  factory ReviewEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReviewEvent()..mergeFromBuffer(data, registry);
  factory ReviewEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReviewEvent()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReviewEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'qyic.v1'),
      createEmptyInstance: ReviewEvent.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'clientId')
    ..aInt64(2, _omitFieldNames ? '' : 'clientSeq')
    ..aOS(3, _omitFieldNames ? '' : 'quizId')
    ..aOS(4, _omitFieldNames ? '' : 'deckId')
    ..aE<ReviewRating>(5, _omitFieldNames ? '' : 'rating',
        enumValues: ReviewRating.values)
    ..aInt64(6, _omitFieldNames ? '' : 'reviewedAtUnixMs')
    ..aI(7, _omitFieldNames ? '' : 'durationMs')
    ..aE<ReviewMode>(8, _omitFieldNames ? '' : 'mode',
        enumValues: ReviewMode.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReviewEvent copyWith(void Function(ReviewEvent) updates) =>
      super.copyWith((message) => updates(message as ReviewEvent))
          as ReviewEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ReviewEvent() / ReviewEvent.new instead')
  static ReviewEvent create() => ReviewEvent._();
  static $pb.GeneratedMessage $_createMessage() => ReviewEvent._();
  @$core.override
  ReviewEvent createEmptyInstance() => ReviewEvent._();
  @$core.pragma('dart2js:noInline')
  static ReviewEvent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReviewEvent>(
          ReviewEvent.$_createMessage);
  static ReviewEvent? _defaultInstance;

  /// Device id created at first launch and persisted locally.
  @$pb.TagNumber(1)
  $core.String get clientId => $_getSZ(0);
  @$pb.TagNumber(1)
  set clientId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientId() => $_clearField(1);

  /// Monotonic per-device counter; makes sync idempotent.
  @$pb.TagNumber(2)
  $fixnum.Int64 get clientSeq => $_getI64(1);
  @$pb.TagNumber(2)
  set clientSeq($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasClientSeq() => $_has(1);
  @$pb.TagNumber(2)
  void clearClientSeq() => $_clearField(2);

  /// Quiz being reviewed (uuid). Deliberately not a FK: events outlive quizzes.
  @$pb.TagNumber(3)
  $core.String get quizId => $_getSZ(2);
  @$pb.TagNumber(3)
  set quizId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasQuizId() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuizId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get deckId => $_getSZ(3);
  @$pb.TagNumber(4)
  set deckId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDeckId() => $_has(3);
  @$pb.TagNumber(4)
  void clearDeckId() => $_clearField(4);

  @$pb.TagNumber(5)
  ReviewRating get rating => $_getN(4);
  @$pb.TagNumber(5)
  set rating(ReviewRating value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasRating() => $_has(4);
  @$pb.TagNumber(5)
  void clearRating() => $_clearField(5);

  /// Wall-clock time of the review on the device (ms since epoch).
  @$pb.TagNumber(6)
  $fixnum.Int64 get reviewedAtUnixMs => $_getI64(5);
  @$pb.TagNumber(6)
  set reviewedAtUnixMs($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasReviewedAtUnixMs() => $_has(5);
  @$pb.TagNumber(6)
  void clearReviewedAtUnixMs() => $_clearField(6);

  /// Time spent answering (ms), used for speed-based scheduling/timed modes.
  @$pb.TagNumber(7)
  $core.int get durationMs => $_getIZ(6);
  @$pb.TagNumber(7)
  set durationMs($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDurationMs() => $_has(6);
  @$pb.TagNumber(7)
  void clearDurationMs() => $_clearField(7);

  @$pb.TagNumber(8)
  ReviewMode get mode => $_getN(7);
  @$pb.TagNumber(8)
  set mode(ReviewMode value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasMode() => $_has(7);
  @$pb.TagNumber(8)
  void clearMode() => $_clearField(8);
}

class SyncPushRequest extends $pb.GeneratedMessage {
  factory SyncPushRequest({
    $core.String? clientId,
    $core.Iterable<ReviewEvent>? events,
  }) {
    final result = SyncPushRequest._();
    if (clientId != null) result.clientId = clientId;
    if (events != null) result.events.addAll(events);
    return result;
  }

  SyncPushRequest._();

  factory SyncPushRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncPushRequest()..mergeFromBuffer(data, registry);
  factory SyncPushRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncPushRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncPushRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'qyic.v1'),
      createEmptyInstance: SyncPushRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'clientId')
    ..pPM<ReviewEvent>(2, _omitFieldNames ? '' : 'events',
        subBuilder: ReviewEvent.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncPushRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncPushRequest copyWith(void Function(SyncPushRequest) updates) =>
      super.copyWith((message) => updates(message as SyncPushRequest))
          as SyncPushRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SyncPushRequest() / SyncPushRequest.new instead')
  static SyncPushRequest create() => SyncPushRequest._();
  static $pb.GeneratedMessage $_createMessage() => SyncPushRequest._();
  @$core.override
  SyncPushRequest createEmptyInstance() => SyncPushRequest._();
  @$core.pragma('dart2js:noInline')
  static SyncPushRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncPushRequest>(
          SyncPushRequest.$_createMessage);
  static SyncPushRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get clientId => $_getSZ(0);
  @$pb.TagNumber(1)
  set clientId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<ReviewEvent> get events => $_getList(1);
}

class SyncPushResponse extends $pb.GeneratedMessage {
  factory SyncPushResponse({
    $fixnum.Int64? lastAckedSeq,
  }) {
    final result = SyncPushResponse._();
    if (lastAckedSeq != null) result.lastAckedSeq = lastAckedSeq;
    return result;
  }

  SyncPushResponse._();

  factory SyncPushResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncPushResponse()..mergeFromBuffer(data, registry);
  factory SyncPushResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncPushResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncPushResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'qyic.v1'),
      createEmptyInstance: SyncPushResponse.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'lastAckedSeq')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncPushResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncPushResponse copyWith(void Function(SyncPushResponse) updates) =>
      super.copyWith((message) => updates(message as SyncPushResponse))
          as SyncPushResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SyncPushResponse() / SyncPushResponse.new instead')
  static SyncPushResponse create() => SyncPushResponse._();
  static $pb.GeneratedMessage $_createMessage() => SyncPushResponse._();
  @$core.override
  SyncPushResponse createEmptyInstance() => SyncPushResponse._();
  @$core.pragma('dart2js:noInline')
  static SyncPushResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncPushResponse>(
          SyncPushResponse.$_createMessage);
  static SyncPushResponse? _defaultInstance;

  /// Highest client_seq durably stored by the server.
  @$pb.TagNumber(1)
  $fixnum.Int64 get lastAckedSeq => $_getI64(0);
  @$pb.TagNumber(1)
  set lastAckedSeq($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLastAckedSeq() => $_has(0);
  @$pb.TagNumber(1)
  void clearLastAckedSeq() => $_clearField(1);
}

class SyncPullRequest extends $pb.GeneratedMessage {
  factory SyncPullRequest({
    $core.String? clientId,
    $fixnum.Int64? sinceCursor,
    $core.int? limit,
  }) {
    final result = SyncPullRequest._();
    if (clientId != null) result.clientId = clientId;
    if (sinceCursor != null) result.sinceCursor = sinceCursor;
    if (limit != null) result.limit = limit;
    return result;
  }

  SyncPullRequest._();

  factory SyncPullRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncPullRequest()..mergeFromBuffer(data, registry);
  factory SyncPullRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncPullRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncPullRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'qyic.v1'),
      createEmptyInstance: SyncPullRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'clientId')
    ..aInt64(2, _omitFieldNames ? '' : 'sinceCursor')
    ..aI(3, _omitFieldNames ? '' : 'limit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncPullRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncPullRequest copyWith(void Function(SyncPullRequest) updates) =>
      super.copyWith((message) => updates(message as SyncPullRequest))
          as SyncPullRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SyncPullRequest() / SyncPullRequest.new instead')
  static SyncPullRequest create() => SyncPullRequest._();
  static $pb.GeneratedMessage $_createMessage() => SyncPullRequest._();
  @$core.override
  SyncPullRequest createEmptyInstance() => SyncPullRequest._();
  @$core.pragma('dart2js:noInline')
  static SyncPullRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncPullRequest>(
          SyncPullRequest.$_createMessage);
  static SyncPullRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get clientId => $_getSZ(0);
  @$pb.TagNumber(1)
  set clientId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientId() => $_clearField(1);

  /// Opaque-to-client cursor from a previous pull (server-interpreted).
  @$pb.TagNumber(2)
  $fixnum.Int64 get sinceCursor => $_getI64(1);
  @$pb.TagNumber(2)
  set sinceCursor($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSinceCursor() => $_has(1);
  @$pb.TagNumber(2)
  void clearSinceCursor() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class SyncPullResponse extends $pb.GeneratedMessage {
  factory SyncPullResponse({
    $core.Iterable<ReviewEvent>? events,
    $fixnum.Int64? nextCursor,
    $core.bool? hasMore,
  }) {
    final result = SyncPullResponse._();
    if (events != null) result.events.addAll(events);
    if (nextCursor != null) result.nextCursor = nextCursor;
    if (hasMore != null) result.hasMore = hasMore;
    return result;
  }

  SyncPullResponse._();

  factory SyncPullResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncPullResponse()..mergeFromBuffer(data, registry);
  factory SyncPullResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SyncPullResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncPullResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'qyic.v1'),
      createEmptyInstance: SyncPullResponse.$_createMessage)
    ..pPM<ReviewEvent>(1, _omitFieldNames ? '' : 'events',
        subBuilder: ReviewEvent.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'nextCursor')
    ..aOB(3, _omitFieldNames ? '' : 'hasMore')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncPullResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncPullResponse copyWith(void Function(SyncPullResponse) updates) =>
      super.copyWith((message) => updates(message as SyncPullResponse))
          as SyncPullResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SyncPullResponse() / SyncPullResponse.new instead')
  static SyncPullResponse create() => SyncPullResponse._();
  static $pb.GeneratedMessage $_createMessage() => SyncPullResponse._();
  @$core.override
  SyncPullResponse createEmptyInstance() => SyncPullResponse._();
  @$core.pragma('dart2js:noInline')
  static SyncPullResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncPullResponse>(
          SyncPullResponse.$_createMessage);
  static SyncPullResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ReviewEvent> get events => $_getList(0);

  /// Cursor to pass in the next pull.
  @$pb.TagNumber(2)
  $fixnum.Int64 get nextCursor => $_getI64(1);
  @$pb.TagNumber(2)
  set nextCursor($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextCursor() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextCursor() => $_clearField(2);

  /// True when more data is available beyond `limit`.
  @$pb.TagNumber(3)
  $core.bool get hasMore => $_getBF(2);
  @$pb.TagNumber(3)
  set hasMore($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHasMore() => $_has(2);
  @$pb.TagNumber(3)
  void clearHasMore() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
