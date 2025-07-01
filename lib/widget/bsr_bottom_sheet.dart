import 'package:flutter/material.dart';
import 'package:notes_app/route_config/route_config.dart';
import 'package:notes_app/widget/primary_button.dart';

Future<void> logOutSheet({
  required BuildContext context,
  required Function() onLogOut,
}) async {
  await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.logout, size: 50, color: Colors.blue),
            const SizedBox(height: 16),
            const Text(
              'Do you want to log out?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Logging out will remove your account from this device.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    onPressed: () => router.pop(),
                    text: 'Cancel',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    gradientColors: const [Colors.red, Colors.redAccent],
                    onPressed: () {
                      onLogOut();
                      router.pop();
                    },
                    text: 'Log Out',
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}

Future<void> deleteAccountSheet({
  required BuildContext context,
  required Function() onDelete,
}) async {
  await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.logout, size: 50, color: Colors.blue),
            const SizedBox(height: 16),
            const Text(
              'Do you want to delete your account?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Deleting your account will remove all your data from our servers.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    onPressed: () => router.pop(),
                    text: 'Cancel',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    gradientColors: const [Colors.red, Colors.redAccent],
                    onPressed: () {
                      onDelete();
                      router.pop();
                    },
                    text: 'Confirm',
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
