import 'package:material_ui/material_ui.dart';

import '../../core/widgets/qyic_bottom_nav.dart';
import '../decks/presentation/library_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  /// Windows at least this wide use a navigation rail instead of a bottom bar.
  static const railBreakpoint = 840.0;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  QyicTab _tab = QyicTab.home;

  void _select(QyicTab tab) => setState(() => _tab = tab);

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= AppShell.railBreakpoint;
    final pages = IndexedStack(
      index: _tab.index,
      children: const [HomeScreen(), LibraryScreen(), ProfileScreen()],
    );
    if (wide) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: QyicNavRail(current: _tab, onChanged: _select),
            ),
            Expanded(child: pages),
          ],
        ),
      );
    }
    return Scaffold(
      body: pages,
      // Edge-to-edge (enforced from Android 15): keep the tabs clear of the
      // system gesture bar.
      bottomNavigationBar: SafeArea(
        top: false,
        child: QyicBottomNav(current: _tab, onChanged: _select),
      ),
    );
  }
}
