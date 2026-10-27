import 'package:flutter/material.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

/// Scaffold landing page — replaced by the study loop in milestone M1.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Qyic',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Spaced repetition that plays like a game.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              Text(
                'Scaffold — the study loop lands in M1.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
