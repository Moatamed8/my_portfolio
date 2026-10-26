import 'package:flutter/material.dart';

/// Simple breakpoint-based responsive helper.
class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static const double mobileBreakpoint = 768;
  static const double desktopBreakpoint = 1100;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= mobileBreakpoint && w < desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= desktopBreakpoint;

  /// Returns a value scaled to the current breakpoint.
  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context)) return tablet ?? desktop;
    return mobile;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= desktopBreakpoint) return desktop;
    if (width >= mobileBreakpoint) return tablet ?? desktop;
    return mobile;
  }
}

/// Max content width wrapper to keep the layout readable on large screens.
class ContentWidth extends StatelessWidget {
  final Widget child;
  final double max;
  const ContentWidth({super.key, required this.child, this.max = 1180});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: max),
        child: child,
      ),
    );
  }
}
