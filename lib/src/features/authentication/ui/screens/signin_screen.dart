import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psoas_va_mobile/src/features/authentication/ui/providers/auth_states.dart';

import '../providers/auth_provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (authProvider.authState is AuthLoading)
              const CircularProgressIndicator(),
            if (authProvider.authState is AuthFailure)
              Text((authProvider.authState as AuthFailure).message),
            ElevatedButton(
              onPressed: authProvider.authState is AuthLoading
                  ? null
                  : () async {
                      await authProvider.signInWithGoogle();
                    },
              child: const Text('Sign In with Google'),
            ),
          ],
        ),
      ),
    );
  }
}