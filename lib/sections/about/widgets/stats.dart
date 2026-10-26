import 'package:flutter/material.dart';

import '../../../data/portfolio_data.dart';
import 'stat_card.dart';

class Stats extends StatelessWidget {
  const Stats({super.key});

  @override
  Widget build(BuildContext context) {
    final items = PortfolioData.highlights;
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 16.0;
        final twoColumns = constraints.maxWidth >= 280;
        if (!twoColumns) {
          return Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (i > 0) const SizedBox(height: gap),
                StatCard(highlight: items[i]),
              ],
            ],
          );
        }

        return Column(
          children: [
            for (var i = 0; i < items.length; i += 2) ...[
              if (i > 0) const SizedBox(height: gap),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: StatCard(highlight: items[i])),
                    const SizedBox(width: gap),
                    Expanded(
                      child: i + 1 < items.length
                          ? StatCard(highlight: items[i + 1])
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
