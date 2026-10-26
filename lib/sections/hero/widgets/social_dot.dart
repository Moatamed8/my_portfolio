import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app_colors.dart';
import '../../../core/utils.dart';

class SocialDot extends StatefulWidget {
  final String icon;
  final String url;
  final String label;
  const SocialDot({
    super.key,
    required this.icon,
    required this.url,
    required this.label,
  });

  @override
  State<SocialDot> createState() => _SocialDotState();
}

class _SocialDotState extends State<SocialDot> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Tooltip(
        message: widget.label,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hover = true),
          onExit: (_) => setState(() => _hover = false),
          child: GestureDetector(
            onTap: () => openUrl(widget.url),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _hover ? null : context.surfaceAlt,
                gradient: _hover ? AppColors.brandGradient : null,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.border),
              ),
              child: Center(
                child: SvgPicture.asset(
                  widget.icon,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    _hover ? Colors.white : context.muted,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
