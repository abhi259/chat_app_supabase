import 'package:chat_app_supabase/features/auth/views/auth_screen.dart';
import 'package:chat_app_supabase/features/dashboard/view/dashboard.dart';
import 'package:chat_app_supabase/features/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter mainRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingScreen();
      },
      routes: [
        GoRoute(
          path: '/auth-screen',
          builder: (BuildContext context, GoRouterState state) {
            return const AuthScreen();
          },
        ),
        GoRoute(
          path: '/dashboard',
          builder: (BuildContext context, GoRouterState state) {
            return const DashboardScreen();
          },
        ),
      ],
    ),
  ],

  ///auth guard
  // redirect: (BuildContext context, GoRouterState state) async {
  //   final bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
  //   final bool isAuthRoute = state.matchedLocation.startsWith('/auth-screen');
  //   if (!isLoggedIn) {
  //     return isAuthRoute ? null : '/auth-screen';
  //   }
  //   return isAuthRoute ? '/' : null;
  // },
);
