import 'dart:ui';

import 'package:flutter/material.dart';

/// Applies a backdrop blur only when [enabled] to keep paint cost low at top.
class NavBlur extends StatelessWidget {
  final bool enabled;
  final Widget child;
  const NavBlur({super.key, required this.enabled, required this.child});

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      child: child,
    );
  }
}
