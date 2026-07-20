import 'package:rmsnewmodule/auth/loginpage.dart';
import 'package:rmsnewmodule/theme/app_theme.dart';
import 'package:rmsnewmodule/widgets/app_button.dart';
import 'package:rmsnewmodule/widgets/app_input.dart';
import 'package:rmsnewmodule/widgets/app_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _linkedinController = TextEditingController();
  bool _obscurePassword = true;
  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _qualificationController.dispose();
    _linkedinController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await FirebaseFirestore.instance.collection('registerRequests').add({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'password': _passwordController.text,
        'qualification': _qualificationController.text.trim(),
        'linkedin': _linkedinController.text.trim(),
      });
      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      if (mounted) AppSnack.error(context, 'Failed to submit. Please try again.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        title: const Icon(Icons.check_circle_rounded,
            color: AppColors.success, size: 48),
        content: Text(
          "Your request has been submitted!\nWe'll review your profile and get back to you shortly.",
          style: AppTextStyles.body,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          AppButton(
            label: 'Back to Login',
            width: 180,
            onTap: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => LoginPage()),
              (_) => false,
            ),
          ),
        ],
      ),
    );
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
                  const SizedBox(height: 100),
                  Text('Create Account', style: AppTextStyles.heading1),
                  const SizedBox(height: 8),
                  Text(
                    "Fill in the form to request access. We'll review your profile and get back to you.",
                    style: AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: 36),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppInput(
                          controller: _nameController,
                          hint: 'Full name',
                          prefixIcon: Icons.person_outline,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Please enter your name'
                              : null,
                        ),
                        const SizedBox(height: 12),
                        AppInput(
                          controller: _emailController,
                          hint: 'Email address',
                          prefixIcon: Icons.mail_outline,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) return 'Please enter your email';
                            if (!v.contains('@') || !v.contains('.')) return 'Enter a valid email';
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        AppInput(
                          controller: _passwordController,
                          hint: 'Password (min. 6 characters)',
                          prefixIcon: Icons.lock_outline,
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.next,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            ),
                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Please enter a password';
                            if (v.length < 6) return 'Password must be at least 6 characters';
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        AppInput(
                          controller: _qualificationController,
                          hint: 'Qualification (e.g. BDS, MDS)',
                          prefixIcon: Icons.school_outlined,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Please enter your qualification'
                              : null,
                        ),
                        const SizedBox(height: 12),
                        AppInput(
                          controller: _linkedinController,
                          hint: 'LinkedIn profile URL',
                          prefixIcon: Icons.link,
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submit(),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Please enter your LinkedIn URL'
                              : null,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  AppButton(
                    label: 'Submit Request',
                    loading: _loading,
                    onTap: _submit,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?', style: AppTextStyles.bodySmall),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Sign in'),
                      ),
                    ],
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
