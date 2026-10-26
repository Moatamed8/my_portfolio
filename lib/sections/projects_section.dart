import 'package:flutter/material.dart';

import '../core/responsive.dart';
import '../data/portfolio_data.dart';
import '../widgets/projects/project_card.dart';
import '../widgets/reveal_on_scroll.dart';
import '../widgets/section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final crossAxisCount = Responsive.value(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 2,
    );

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
                  'and consumers across the App Store and Google Play.',
            ),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 24.0;
              final width = crossAxisCount == 1
                  ? constraints.maxWidth
                  : (constraints.maxWidth - gap * (crossAxisCount - 1)) /
                        crossAxisCount;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (var i = 0; i < PortfolioData.projects.length; i++)
                    SizedBox(
                      width: width,
                      child: RevealOnScroll(
                        delay: Duration(milliseconds: 90 * i),
                        child: ProjectCard(
                          key: ValueKey(PortfolioData.projects[i].title),
                          project: PortfolioData.projects[i],
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
