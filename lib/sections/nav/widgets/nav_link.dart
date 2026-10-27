import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const NavLink({super.key, required this.label, required this.onTap});

  @override
  State<NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w500,
              color: _hover ? context.gold : context.muted,
            ),
          ),
        ),
      ),
    );
  }
}
