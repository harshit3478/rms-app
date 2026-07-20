import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rmsnewmodule/screens/constant_pages/splash.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/translations/codegen_loader.g.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initializeDateFormatting('pt_BR');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en'), Locale('ar')],
      fallbackLocale: const Locale('en'),
      assetLoader: CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RMS Dental',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.light,
      home: SplashScreen(),
    );
  }
}
