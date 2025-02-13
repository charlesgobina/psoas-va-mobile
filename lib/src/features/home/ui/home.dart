import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psoas_va_mobile/main.dart';
import 'package:psoas_va_mobile/src/features/authentication/ui/providers/auth_states.dart';

import '../../authentication/services/auth_service.dart';
import '../../authentication/ui/providers/auth_provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
          
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                authService.currentUser != null
                    ? Text((authService.currentUser!.displayName ?? 'User'))
                    : const SizedBox.shrink(),
                const SizedBox(height: 10),
                const Center(
                  child: Text('You have pushed the button this many times:'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    await authProvider.signOut();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const AuthWrapper()));
                  },
                  child: const Text('Sign Out'),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed logic here
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
