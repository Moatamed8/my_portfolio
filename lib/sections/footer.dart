import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/responsive.dart';
import '../core/utils.dart';
import '../data/portfolio_data.dart';

class Footer extends StatelessWidget {
  final VoidCallback onTop;
  const Footer({super.key, required this.onTop});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 22 : 0,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: context.border)),
      ),
      child: Wrap(
        alignment: isMobile ? WrapAlignment.center : WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
        spacing: 16,
        runSpacing: 14,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ShaderMask(
                shaderCallback: (r) => AppColors.brandGradient.createShader(r),
                child: const Text(
                  'MW',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '© ${DateTime.now().year} ${PortfolioData.name}',
                style: TextStyle(fontSize: 13.5, color: context.muted),
              ),
            ],
          ),
          Text(
            'Built with Flutter 💙',
            style: TextStyle(fontSize: 13.5, color: context.muted),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final s in PortfolioData.socials.take(4))
                IconButton(
                  onPressed: () => openUrl(s.url),
                  icon: Icon(s.icon, size: 18),
                  color: context.muted,
                  tooltip: s.label,
                  splashRadius: 18,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
