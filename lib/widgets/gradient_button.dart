import 'package:flutter/material.dart';

import '../core/app_colors.dart';

/// Filled button with the brand gradient and a subtle hover lift.
class GradientButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  const GradientButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hover ? -3 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
          decoration: BoxDecoration(
            gradient: AppColors.buttonGradient,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.buttonGradient.colors.last.withValues(
                  alpha: _hover ? 0.45 : 0.25,
                ),
                blurRadius: _hover ? 22 : 12,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: AppColors.textColor, size: 19),
                const SizedBox(width: 9),
              ],
              Text(
                widget.label,
                style: const TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Outlined / ghost button variant.
class OutlineButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  const OutlineButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  @override
  State<OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<OutlineButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final color = context.textColor;
    final fill = context.isDark ? AppColors.darkBg : AppColors.lightBg;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(1.6),
          decoration: BoxDecoration(
            gradient: AppColors.buttonGradient,
            borderRadius: BorderRadius.circular(14),
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: _hover
                  ? Color.alphaBlend(
                      AppColors.buttonGradient.colors.last.withValues(
                        alpha: 0.14,
                      ),
                      fill,
                    )
                  : fill,
              borderRadius: BorderRadius.circular(12.4),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22.4,
                vertical: 12.4,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, color: color, size: 19),
                    const SizedBox(width: 9),
                  ],
                  Text(
                    widget.label,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
