import 'dart:async';

import 'package:chat_app_supabase/core/supabase_services/supabase_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

class CreateUser extends ConsumerStatefulWidget {
  const CreateUser({
    super.key,
    required this.phoneNumber,
    required this.name,
    required this.email,
  });

  final String phoneNumber;
  final String name;
  final String email;

  @override
  ConsumerState<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends ConsumerState<CreateUser> {
  late final StreamSubscription<AuthState> _authStateSubscription;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    print('Verify User');
    print('Phone Number: ${widget.phoneNumber}');
    print('Name: ${widget.name}');
    print('Email: ${widget.email}');

    _authStateSubscription = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;

      if (session != null && mounted) {
        // createUserInDatabase();
        print("VERIFIED SUCCESSFULLY");
      }
    });

    handleLogin();
  }

  Future<void> handleLogin() async {
    try {
      final email = widget.email.trim();
      await supabase.auth.signInWithOtp(
        email: email,
        emailRedirectTo: "io.supabase.flutterquickstart://login-callback/",
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Check Your inbox for the OTP"),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } on AuthException catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error : $error'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('Phone Number: ${widget.phoneNumber}');
    // print('Name: ${widget.name}');
    // print('Email: ${widget.email}');
    return Scaffold(
      appBar: AppBar(title: const Text('Create User')),
      body: const Center(child: Text('Create User')),
    );
  }
}
