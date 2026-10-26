import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/responsive.dart';

/// A consistent eyebrow + title + subtitle header used at the top of sections.
class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;
  final CrossAxisAlignment align;

  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.align = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final centered = align == CrossAxisAlignment.center;
    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
          ),
          child: Text(
            eyebrow.toUpperCase(),
            style: const TextStyle(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
              fontSize: 12,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            height: 1.1,
            fontSize: Responsive.value(context, mobile: 30.0, desktop: 42.0),
            color: context.textColor,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              subtitle!,
              textAlign: centered ? TextAlign.center : TextAlign.start,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ],
    );
  }
}
