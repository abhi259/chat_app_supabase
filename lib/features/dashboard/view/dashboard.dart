import 'package:chat_app_supabase/core/supabase_services/supabase_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  dynamic sessionData;

  @override
  void initState() {
    super.initState();
    final session = supabase.auth.currentSession;
    if (session != null) {
      setState(() {
        sessionData = session.user?.email ?? 'No email';
      });
    }
  }

  Future<void> handleLogout() async {
    await supabase.auth.signOut();
    if (mounted) {
      context.go("/");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(sessionData ?? 'No session')),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: handleLogout,
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
