import 'dart:math';

import 'package:flutter/material.dart';
import 'package:psoas_va_mobile/src/features/authentication/services/auth_service.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          // Profile section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  backgroundImage:
                      user?.photoURL != null && user!.photoURL!.isNotEmpty
                          ? NetworkImage(user.photoURL!)
                          : null,
                  child: user?.photoURL == null || user!.photoURL!.isEmpty
                      ? Text(
                          user?.displayName != null &&
                                  user!.displayName!.isNotEmpty
                              ? user.displayName!
                                  .substring(
                                      0, min(2, user.displayName!.length))
                                  .toUpperCase()
                              : '??',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${AuthService().currentUser!.displayName!.split(' ')[0]} ${AuthService().currentUser!.displayName!.split(' ')[1]}",
                        style: Theme.of(context).textTheme.titleLarge),
                    Text("${AuthService().currentUser!.email}",
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Account Settings
          _buildSettingsCategory(context, 'Account', [
            _buildSettingsTile(
                context, Icons.person_outline, 'Personal Information', () {}),
            _buildSettingsTile(context, Icons.security, 'Security', () {}),
          ]),

          // App Settings
          _buildSettingsCategory(context, 'App Settings', [
            _buildSettingsTile(
                context, Icons.notifications_outlined, 'Notifications', () {}),
            _buildSettingsTile(
                context, Icons.dark_mode_outlined, 'Appearance', () {}),
            _buildSettingsTile(
                context, Icons.language_outlined, 'Language', () {}),
          ]),

          // Support
          _buildSettingsCategory(context, 'Support', [
            _buildSettingsTile(
                context, Icons.help_outline, 'Help Center', () {}),
            _buildSettingsTile(context, Icons.info_outline, 'About', () {}),
          ]),

          // Logout section
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                foregroundColor: Colors.red.shade800,
              ),
              child: const Text('Log out'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCategory(
      BuildContext context, String title, List<Widget> tiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Column(children: tiles),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSettingsTile(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
