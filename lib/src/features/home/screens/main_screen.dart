import 'package:delivery_app/src/features/history/screens/history_screen.dart';
import 'package:delivery_app/src/features/home/screens/home_screen.dart';
import 'package:delivery_app/src/features/settings/screens/settings_screen.dart';
import 'package:delivery_app/src/features/settings/widgets/bottom_bar_widgets.dart';
import 'package:delivery_app/src/core/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    const HistoryScreen(),
    Scaffold(body: Center(child: Text(LocaleKeys.profile_placeholder.tr()))),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: IndexedStack(index: currentIndex, children: pages),

      bottomNavigationBar: GlassBottomBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
