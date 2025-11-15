import 'package:animations/animations.dart';
import 'package:complaints_sys/core/constants/app_routes.dart';
import 'package:complaints_sys/features/auth/presentation/screens/login_screen.dart';
import 'package:complaints_sys/features/auth/presentation/screens/register_screen.dart';
import 'package:complaints_sys/features/auth/presentation/screens/splash_screen.dart';
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
    ],
  );
}
