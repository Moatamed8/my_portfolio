import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/responsive.dart';
import '../data/portfolio_data.dart';
import '../widgets/reveal_on_scroll.dart';
import '../widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 22 : 0),
      child: Column(
        children: [
          const RevealOnScroll(
            child: SectionHeader(
              eyebrow: 'About Me',
              title: 'A bit about my journey',
            ),
          ),
          const SizedBox(height: 48),
          RevealOnScroll(
            delay: const Duration(milliseconds: 120),
            child: isMobile
                ? Column(
                    children: [
                      _Stats(),
                      const SizedBox(height: 32),
                      _Bio(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: _Stats()),
                      const SizedBox(width: 48),
                      Expanded(flex: 7, child: _Bio()),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _Bio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          PortfolioData.aboutHeadline,
          style: TextStyle(
            fontSize: Responsive.value(context, mobile: 22.0, desktop: 26.0),
            fontWeight: FontWeight.w600,
            height: 1.3,
            color: context.textColor,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          PortfolioData.aboutBody,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 26),
        Text(
          'Skills & Tools',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: context.muted,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: PortfolioData.skills
              .map((s) => _SkillChip(label: s))
              .toList(),
        ),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: context.surfaceAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.border),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w500,
          color: context.textColor,
        ),
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.35,
      children: PortfolioData.highlights
          .map((h) => _StatCard(highlight: h))
          .toList(),
    );
  }
}

class _StatCard extends StatelessWidget {
  final Highlight highlight;
  const _StatCard({required this.highlight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: context.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (r) => AppColors.brandGradient.createShader(r),
            child: Text(
              highlight.value,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            highlight.label,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
              color: context.muted,
            ),
          ),
        ],
      ),
    );
  }
}
