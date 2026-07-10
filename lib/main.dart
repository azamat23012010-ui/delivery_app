import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:delivery_app/src/core/localization/codegen_loader.g.dart';
import 'package:delivery_app/src/core/utils/app_theme.dart';
import 'package:delivery_app/src/features/home/presentation/screens/main_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('uz'),
        Locale('ru'),
      ],
      assetLoader: const CodegenLoader(),
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: DeliveryApp(
        savedThemeMode: savedThemeMode,
      ),
    ),
  );
}

class DeliveryApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const DeliveryApp({
    super.key,
    this.savedThemeMode,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.lightTheme,
      dark: AppTheme.darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: darkTheme,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,

          home: MainScreen(),
        );
      },
    );
  }
}