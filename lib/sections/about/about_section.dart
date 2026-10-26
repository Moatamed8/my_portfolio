import 'package:flutter/material.dart';

import '../../core/responsive.dart';
import '../../widgets/reveal_on_scroll.dart';
import '../../widgets/section_header.dart';
import 'widgets/bio.dart';
import 'widgets/stats.dart';

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
                ? const Column(children: [Stats(), SizedBox(height: 32), Bio()])
                : const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: Stats()),
                      SizedBox(width: 48),
                      Expanded(flex: 7, child: Bio()),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
