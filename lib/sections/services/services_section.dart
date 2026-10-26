import 'package:flutter/material.dart';

import '../../core/responsive.dart';
import '../../data/portfolio_data.dart';
import '../../widgets/reveal_on_scroll.dart';
import '../../widgets/section_header.dart';
import 'widgets/service_card.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

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
              eyebrow: 'What I Do',
              title: 'Services I offer',
              subtitle:
                  'From idea to the App Store — I help startups and businesses '
                  'build polished digital products.',
            ),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, c) {
              const gap = 20.0;
              final width = crossAxisCount == 1
                  ? c.maxWidth
                  : (c.maxWidth - gap * (crossAxisCount - 1)) / crossAxisCount;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (var i = 0; i < PortfolioData.services.length; i++)
                    SizedBox(
                      width: width,
                      child: RevealOnScroll(
                        delay: Duration(milliseconds: 80 * i),
                        child: ServiceCard(service: PortfolioData.services[i]),
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
