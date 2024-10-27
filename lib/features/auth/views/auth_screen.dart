import 'dart:async';

import 'package:chat_app_supabase/core/supabase_services/supabase_client.dart';
import 'package:chat_app_supabase/features/auth/widgets/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool isExistingUser = false;
  late final StreamSubscription<AuthState> _authStateSubscription;
  final TextEditingController _emailController = TextEditingController();
  final PageController _pageController = PageController(initialPage: 0);
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;

      if (session != null && mounted) {
        // createUserInDatabase();
        context.go("/dashboard");
      }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  void _goToPage(int page) {
    setState(() {
      isExistingUser = page == 1;
    });
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
    if (isExistingUser) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  //TODO: check for user in database
  //TODO: if user found, redirect to dashboard
  //TODO: if user not found, redirect to user creation flow and then dashboard

  // Future<void> createUserInDatabase() async {
  //   await supabase.from("users").insert([{
  //     "email_id": _emailController.text.trim(),
  //     "phone_number": "8197710760",
  //   },]).select();
  // }

  Future<void> handleLogin() async {
    try {
      final email = _emailController.text.trim();
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
    _emailController.dispose();
    _authStateSubscription.cancel();
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth Screen')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              _animatedContainer(),
              const SizedBox(height: 24.0),
              SizedBox(
                height: 400,
                child: PageView(
                  controller: _pageController,
                  children: const [
                    SignUpPage(),
                    Center(
                      child: Text('Login'),
                    ),
                  ],
                  onPageChanged: (index) {
                    setState(() => isExistingUser = index == 1);
                    if (isExistingUser) {
                      _animationController.forward();
                    } else {
                      _animationController.reverse();
                    }
                  },
                ),
              ),
              // TextField(
              //   controller: _emailController,
              //   keyboardType: TextInputType.emailAddress,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(100),
              //     ),
              //     labelText: 'Email ID',
              //     hintText: 'Enter your Email ID',
              //   ),
              // ),
              // ElevatedButton(
              //   onPressed: handleLogin,
              //   child: Text(isExistingUser ? "Login" : "Sign Up"),
              // )
            ],
          ),
        ],
      ),
    );
  }

  AnimatedBuilder _animatedContainer() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        const double containerWidth = 300;
        const double containerHeight = 50;
        const double padding = 4;
        const double buttonWidth = (containerWidth - 2 * padding) / 2;

        return Container(
          width: containerWidth,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(horizontal: padding, vertical: 4),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 19, 27, 29),
            borderRadius: BorderRadius.circular(containerHeight / 2),
          ),
          child: Stack(
            children: [
              Positioned(
                left: _animation.value * buttonWidth,
                child: Container(
                  width: buttonWidth,
                  height: containerHeight - 8, // Adjust for vertical padding
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 18, 52, 59),
                    borderRadius:
                        BorderRadius.circular((containerHeight - 8) / 2),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                        surfaceTintColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        overlayColor: Colors.transparent,
                      ),
                      onPressed: () {
                        setState(() => isExistingUser = false);
                        _goToPage(0);
                      },
                      child: Text('Sign Up',
                          style: TextStyle(
                            color: _animation.value < 0.5
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey.shade300,
                          )),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                        surfaceTintColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        overlayColor: Colors.transparent,
                      ),
                      onPressed: () {
                        setState(() => isExistingUser = true);
                        _goToPage(1);
                      },
                      child: Text('Login',
                          style: TextStyle(
                            color: _animation.value > 0.5
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey.shade300,
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
