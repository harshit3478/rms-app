import 'package:rmsnewmodule/screens/constant_pages/account.dart';
import 'package:rmsnewmodule/screens/constant_pages/blog.dart';
import 'package:rmsnewmodule/screens/files.dart';
import 'package:rmsnewmodule/screens/home.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentTab = 0;
  final PageStorageBucket _bucket = PageStorageBucket();

  final List<_NavItem> _items = const [
    _NavItem(icon: CupertinoIcons.home, label: 'Home'),
    _NavItem(icon: Icons.dashboard_outlined, label: 'Data'),
    _NavItem(icon: Icons.book_outlined, label: 'Blog'),
    _NavItem(icon: CupertinoIcons.person_circle, label: 'Account'),
  ];

  late final List<Widget> _screens = [
    Home(),
    Files(),
    Blog(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: PageStorage(
          bucket: _bucket,
          child: _screens[_currentTab],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
            border: Border(top: BorderSide(color: AppColors.divider)),
          ),
          child: SafeArea(
            top: false,
            child: SizedBox(
              height: 60,
              child: Row(
                children: List.generate(_items.length, (i) {
                  final active = _currentTab == i;
                  return Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _currentTab = i),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _items[i].icon,
                            size: 22,
                            color: active ? AppColors.primary : AppColors.textHint,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            _items[i].label,
                            style: AppTextStyles.navLabel.copyWith(
                              color: active ? AppColors.primary : AppColors.textHint,
                              fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}
