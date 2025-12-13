import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:complaints_sys/core/constants/app_themes.dart';
import 'package:complaints_sys/core/routing/router_service.dart';
import 'package:complaints_sys/core/di/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:complaints_sys/core/services/notification_service.dart';

final RouterService _routerService = RouterService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize Notification Service (FCM)
  // We will initialize it in MyApp using the DI instance to ensure dependencies are resolved.

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Injector.setupProviders(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          // Initialize Notification Service
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<NotificationService>().initialize();
          });

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Government Complaints',
            locale: const Locale('ar'),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('ar')],
            theme: AppThemes.themeArabic,
            routerConfig: _routerService.router,
          );
        },
      ),
    );
  }
}
