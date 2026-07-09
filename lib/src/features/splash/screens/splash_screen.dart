import 'package:delivery_app/src/core/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white54, width: 1),
                borderRadius: BorderRadius.circular(32),
                gradient: LinearGradient(
                  colors: [Color(0XFFD8E2FF), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff0058BC).withOpacity(0.2),
                    blurRadius: 32,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: SvgPicture.asset(
                'assets/icons/logo.svg',
                width: 50,
                height: 50,
              ),
            ),
            SizedBox(height: 20),
            Text(
              LocaleKeys.app_name.tr(),
              style: GoogleFonts.inter(
                fontSize: 34,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Spacer(),
            Text(
              LocaleKeys.app_tagline.tr(),
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff414755),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
