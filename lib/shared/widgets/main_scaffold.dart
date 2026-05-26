import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/colors.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<_NavItem> _navItems = const [
    _NavItem(icon: Icons.home_rounded, label: 'Home', route: '/home'),
    _NavItem(icon: Icons.child_friendly_rounded, label: 'Baby', route: '/baby'),
    _NavItem(icon: Icons.favorite_rounded, label: 'Health', route: '/health'),
    _NavItem(icon: Icons.restaurant_menu_rounded, label: 'Nutrition', route: '/nutrition'),
    _NavItem(icon: Icons.self_improvement_rounded, label: 'Yoga', route: '/yoga'),
    _NavItem(icon: Icons.notifications_rounded, label: 'Reminders', route: '/reminders'),
    _NavItem(icon: Icons.spa_rounded, label: 'Self Care', route: '/emotional'),
    _NavItem(icon: Icons.person_rounded, label: 'Profile', route: '/profile'),
  ];

  // Show only 5 primary items in bottom nav; others accessible via "More"
  final List<int> _primaryIndices = [0, 1, 2, 3, 6, 7]; // Home, Baby, Health, Nutrition, Self Care, Profile

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    _currentIndex = _navItems.indexWhere((item) => item.route == location);
    if (_currentIndex < 0) _currentIndex = 0;

    // Map to bottom nav index
    final displayItems = [
      _navItems[0], // Home
      _navItems[1], // Baby
      _navItems[2], // Health
      _navItems[3], // Nutrition
      _navItems[6], // Self Care
      _navItems[7], // Profile
    ];

    int bottomIndex = displayItems.indexWhere((d) => d.route == location);
    if (bottomIndex < 0) bottomIndex = 0;

    return Scaffold(
      body: widget.child,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/yoga'),
        backgroundColor: NitaraColors.pink,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.self_improvement_rounded, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _NitaraBottomNav(
        items: displayItems,
        currentIndex: bottomIndex,
        onTap: (i) => context.go(displayItems[i].route),
      ),
    );
  }
}

class _NitaraBottomNav extends StatelessWidget {
  final List<_NavItem> items;
  final int currentIndex;
  final void Function(int) onTap;

  const _NitaraBottomNav({
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: isDark ? NitaraColors.surfaceDark : Colors.white,
        boxShadow: [
          BoxShadow(
            color: NitaraColors.pink.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: items.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          final isSelected = i == currentIndex;

          // Leave space for FAB in center
          if (i == 2) {
            return Expanded(
              child: Row(
                children: [
                  Expanded(child: _NavItemWidget(item: item, isSelected: isSelected, onTap: () => onTap(i))),
                  const SizedBox(width: 56), // FAB gap
                  Expanded(child: _NavItemWidget(item: items[3], isSelected: currentIndex == 3, onTap: () => onTap(3))),
                ],
              ),
            );
          }
          if (i == 3) return const SizedBox.shrink();

          return Expanded(
            child: _NavItemWidget(item: item, isSelected: isSelected, onTap: () => onTap(i)),
          );
        }).toList(),
      ),
    );
  }
}

class _NavItemWidget extends StatelessWidget {
  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItemWidget({required this.item, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected ? NitaraColors.pinkPastel : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                item.icon,
                color: isSelected ? NitaraColors.pink : NitaraColors.textLight,
                size: isSelected ? 22 : 20,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.label,
              style: GoogleFonts.nunito(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? NitaraColors.pink : NitaraColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String route;
  const _NavItem({required this.icon, required this.label, required this.route});
}
