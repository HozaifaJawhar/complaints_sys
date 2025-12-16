import 'package:complaints_sys/core/constants/app_themes.dart';
import 'package:complaints_sys/core/routing/router_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:complaints_sys/core/di/injection_container.dart';
import 'package:complaints_sys/core/services/notification_service.dart';
import 'package:complaints_sys/core/services/notification_storage_service.dart';
import 'package:complaints_sys/features/notifications/data/models/notification_item_adapter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

final RouterService _routerService = RouterService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(NotificationItemAdapter());

  // Initialize Storage Service
  final storageService = NotificationStorageService();
  await storageService.init();

  // Initialize Notification Service
  final notificationService = NotificationService(storageService);
  await notificationService.initialize();

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
