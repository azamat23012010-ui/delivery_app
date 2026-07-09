import 'package:delivery_app/src/core/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';

class SettingsSection {
  final String title;
  final List<SettingsItem> items;

  const SettingsSection({
    required this.title,
    required this.items,
  });
}

class SettingsItem {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final VoidCallback onTap;

  final bool hasSwitch;
  final bool hasArrow;
  final bool hasLanguage;

  const SettingsItem({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.onTap,
    this.hasSwitch = false,
    this.hasArrow = true,
    this.hasLanguage = false,
  });
}


final List<SettingsSection> settingsSections = [
  SettingsSection(
    title: LocaleKeys.account,
    items: [
      SettingsItem(
        icon: Icons.person,
        iconColor: Colors.white,
        backgroundColor: Color(0xff0070EB),
        title: LocaleKeys.profile,
        onTap: () {},
      ),
      SettingsItem(
        icon: Icons.payment,
        iconColor: Color(0xff005BC1),
        backgroundColor: Color(0xff005BC1).withAlpha(20),
        title: LocaleKeys.payment_methods,
        onTap: () {},
      ),
    ],
  ),

  SettingsSection(
    title: LocaleKeys.notifications,
    items: [
      SettingsItem(
        icon: Icons.notifications_none,
        iconColor: Color(0xffBA1A1A),
        backgroundColor: Color(0xffBA1A1A).withAlpha(20),
        title: LocaleKeys.push_notifications,
        onTap: () {},
      ),
    ],
  ),

  SettingsSection(
    title: LocaleKeys.preferences,
    items: [
      SettingsItem(
        icon: Icons.language,
        iconColor: Color(0xff006E28),
        backgroundColor: Color(0xff006E28).withAlpha(20),
        title: LocaleKeys.language,
        hasLanguage: true,
        onTap: () {},
      ),
      SettingsItem(
        icon: Icons.dark_mode_outlined,
        iconColor:  Color(0xff1A1B1F),
        backgroundColor: Color(0xff1A1B1F).withAlpha(20),
        title: LocaleKeys.dark_mode,
        hasSwitch: true,
        hasArrow: false,
        onTap: () {},
      ),
    ],
  ),

  SettingsSection(
    title: LocaleKeys.support,
    items: [
      SettingsItem(
        icon: Icons.help_outline,
        iconColor: Color(0xff8A2BB9),
        backgroundColor: Color(0xff8A2BB9).withAlpha(20),
        title: LocaleKeys.help_center,
        onTap: () {},
      ),
    ],
  ),
];

