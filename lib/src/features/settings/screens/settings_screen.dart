import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:delivery_app/src/core/localization/locale_keys.g.dart';
import 'package:delivery_app/src/core/widgets/app_bar_widget.dart';
import 'package:delivery_app/src/features/settings/model/settings_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;
    String currentLanguage;

    switch (locale) {
      case 'uz':
        currentLanguage = LocaleKeys.language_uz.tr();
        break;
      case 'ru':
        currentLanguage = LocaleKeys.language_ru.tr();
        break;
      default:
        currentLanguage = LocaleKeys.language_en.tr();
    }
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
          ? const Color(0xffEEEDF3)
          : const Color(0xff0F1115),
      appBar: CustomAppBar(
        title: LocaleKeys.app_name.tr(),
        isLeading: true,
        isDark: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1695927621677-ec96e048dce2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZSUyMHBpY3R1cmUlMjBwZXJzb258ZW58MHx8MHx8fDA%3D",
            ),
          ),
          SizedBox(width: 5),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.settings.tr(),
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 34,
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: settingsSections.length,
                itemBuilder: (context, sectionIndex) {
                  final section = settingsSections[sectionIndex];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          bottom: 4,
                          top: 16,
                        ),
                        child: Text(
                          section.title.tr().toUpperCase(),
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color:
                                AdaptiveTheme.of(context).mode ==
                                    AdaptiveThemeMode.light
                                ? const Color(0xff414755)
                                : const Color(0xff8E96A8),
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color:
                              AdaptiveTheme.of(context).mode ==
                                  AdaptiveThemeMode.light
                              ? Colors.white
                              : const Color(0xff1A1D23),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow:
                              AdaptiveTheme.of(context).mode ==
                                  AdaptiveThemeMode.light
                              ? const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: Column(
                          children: List.generate(section.items.length, (
                            index,
                          ) {
                            final item = section.items[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  if (item.hasLanguage) {
                                    _showLanguagePicker();
                                  } else {
                                    item.onTap;
                                  }
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: item.backgroundColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        item.icon,
                                        color: item.iconColor,
                                      ),
                                    ),

                                    const SizedBox(width: 16),

                                    Expanded(
                                      child: Text(
                                        item.title.tr(),
                                        style: GoogleFonts.inter(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),

                                    if (item.hasLanguage)
                                      Text(
                                        currentLanguage,
                                        style: GoogleFonts.inter(
                                          color:
                                              AdaptiveTheme.of(context).mode ==
                                                  AdaptiveThemeMode.light
                                              ? const Color(0xff414755)
                                              : const Color(0xffA5ACB8),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),

                                    if (item.hasSwitch)
                                      CupertinoSwitch(
                                        value:
                                            AdaptiveTheme.of(context).mode ==
                                            AdaptiveThemeMode.dark,
                                        onChanged: (value) {
                                          if (value) {
                                            AdaptiveTheme.of(context).setDark();
                                          } else {
                                            AdaptiveTheme.of(
                                              context,
                                            ).setLight();
                                          }
                                        },
                                      ),

                                    if (item.hasArrow)
                                      Icon(
                                        Icons.chevron_right,
                                        color:
                                            AdaptiveTheme.of(context).mode ==
                                                AdaptiveThemeMode.light
                                            ? const Color(0xffC1C6D7)
                                            : const Color(0xff6E7582),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  );
                },
              ),

              // Log Out
              GestureDetector(
                onTap: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                      title: const Icon(
                        CupertinoIcons.square_arrow_right,
                        color: CupertinoColors.systemRed,
                        size: 40,
                      ),
                      content: Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Text(
                          LocaleKeys.logout_message.tr(),
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      actions: [
                        CupertinoDialogAction(
                          child: Text(
                            LocaleKeys.stay.tr(),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          child: Text(
                            LocaleKeys.logout.tr(),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            // signOut()
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:
                        AdaptiveTheme.of(context).mode ==
                            AdaptiveThemeMode.light
                        ? Colors.white
                        : const Color(0xff1A1D23),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow:
                        AdaptiveTheme.of(context).mode ==
                            AdaptiveThemeMode.light
                        ? const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Text(
                    LocaleKeys.logout.tr(),
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: CupertinoColors.systemRed,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 110),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguagePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        child: CupertinoActionSheet(
          title: Text(
            LocaleKeys.choose_language.tr(),
            style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async {
                await context.setLocale(const Locale('uz'));
                if (mounted) Navigator.pop(context);
              },
              child: Text(
                LocaleKeys.language_uz.tr(),
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                await context.setLocale(const Locale('en'));
                if (mounted) Navigator.pop(context);
              },
              child: Text(
                LocaleKeys.language_en.tr(),
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                await context.setLocale(const Locale('ru'));
                if (mounted) Navigator.pop(context);
              },
              child: Text(
                LocaleKeys.language_ru.tr(),
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context),
            child: Text(
              LocaleKeys.cancel.tr(),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: CupertinoColors.systemRed,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
