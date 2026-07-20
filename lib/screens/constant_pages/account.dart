import 'package:rmsnewmodule/auth/loginpage.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/widgets/app_button.dart';
import 'package:rmsnewmodule/widgets/app_input.dart';
import 'package:rmsnewmodule/widgets/app_snack.dart';
import 'package:rmsnewmodule/widgets/root.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String? _email;
  final _passwordController = TextEditingController();
  bool _passwordLoading = false;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) _email = user.email;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      AuthCache().removeAuth();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => LoginPage()),
          (_) => false,
        );
      }
    } catch (e) {
      if (mounted) AppSnack.error(context, 'Sign out failed. Please try again.');
    }
  }

  void _showChangePasswordSheet() {
    _passwordController.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
          24, 24, 24,
          MediaQuery.of(ctx).viewInsets.bottom + 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Change Password', style: AppTextStyles.heading2),
            const SizedBox(height: 6),
            Text('Enter your new password below.', style: AppTextStyles.bodyMedium),
            const SizedBox(height: 20),
            AppInput(
              controller: _passwordController,
              hint: 'New password (min. 6 characters)',
              prefixIcon: Icons.lock_outline,
              obscureText: true,
              autofocus: true,
            ),
            const SizedBox(height: 16),
            StatefulBuilder(
              builder: (_, setInner) => AppButton(
                label: 'Update Password',
                loading: _passwordLoading,
                onTap: () async {
                  final newPass = _passwordController.text.trim();
                  if (newPass.length < 6) {
                    AppSnack.error(ctx, 'Password must be at least 6 characters.');
                    return;
                  }
                  setInner(() => _passwordLoading = true);
                  String? errorMsg;
                  try {
                    await FirebaseAuth.instance.currentUser!.updatePassword(newPass);
                  } catch (e) {
                    errorMsg = cleanFirebaseError(e);
                  } finally {
                    setInner(() => _passwordLoading = false);
                  }
                  if (!mounted) return;
                  if (errorMsg != null) {
                    AppSnack.error(context, errorMsg);
                  } else {
                    Navigator.of(context).pop();
                    AppSnack.success(context, 'Password updated successfully.');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(String feature) {
    AppSnack.info(context, '$feature — coming soon!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Account')),
      body: Column(
        children: [
          // Profile header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            color: AppColors.background,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primaryLight,
                  child: Text(
                    (_email?.isNotEmpty == true)
                        ? _email![0].toUpperCase()
                        : '?',
                    style: AppTextStyles.heading2.copyWith(color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_email ?? '—', style: AppTextStyles.label),
                      const SizedBox(height: 2),
                      Text('Dentist', style: AppTextStyles.bodySmall),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  onPressed: _showChangePasswordSheet,
                  tooltip: 'Change password',
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Menu items
          _MenuItem(
            icon: Icons.chat_outlined,
            label: 'Help Center',
            onTap: () => _showComingSoon('Help Center'),
          ),
          _MenuItem(
            icon: Icons.info_outline,
            label: 'About Us',
            onTap: () => _showComingSoon('About Us'),
          ),
          _MenuItem(
            icon: Icons.mail_outline,
            label: 'Contact Us',
            onTap: () => _showComingSoon('Contact Us'),
          ),
          const Divider(height: 1),
          _MenuItem(
            icon: Icons.logout,
            label: 'Sign Out',
            color: AppColors.error,
            onTap: _signOut,
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.textPrimary;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: c, size: 20),
            const SizedBox(width: 16),
            Expanded(
              child: Text(label, style: AppTextStyles.body.copyWith(color: c)),
            ),
            Icon(Icons.chevron_right, color: AppColors.textHint, size: 18),
          ],
        ),
      ),
    );
  }
}
