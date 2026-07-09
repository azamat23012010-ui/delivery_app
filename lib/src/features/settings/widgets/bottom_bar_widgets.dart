import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class GlassBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const GlassBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                  ? Colors.white.withOpacity(0.12)
                  : Colors.white.withOpacity(0.75),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black.withOpacity(0.08),
              ),
              boxShadow:
                  AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_items.length, (index) {
                final selected = currentIndex == index;

                return GestureDetector(
                  onTap: () => onTap(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.white.withOpacity(.18)
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _items[index],
                      color: selected
                          ? 
                               Color(0xff0070EB)
                          : (AdaptiveTheme.of(context).mode ==
                                    AdaptiveThemeMode.dark
                                ? Colors
                                      .white70 // Dark mode eski holati
                                : Colors.black54), // Light mode biroz to'qroq

                      size: selected ? 30 : 26,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

const List<IconData> _items = [
  Icons.home_rounded,
  Icons.history,
  Icons.person_rounded,
  Icons.settings,
];
