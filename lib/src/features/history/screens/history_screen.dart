import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:delivery_app/src/core/localization/locale_keys.g.dart';
import 'package:delivery_app/src/core/widgets/app_bar_widget.dart';
import 'package:delivery_app/src/features/history/model/history_model.dart';
import 'package:delivery_app/src/features/history/widgets/history_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
          ? const Color(0xffEEEDF3)
          : const Color(0xff0F1115),
      appBar: CustomAppBar(
        title: LocaleKeys.history.tr(),
        isDark: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
        isLeading: true,
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 6),
                  hintText: LocaleKeys.search_orders_hint.tr(),
                  hintStyle: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color:
                        AdaptiveTheme.of(context).mode ==
                            AdaptiveThemeMode.light
                        ? Color(0xff717786)
                        : Colors.white70,
                  ),
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    size: 24,
                    color:
                        AdaptiveTheme.of(context).mode ==
                            AdaptiveThemeMode.light
                        ? Color(0xff717786)
                        : Colors.white70,
                  ),
                  filled: true,
                  fillColor:
                      AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                      ? Colors.grey.shade300
                      : Colors.grey.shade600,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                LocaleKeys.recent_deliveries.tr(),
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: deliveries.length,
                  itemBuilder: (context, index) {
                    return DeliveryCard(delivery: deliveries[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
