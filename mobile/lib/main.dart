import 'package:flutter/material.dart';

import 'theme.dart';

void main() {
  runApp(const QyicApp());
}

/// Root widget of the Qyic mobile client.
///
/// The app is offline-first by design (ADR-0006): everything under `lib/` must
/// work with no network. The review loop, FSRS scheduling, and gamification all
/// run against the local SQLite store; sync is a background concern.
class QyicApp extends StatelessWidget {
  const QyicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qyic',
      debugShowCheckedModeBanner: false,
      theme: buildQyicTheme(),
      home: const HomePage(),
    );
  }
}

class _Feature {
  const _Feature(this.icon, this.color, this.title, this.description);

  final IconData icon;
  final Color color;
  final String title;
  final String description;
}

const _features = [
  _Feature(
    Icons.sports_esports_rounded,
    QyicColors.primary,
    'Gamified quizzes',
    'Multiple choice, fill-in-the-blank, matching and true/false.',
  ),
  _Feature(
    Icons.psychology_rounded,
    QyicColors.xp,
    'Spaced repetition',
    'FSRS-style scheduling decides when each card comes back.',
  ),
  _Feature(
    Icons.cloud_off_rounded,
    QyicColors.success,
    'Offline-first',
    'Study anywhere; sync happens quietly in the background.',
  ),
];

/// Scaffold landing page — replaced by the study loop in milestone M1.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
              children: [
                const _BrandMark(),
                const SizedBox(height: 24),
                Text(
                  'Qyic',
                  textAlign: TextAlign.center,
                  style: textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Spaced repetition that plays like a game.',
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    color: QyicColors.muted,
                  ),
                ),
                const SizedBox(height: 32),
                for (final feature in _features) ...[
                  _FeatureCard(feature: feature),
                  const SizedBox(height: 12),
                ],
                const SizedBox(height: 12),
                Text(
                  'Scaffold — the study loop lands in M1.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall?.copyWith(
                    color: QyicColors.muted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
        label: 'Qyic logo',
        excludeSemantics: true,
        child: Container(
          width: 72,
          height: 72,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [QyicColors.primary, Color(0xFFA855F7)],
            ),
            boxShadow: [
              BoxShadow(
                color: QyicColors.primary.withValues(alpha: 0.35),
                blurRadius: 25,
                spreadRadius: -5,
              ),
            ],
          ),
          child: const Text(
            'Q',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.feature});

  final _Feature feature;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: feature.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(feature.icon, color: feature.color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feature.title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    feature.description,
                    style: textTheme.bodyMedium?.copyWith(
                      color: QyicColors.muted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
