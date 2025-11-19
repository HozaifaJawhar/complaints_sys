import 'package:complaints_sys/features/auth/presentation/screens/splash_screen.dart';
import 'package:complaints_sys/features/complaints/presentation/screens/comlaint_details_screen.dart';
import 'package:complaints_sys/features/complaints/presentation/screens/complaints_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animations/animations.dart';
import 'package:complaints_sys/core/constants/app_routes.dart';
import 'package:complaints_sys/features/auth/presentation/screens/login_screen.dart';
import 'package:complaints_sys/features/auth/presentation/screens/register_screen.dart';
import 'package:complaints_sys/features/auth/presentation/screens/otp_screen.dart';
import 'package:complaints_sys/features/main_shell/presentation/screens/main_shell_screen.dart';
import 'package:complaints_sys/features/home/presentation/screens/home_screen.dart';
import 'package:complaints_sys/features/complaints/presentation/screens/add_complaint_screen.dart';
import 'package:complaints_sys/features/profile/presentation/screens/profile_screen.dart';
import 'package:complaints_sys/features/notifications/presentation/screens/notifications_screen.dart';

class RouterService {
  final GoRouter router = GoRouter(
    initialLocation: AppRoutes.mainScreen,
    routes: [
      GoRoute(
        path: AppRoutes.mainScreen,
        pageBuilder: (context, state) =>
            _buildPage(state, const SplashScreen()),
      ),
      GoRoute(
        path: AppRoutes.loginScreen,
        pageBuilder: (context, state) => _buildPage(state, const LoginScreen()),
      ),
      GoRoute(
        path: AppRoutes.registerScreen,
        pageBuilder: (context, state) =>
            _buildPage(state, const RegisterScreen()),
      ),
      GoRoute(
        path: AppRoutes.otpScreen,
        pageBuilder: (context, state) {
          final email = state.extra as String? ?? '';
          return _buildPage(state, OTPScreen(email: email));
        },
      ),
      GoRoute(
        path: AppRoutes.complaintDetailsScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ComlaintDetailsScreen(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.homeScreen,
                pageBuilder: (context, state) =>
                    _buildPage(state, const HomeScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.complaintsListScreen,
                pageBuilder: (context, state) =>
                    _buildPage(state, ComplaintsListScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.addComplaintScreen,
                pageBuilder: (context, state) =>
                    _buildPage(state, const AddComplaintScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profileScreen,
                pageBuilder: (context, state) =>
                    _buildPage(state, const ProfileScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.notificationsScreen,
                pageBuilder: (context, state) =>
                    _buildPage(state, const NotificationsScreen()),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static Page<dynamic> _buildPage(GoRouterState state, Widget child) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        );
      },
    );
  }
}
