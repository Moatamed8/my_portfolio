import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/responsive.dart';
import '../core/utils.dart';
import '../data/portfolio_data.dart';
import '../widgets/animated_role.dart';
import '../widgets/gradient_button.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onContact;
  const HeroSection({super.key, required this.onContact});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final text = _HeroText(onContact: onContact);
    const image = _HeroImage();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value(context, mobile: 22.0, desktop: 0.0),
        vertical: isMobile ? 28 : 40,
      ),
      child: isMobile
          ? Column(
              children: [
                const SizedBox(height: 8),
                image,
                const SizedBox(height: 40),
                text,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 6, child: text),
                const SizedBox(width: 40),
                const Expanded(flex: 5, child: image),
              ],
            ),
    );
  }
}

class _HeroText extends StatelessWidget {
  final VoidCallback onContact;
  const _HeroText({required this.onContact});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final align = isMobile
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = isMobile ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: context.surfaceAlt,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: context.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('👋  ', style: TextStyle(fontSize: 14)),
              Flexible(
                child: Text(
                  PortfolioData.greeting,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: context.muted,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Text(
          "I'm ${PortfolioData.name}",
          textAlign: textAlign,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            height: 1.05,
            letterSpacing: -1,
            fontSize: Responsive.value(context, mobile: 38.0, desktop: 60.0),
            color: context.textColor,
          ),
        ),
        const SizedBox(height: 10),
        DefaultTextStyle(
          style: const TextStyle(),
          child: AnimatedRole(
            roles: PortfolioData.roles,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              height: 1.1,
              fontSize: Responsive.value(context, mobile: 24.0, desktop: 34.0),
            ),
          ),
        ),
        const SizedBox(height: 22),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            PortfolioData.heroTagline,
            textAlign: textAlign,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 34),
        Wrap(
          spacing: 16,
          runSpacing: 14,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            GradientButton(
              label: 'Download CV',
              icon: Icons.download_rounded,
              onTap: () => openUrl(PortfolioData.resume),
            ),
            OutlineButton(
              label: "Let's Talk",
              icon: Icons.arrow_outward_rounded,
              onTap: onContact,
            ),
          ],
        ),
        const SizedBox(height: 34),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: PortfolioData.socials
              .take(5)
              .map((s) => _SocialDot(icon: s.icon, url: s.url, label: s.label))
              .toList(),
        ),
      ],
    );
  }
}

class _SocialDot extends StatefulWidget {
  final IconData icon;
  final String url;
  final String label;
  const _SocialDot({
    required this.icon,
    required this.url,
    required this.label,
  });

  @override
  State<_SocialDot> createState() => _SocialDotState();
}

class _SocialDotState extends State<_SocialDot> {
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
              child: Icon(
                widget.icon,
                size: 20,
                color: _hover ? Colors.white : context.muted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage();

  @override
  Widget build(BuildContext context) {
    final size = Responsive.value(context, mobile: 260.0, desktop: 380.0);
    return Center(
      child: SizedBox(
        width: size,
        height: size + 20,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.accent.withValues(alpha: 0.35),
                    AppColors.accent2.withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Container(
              width: size * 0.82,
              height: size * 0.82,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.brandGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.4),
                    blurRadius: 40,
                    spreadRadius: 4,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(5),
              child: ClipOval(
                child: Image.asset(
                  PortfolioData.profileImage,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    color: context.surfaceAlt,
                    alignment: Alignment.center,
                    child: const Text(
                      'MW',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 4,
              right: 20,
              child: _FloatingBadge(label: 'Flutter', emoji: '💙'),
            ),
            const Positioned(
              bottom: 20,
              left: 0,
              child: _FloatingBadge(label: '3+ yrs', emoji: '🚀'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingBadge extends StatefulWidget {
  final String label;
  final String emoji;
  const _FloatingBadge({required this.label, required this.emoji});

  @override
  State<_FloatingBadge> createState() => _FloatingBadgeState();
}

class _FloatingBadgeState extends State<_FloatingBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, -6 + _c.value * 12),
        child: child,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: context.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.emoji, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 7),
            Text(
              widget.label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: context.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
