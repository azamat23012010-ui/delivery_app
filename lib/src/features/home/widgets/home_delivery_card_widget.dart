import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:delivery_app/src/core/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeDeliveryCard extends StatelessWidget {
  const HomeDeliveryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 16),
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
            ? Colors.white
            : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              color: Colors.grey.shade500,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(radius: 5, backgroundColor: Colors.green),
              SizedBox(width: 10),
              Text(
                LocaleKeys.current_delivery.tr(),
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color:
                      AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                      ? Color(0xff414755)
                      : Colors.grey,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  color: Color(0xff0070EB).withAlpha(35),
                ),
                child: Text(
                  LocaleKeys.tracking_code.tr(),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xff0070EB),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          ListTile(
            title: Text(
              LocaleKeys.arriving_in.tr(),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            subtitle: Text(
              LocaleKeys.dropoff_by.tr(),
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                    ? Color(0xff717786)
                    : Colors.white70,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  LocaleKeys.distance.tr(),
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color:
                        AdaptiveTheme.of(context).mode ==
                            AdaptiveThemeMode.light
                        ? Color(0xff717786)
                        : Colors.white70,
                  ),
                ),
                Text(
                  '2.4 mi',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 21,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            height: 8,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              color: Color(0xffE3E2E7),
            ),
            child: Container(
              margin: EdgeInsets.only(
                right: MediaQuery.sizeOf(context).width * 0.2,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                color: Color(0xff0058BC),
              ),
            ),
          ),
          Spacer(),
          Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                  ? Color(0xffF4F3F8)
                  : Colors.black26,
              border: Border.all(color: Colors.grey.shade400, width: 0.7),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xffD8E2FF),
                  child: Icon(Icons.person, color: Colors.black),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.driver_name.tr(),
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Row(
                        children: [
                          const Icon(Icons.star, size: 12),

                          const SizedBox(width: 4),

                          Text(
                            LocaleKeys.driver_rating.tr(),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color:
                                  AdaptiveTheme.of(context).mode ==
                                      AdaptiveThemeMode.light
                                  ? const Color(0xff717786)
                                  : Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xffE3E2E7),
                  child: Icon(Icons.chat_outlined, color: Colors.black),
                ),

                const SizedBox(width: 8),

                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xff006E28),
                  child: Icon(Icons.call, color: Colors.white),
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
