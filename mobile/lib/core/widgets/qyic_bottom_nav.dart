import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../theme/qyic_colors.dart';

enum QyicTab { home, library, me }

/// Labels and icons shared by the bottom bar and the navigation rail.
({IconData icon, IconData selected, String label}) qyicTabLook(
  AppLocalizations l10n,
  QyicTab tab,
) => switch (tab) {
  QyicTab.home => (
    icon: Icons.home_outlined,
    selected: Icons.home_rounded,
    label: l10n.navHome,
  ),
  QyicTab.library => (
    icon: Icons.folder_outlined,
    selected: Icons.folder_rounded,
    label: l10n.navLibrary,
  ),
  QyicTab.me => (
    icon: Icons.person_outline,
    selected: Icons.person_rounded,
    label: l10n.navMe,
  ),
};

class QyicBottomNav extends StatelessWidget {
  const QyicBottomNav({
    super.key,
    required this.current,
    required this.onChanged,
  });

  final QyicTab current;
  final ValueChanged<QyicTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: QyicColors.border)),
      ),
      child: NavigationBar(
        height: 72,
        backgroundColor: QyicColors.background,
        indicatorColor: Colors.transparent,
        selectedIndex: current.index,
        onDestinationSelected: (index) => onChanged(QyicTab.values[index]),
        destinations: [
          for (final tab in QyicTab.values)
            if (qyicTabLook(l10n, tab) case final look)
              NavigationDestination(
                icon: Icon(look.icon),
                selectedIcon: Icon(look.selected, color: QyicColors.lime),
                label: look.label,
              ),
        ],
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
    );
  }
}

/// Side navigation for wide windows (tablets, desktop, web).
class QyicNavRail extends StatelessWidget {
  const QyicNavRail({
    super.key,
    required this.current,
    required this.onChanged,
  });

  final QyicTab current;
  final ValueChanged<QyicTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: QyicColors.border)),
      ),
      child: NavigationRail(
        backgroundColor: QyicColors.background,
        selectedIndex: current.index,
        onDestinationSelected: (index) => onChanged(QyicTab.values[index]),
        labelType: NavigationRailLabelType.all,
        indicatorColor: QyicColors.lime,
        selectedIconTheme: const IconThemeData(color: QyicColors.limeDark),
        selectedLabelTextStyle: const TextStyle(
          color: QyicColors.lime,
          fontWeight: FontWeight.w700,
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: QyicColors.lime,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Q',
              style: TextStyle(
                color: QyicColors.limeDark,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
        ),
        destinations: [
          for (final tab in QyicTab.values)
            if (qyicTabLook(l10n, tab) case final look)
              NavigationRailDestination(
                icon: Icon(look.icon),
                selectedIcon: Icon(look.selected),
                label: Text(look.label),
              ),
        ],
      ),
    );
  }
}
