import 'package:flutter/material.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';

class AppSnack {
  AppSnack._();

  static void error(BuildContext context, String message) {
    _show(context, message, AppColors.error, Icons.error_outline);
  }

  static void success(BuildContext context, String message) {
    _show(context, message, AppColors.success, Icons.check_circle_outline);
  }

  static void info(BuildContext context, String message) {
    _show(context, message, AppColors.textSecondary, Icons.info_outline);
  }

  static void _show(
    BuildContext context,
    String message,
    Color color,
    IconData icon,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        duration: const Duration(seconds: 4),
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.bodySmall.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Cleans up raw Firebase error strings to something user-friendly.
String cleanFirebaseError(dynamic e) {
  final raw = e.toString();
  final noPrefix = raw.replaceAll('firebase_auth/', '').replaceAll('Firebase: ', '');
  final noCode = noPrefix.replaceAll(RegExp(r'\s?\([\w\-/]+\)\.?'), '');
  // Map common codes to friendly messages
  if (raw.contains('user-not-found') || raw.contains('wrong-password') || raw.contains('invalid-credential')) {
    return 'Incorrect email or password.';
  }
  if (raw.contains('email-already-in-use')) return 'This email is already registered.';
  if (raw.contains('weak-password')) return 'Password must be at least 6 characters.';
  if (raw.contains('network-request-failed')) return 'No internet connection. Please try again.';
  if (raw.contains('too-many-requests')) return 'Too many attempts. Please wait a moment.';
  return noCode.trim().isNotEmpty ? noCode.trim() : 'Something went wrong. Please try again.';
}
