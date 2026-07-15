import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:delivery_app/src/core/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const HomeSearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 17),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
              ? Color(0xff717786)
              : Colors.white70,
        ),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: Icon(
                  Icons.clear,
                  color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                      ? Color(0xff717786)
                      : Colors.white70,
                ),
                onPressed: onClear,
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: const Color(0xff0070EB),
                  child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 22),
                ),
              ),

        filled: true,
        fillColor: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
            ? Colors.white
            : Colors.grey.shade700,
        hintText: LocaleKeys.tracking_number_or_address.tr(),
        hintStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          fontSize: 17,
          color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
              ? Color(0xff717786)
              : Colors.white70,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(99),
          borderSide: BorderSide(
            color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                ? Colors.white
                : const Color.fromARGB(255, 79, 77, 77),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(99),
          borderSide: BorderSide(
            color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                ? Colors.white
                : const Color.fromARGB(255, 79, 77, 77),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(99),
          borderSide: BorderSide(
            color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                ? Colors.white
                : const Color.fromARGB(255, 79, 77, 77),
          ),
        ),
      ),
    );
  }
}
