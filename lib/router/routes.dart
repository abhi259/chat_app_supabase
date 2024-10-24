
import 'package:chat_app_supabase/pages/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter mainRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
     
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
