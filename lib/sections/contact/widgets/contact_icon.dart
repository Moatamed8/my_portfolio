import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_colors.dart';
import '../../../core/utils.dart';

class ContactIcon extends StatefulWidget {
  final String icon;
  final String url;
  final String label;
  const ContactIcon({
    super.key,
    required this.icon,
    required this.url,
    required this.label,
  });

  @override
  State<ContactIcon> createState() => _ContactIconState();
}

class _ContactIconState extends State<ContactIcon> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          onTap: () => openUrl(widget.url),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: _hover ? 1 : 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(
                widget.icon,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  _hover ? AppColors.accent : Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
