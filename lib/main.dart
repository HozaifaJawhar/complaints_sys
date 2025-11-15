import 'package:complaints_sys/app/theme/app_theme.dart';
import 'package:complaints_sys/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ComplaintsApp());
}

class ComplaintsApp extends StatelessWidget {
  const ComplaintsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}
