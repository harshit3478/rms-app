import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/widgets/app_button.dart';
import 'package:rmsnewmodule/widgets/app_input.dart';
import 'package:rmsnewmodule/widgets/app_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      AppSnack.error(context, 'Please enter your email address.');
      return;
    }
    setState(() => _loading = true);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (mounted) {
        AppSnack.success(context, 'Reset email sent! Check your inbox.');
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) AppSnack.error(context, cleanFirebaseError(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background
          Container(color: AppColors.background),
          SvgPicture.asset('assets/dots_rectangle.svg'),
          Positioned(
            top: 0, right: 0,
            child: SvgPicture.asset('assets/background_circles.svg'),
          ),
          Positioned(
            bottom: 0, right: 0,
            child: SvgPicture.asset('assets/striped_oval.svg'),
          ),
          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 60),
                  Text('Forgot Password?', style: AppTextStyles.heading1),
                  const SizedBox(height: 8),
                  Text(
                    "Enter your email and we'll send you a link to reset your password.",
                    style: AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: 36),
                  AppInput(
                    controller: _emailController,
                    hint: 'Email address',
                    prefixIcon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: 28),
                  AppButton(
                    label: 'Send Reset Link',
                    loading: _loading,
                    onTap: _submit,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
