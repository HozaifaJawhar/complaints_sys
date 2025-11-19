import 'package:animations/animations.dart';
import 'package:complaints_sys/core/constants/app_routes.dart';
import 'package:complaints_sys/features/auth/presentation/screens/forgetpassword/forget_password_screen.dart';
import 'package:complaints_sys/features/auth/presentation/screens/forgetpassword/otp_password_screen.dart';
import 'package:complaints_sys/features/auth/presentation/screens/forgetpassword/reset_passowrd_screen.dart';
import 'package:complaints_sys/features/complaints/presentation/screens/comlaint_details_screen.dart';
import 'package:complaints_sys/features/complaints/presentation/screens/create_complaint_screen.dart';
import 'package:complaints_sys/features/complaints/presentation/screens/home_page_screen.dart';
import 'package:complaints_sys/features/auth/presentation/screens/login_screen.dart';
import 'package:complaints_sys/features/auth/presentation/screens/otp_screen.dart';
import 'package:complaints_sys/features/auth/presentation/screens/register_screen.dart';
import 'package:complaints_sys/features/auth/presentation/screens/splash_screen.dart';
import 'package:complaints_sys/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:go_router/go_router.dart';

class RouterService {
  final GoRouter router = GoRouter(
    initialLocation: AppRoutes.mainScreen,
    routes: [
      //-------------------------------------------
      // Splash Screen
      //-------------------------------------------
      GoRoute(
        path: AppRoutes.mainScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
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
      //-------------------------------------------
      // Login Screen
      //-------------------------------------------
      GoRoute(
        path: AppRoutes.loginScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginScreen(),
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
      //-------------------------------------------
      // Register Screen
      //-------------------------------------------
      GoRoute(
        path: AppRoutes.registerScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const RegisterScreen(),
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
      //-------------------------------------------
      // OTP Screen
      //-------------------------------------------
      GoRoute(
        path: AppRoutes.otpScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OtpScreen(),
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
      //-------------------------------------------
      // Home Screen
      //-------------------------------------------
      GoRoute(
        path: AppRoutes.homePageScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HomePage(),
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
      //-------------------------------------------
      // ResetPassword Screen
      //-------------------------------------------
      GoRoute(
        path: AppRoutes.resetPasswordScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ResetPasswordscreen(),
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
      //-------------------------------------------
      // ForgetPassword Screen
      //-------------------------------------------
      GoRoute(
        path: AppRoutes.forgetPasswordScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ForgetPasswordScreen(),
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
      //-------------------------------------------
      //  OTP Password Screen
      //-------------------------------------------
      GoRoute(
        path: AppRoutes.otpPasswordScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OtpPasswordScreen(),
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
      //-------------------------------------------
      //  Create Complaint Screen
      //-------------------------------------------
      GoRoute(
        path: AppRoutes.createComplaintScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CreateComplaintScreen(),
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
      //-------------------------------------------
      //   Complaint Details Screen
      //-------------------------------------------
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
      //-------------------------------------------
      //   Notification Screen
      //-------------------------------------------
      GoRoute(
        path: AppRoutes.notificationScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const NotificationsScreen(),
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
    ],
  );
}
