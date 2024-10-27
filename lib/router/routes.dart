import 'package:chat_app_supabase/features/auth/views/auth_screen.dart';
import 'package:chat_app_supabase/features/auth/views/create_user.dart';
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
          routes: [
            GoRoute(
              path: '/create-user',
              builder: (BuildContext context, GoRouterState state) {
                // Extract parameters from state.extra
                final Map<String, dynamic> params =
                    state.extra as Map<String, dynamic>;
                return CreateUser(
                  phoneNumber: params['phoneNumber'] as String,
                  name: params['name'] as String,
                  email: params['email'] as String,
                );
              },
            ),
          ],
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
