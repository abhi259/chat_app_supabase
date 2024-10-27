import 'package:chat_app_supabase/core/supabase_services/supabase_client.dart';
// import 'package:chat_app_supabase/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  ///  Constructs a [HomeScreen]
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Future<void> getData() async {
    try {
      final data = await supabase.from('messages').select("*");
      print("Conversations data: $data");
    } catch (error) {
      // print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () => context.go('/details'),
                child: const Text('Go to the Details screen'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => context.go('/auth-screen'),
                child: const Text('Go to the Auth screen'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: getData,
                child: const Text('Get Data'),
              ),
            ),
            // ElevatedButton(onPressed: ()async{
            // await supabase.from('users').select('*');
            // }, child: child)
          ],
        ),
      ),
    );
  }
}
