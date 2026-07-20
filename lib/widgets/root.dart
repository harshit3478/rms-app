import 'dart:async';

import 'package:rmsnewmodule/auth/loginpage.dart';
import 'package:rmsnewmodule/screens/constant_pages/onBoarding.dart';
import 'package:rmsnewmodule/widgets/navigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 100), _checkFirstScreen);
  }

  Future<void> _checkFirstScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool('seen') ?? false;
    if (!mounted) return;
    if (seen) {
      _navigateUser();
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => OnBoardingScreen()),
      );
    }
  }

  Future<void> _navigateUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => isLoggedIn ? Navigation() : LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.white);
  }
}

// ─── Auth cache helpers ──────────────────────────────────────────────────────

class AuthCache {
  Future<void> setAuth(String uid, String? userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', uid);
    await prefs.setString('user_name', userName ?? '');
  }

  Future<void> removeAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_name');
  }

  Future<AuthModal> getAuth() async {
    final prefs = await SharedPreferences.getInstance();
    return AuthModal(
      uid: prefs.getString('user_id') ?? '',
      name: prefs.getString('user_name') ?? '',
    );
  }
}

class AuthModal {
  final String uid;
  final String name;
  AuthModal({required this.uid, required this.name});
}
