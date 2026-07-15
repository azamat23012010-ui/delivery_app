import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:delivery_app/src/core/localization/locale_keys.g.dart';
import 'package:delivery_app/src/features/history/model/history_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BadgeColorScheme {
  final Color background;
  final Color text;
  final IconData icon;

  const BadgeColorScheme({
    required this.background,
    required this.text,
    required this.icon,
  });
}

class DeliveryCard extends StatelessWidget {
  final HistoryModel delivery;

  const DeliveryCard({super.key, required this.delivery});

  BadgeColorScheme _getBadgeColorScheme(String status) {
    switch (status.toLowerCase()) {
      case 'in transit':
        return BadgeColorScheme(
          background: Colors.orange.shade100,
          text: Colors.orange.shade900,
          icon: Icons.local_shipping,
        );
      case 'delivered':
        return BadgeColorScheme(
          background: Colors.green.shade100,
          text: Colors.green.shade900,
          icon: Icons.all_inbox_sharp,
        );
      case 'cancelled':
        return BadgeColorScheme(
          background: Colors.red.shade100,
          text: Colors.red.shade900,
          icon: Icons.cancel,
        );
      default:
        return BadgeColorScheme(
          background: Colors.grey.shade200,
          text: Colors.grey.shade700,
          icon: Icons.inventory,
        );
    }
  }

  String _formatCreatedAt(String dateStr) {
    if (dateStr.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(dateStr).toLocal();
      return DateFormat('MMM dd, yyyy - hh:mm a').format(dateTime);
    } catch (_) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = _getBadgeColorScheme(delivery.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
            ? Colors.white
            : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
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
                  color: colorScheme.background,
                  shape: BoxShape.circle,
                ),
                child: Icon(colorScheme.icon, color: colorScheme.text),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.order_number.tr(args: [delivery.id]),
                      style: GoogleFonts.workSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatCreatedAt(delivery.createdAt),
                      style: GoogleFonts.workSans(
                        color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                            ? Colors.grey.shade600
                            : Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: colorScheme.background,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  delivery.status,
                  style: GoogleFonts.workSans(
                    color: colorScheme.text,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.from.tr(),
                      style: TextStyle(
                        color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                            ? Colors.grey.shade600
                            : Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
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
                        color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                            ? Colors.grey.shade600
                            : Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
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
