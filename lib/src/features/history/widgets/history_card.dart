import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:delivery_app/src/core/localization/locale_keys.g.dart';
import 'package:delivery_app/src/features/history/model/history_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryCard extends StatelessWidget {
  final DeliveryModel delivery;

  const DeliveryCard({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
            ? Colors.white
            : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: delivery.statusType == HistoryStatusType.yuklanmoqda
                      ? Color(0xffD8E2FF)
                      : delivery.statusType == HistoryStatusType.jonatilgan
                      ? Color(0xff6FFB85)
                      : Color(0xffE9E7ED),
                  shape: BoxShape.circle,
                ),
                child: delivery.statusType == HistoryStatusType.yuklanmoqda
                    ? Icon(Icons.local_shipping, color: Colors.black)
                    : delivery.statusType == HistoryStatusType.jonatilgan
                    ? Icon(Icons.all_inbox_sharp, color: Colors.black87)
                    : Icon(Icons.inventory, color: Colors.grey),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.order_number.tr(args: [delivery.orderId]),
                      style: GoogleFonts.workSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      delivery.date,
                      style: GoogleFonts.workSans(
                        color:
                            AdaptiveTheme.of(context).mode ==
                                AdaptiveThemeMode.light
                            ? Colors.grey.shade600
                            : Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: delivery.statusType == HistoryStatusType.yuklanmoqda
                      ? Colors.blue.shade100
                      : delivery.statusType == HistoryStatusType.jonatilgan
                      ? Colors.green.shade100
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  delivery.status,
                  style: GoogleFonts.workSans(
                    color: delivery.statusType == HistoryStatusType.yuklanmoqda
                        ? Color(0xff004493)
                        : delivery.statusType == HistoryStatusType.jonatilgan
                        ? Color(0xff00732A)
                        : Color(0xffE9E7ED),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.from.tr(),
                      style: TextStyle(
                        color:
                            AdaptiveTheme.of(context).mode ==
                                AdaptiveThemeMode.light
                            ? Colors.grey.shade600
                            : Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      delivery.from,
                      style: GoogleFonts.workSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      LocaleKeys.to.tr(),
                      style: GoogleFonts.workSans(
                        color:
                            AdaptiveTheme.of(context).mode ==
                                AdaptiveThemeMode.light
                            ? Colors.grey.shade600
                            : Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      delivery.to,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.workSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
