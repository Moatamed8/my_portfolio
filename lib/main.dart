import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'core/app_theme.dart';
import 'core/splash/splash_remover.dart';
import 'core/theme_controller.dart';
import 'core/visit/visit_notifier.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const PortfolioApp());
  unawaited(notifyVisit());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _mode = ThemeMode.dark;
  bool _splashRemoved = false;

  void _toggleTheme() {
    setState(() {
      _mode = _mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
    _syncSystemUi();
  }

  void _syncSystemUi() {
    final dark = _mode == ThemeMode.dark;
    SystemChrome.setSystemUIOverlayStyle(
      dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
    );
  }

  @override
  void initState() {
    super.initState();
    _syncSystemUi();
    // Remove the HTML loading screen once the first frame is on screen.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!_splashRemoved) {
        _splashRemoved = true;
        removeSplash();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeController(
      isDark: _mode == ThemeMode.dark,
      toggle: _toggleTheme,
      child: MaterialApp(
        title: 'Moatamed Wageh — Mobile Application Developer',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: _mode,
        themeAnimationDuration: const Duration(milliseconds: 350),
        home: const HomeScreen(),
      ),
    );
  }
}
