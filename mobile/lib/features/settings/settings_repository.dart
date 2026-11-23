import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/ids.dart';
import '../../core/providers.dart';
import '../../core/scheduling/fsrs.dart';

class AppSettings {
  const AppSettings({
    this.dailyGoal = 30,
    this.desiredRetention = 0.9,
    this.newCardsPerDay = 20,
    this.languageTag,
    this.hapticFeedback = true,
    this.showIntervalPreviews = true,
    this.displayName,
  });

  static const dailyGoalRange = (min: 5, max: 500);
  static const desiredRetentionRange = (min: 0.70, max: 0.97);
  static const newCardsPerDayRange = (min: 0, max: 200);

  /// Reviews per day that complete the daily goal.
  final int dailyGoal;

  /// Target recall probability used by the FSRS scheduler.
  final double desiredRetention;

  /// Maximum never-seen cards introduced per day across all decks.
  final int newCardsPerDay;

  /// BCP-47 tag of the UI language (e.g. `pt-PT`); null follows the system.
  final String? languageTag;

  /// Vibrate on answers and ratings.
  final bool hapticFeedback;

  /// Show the next interval on each rating button.
  final bool showIntervalPreviews;

  /// Name shown on the Me screen; null until the learner sets one.
  final String? displayName;

  static const displayNameMaxLength = 40;

  FsrsScheduler scheduler() =>
      FsrsScheduler(FsrsParameters(desiredRetention: desiredRetention));
}

class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;

  static const _clientIdKey = 'client_id';
  static const _dailyGoalKey = 'daily_goal';
  static const _desiredRetentionKey = 'desired_retention';
  static const _newCardsPerDayKey = 'new_cards_per_day';
  static const _languageKey = 'language';
  static const _hapticsKey = 'haptic_feedback';
  static const _intervalPreviewsKey = 'interval_previews';
  static const _displayNameKey = 'display_name';
  static const _starterDeckKey = 'starter_deck_installed';

  Stream<AppSettings> watch() =>
      _db.select(_db.settings).watch().map(_fromRows);

  Future<AppSettings> load() async =>
      _fromRows(await _db.select(_db.settings).get());

  /// Device id for `ReviewEvent.client_id`, created once per install.
  Future<String> clientId() => _db.transaction(() async {
    final existing = await _read(_clientIdKey);
    if (existing != null) return existing;
    final id = newUuid();
    await _write(_clientIdKey, id);
    return id;
  });

  Future<void> setDailyGoal(int value) {
    final range = AppSettings.dailyGoalRange;
    _checkRange(value, range.min, range.max, 'dailyGoal');
    return _write(_dailyGoalKey, '$value');
  }

  Future<void> setDesiredRetention(double value) {
    final range = AppSettings.desiredRetentionRange;
    _checkRange(value, range.min, range.max, 'desiredRetention');
    return _write(_desiredRetentionKey, '$value');
  }

  Future<void> setNewCardsPerDay(int value) {
    final range = AppSettings.newCardsPerDayRange;
    _checkRange(value, range.min, range.max, 'newCardsPerDay');
    return _write(_newCardsPerDayKey, '$value');
  }

  /// Null follows the system language.
  Future<void> setLanguageTag(String? tag) =>
      tag == null ? _delete(_languageKey) : _write(_languageKey, tag);

  Future<void> setHapticFeedback(bool enabled) =>
      _write(_hapticsKey, _bool(enabled));

  Future<void> setShowIntervalPreviews(bool enabled) =>
      _write(_intervalPreviewsKey, _bool(enabled));

  /// Blank names clear the setting.
  Future<void> setDisplayName(String name) {
    final trimmed = name.trim();
    if (trimmed.length > AppSettings.displayNameMaxLength) {
      throw ArgumentError.value(name, 'name', 'is too long');
    }
    return trimmed.isEmpty
        ? _delete(_displayNameKey)
        : _write(_displayNameKey, trimmed);
  }

  Future<bool> isStarterDeckInstalled() async =>
      await _read(_starterDeckKey) != null;

  Future<void> markStarterDeckInstalled() => _write(_starterDeckKey, '1');

  AppSettings _fromRows(List<SettingRow> rows) {
    final values = {for (final row in rows) row.key: row.value};
    const defaults = AppSettings();
    bool flag(String key, bool fallback) => switch (values[key]) {
      '1' => true,
      '0' => false,
      _ => fallback,
    };
    return AppSettings(
      dailyGoal:
          int.tryParse(values[_dailyGoalKey] ?? '') ?? defaults.dailyGoal,
      desiredRetention:
          double.tryParse(values[_desiredRetentionKey] ?? '') ??
          defaults.desiredRetention,
      newCardsPerDay:
          int.tryParse(values[_newCardsPerDayKey] ?? '') ??
          defaults.newCardsPerDay,
      languageTag: values[_languageKey],
      hapticFeedback: flag(_hapticsKey, defaults.hapticFeedback),
      showIntervalPreviews: flag(
        _intervalPreviewsKey,
        defaults.showIntervalPreviews,
      ),
      displayName: values[_displayNameKey],
    );
  }

  Future<String?> _read(String key) async {
    final row = await (_db.select(
      _db.settings,
    )..where((s) => s.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Future<void> _write(String key, String value) => _db
      .into(_db.settings)
      .insertOnConflictUpdate(SettingsCompanion.insert(key: key, value: value));

  Future<void> _delete(String key) =>
      (_db.delete(_db.settings)..where((s) => s.key.equals(key))).go();

  static String _bool(bool value) => value ? '1' : '0';

  static void _checkRange(num value, num min, num max, String name) {
    if (value < min || value > max) {
      throw ArgumentError.value(value, name, 'must be between $min and $max');
    }
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(databaseProvider)),
);

final settingsProvider = StreamProvider<AppSettings>(
  (ref) => ref.watch(settingsRepositoryProvider).watch(),
);
