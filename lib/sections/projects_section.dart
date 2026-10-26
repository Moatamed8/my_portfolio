import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/responsive.dart';
import '../core/utils.dart';
import '../data/portfolio_data.dart';
import '../widgets/reveal_on_scroll.dart';
import '../widgets/section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final crossAxisCount =
        Responsive.value(context, mobile: 1, tablet: 2, desktop: 2);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 22 : 0),
      child: Column(
        children: [
          const RevealOnScroll(
            child: SectionHeader(
              eyebrow: 'Portfolio',
              title: 'Selected work',
              subtitle:
                  "A few products I've designed and shipped for businesses "
                  "and consumers across the App Store and Google Play.",
            ),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(builder: (context, c) {
            const gap = 24.0;
            final width = crossAxisCount == 1
                ? c.maxWidth
                : (c.maxWidth - gap * (crossAxisCount - 1)) / crossAxisCount;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (var i = 0; i < PortfolioData.projects.length; i++)
                  SizedBox(
                    width: width,
                    child: RevealOnScroll(
                      delay: Duration(milliseconds: 90 * i),
                      child: _ProjectCard(project: PortfolioData.projects[i]),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => openUrl(p.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          transform: Matrix4.translationValues(0, _hover ? -6 : 0, 0),
          decoration: BoxDecoration(
            color: context.surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: _hover
                  ? AppColors.accent.withValues(alpha: 0.5)
                  : context.border,
            ),
            boxShadow: _hover
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.2),
                      blurRadius: 36,
                      offset: const Offset(0, 18),
                    ),
                  ]
                : null,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 400),
                      scale: _hover ? 1.06 : 1,
                      child: Image.asset(
                        p.banner,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, _, _) => Container(
                          decoration:
                              const BoxDecoration(gradient: AppColors.brandGradient),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 14,
                    left: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        p.category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            p.icon,
                            width: 38,
                            height: 38,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) => Container(
                              width: 38,
                              height: 38,
                              color: context.surfaceAlt,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            p.title,
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                              color: context.textColor,
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: _hover ? null : context.surfaceAlt,
                            gradient: _hover ? AppColors.brandGradient : null,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.arrow_outward_rounded,
                            size: 18,
                            color: _hover ? Colors.white : context.muted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      p.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
