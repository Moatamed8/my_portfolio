import 'dart:ui';

import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/responsive.dart';
import '../core/theme_controller.dart';
import '../core/utils.dart';
import '../data/portfolio_data.dart';

class NavItem {
  final String label;
  final VoidCallback onTap;
  const NavItem(this.label, this.onTap);
}

class NavBar extends StatelessWidget {
  final List<NavItem> items;
  final bool scrolled;
  final VoidCallback onMenu;

  const NavBar({
    super.key,
    required this.items,
    required this.scrolled,
    required this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final bg = context.surface;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 72,
      decoration: BoxDecoration(
        color: scrolled ? bg.withValues(alpha: 0.85) : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: scrolled ? context.border : Colors.transparent,
          ),
        ),
      ),
      child: ClipRect(
        child: BackdropFiltered(
          enabled: scrolled,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _Logo(),
                    if (isDesktop)
                      Row(
                        children: [
                          for (final item in items)
                            _NavLink(label: item.label, onTap: item.onTap),
                          const SizedBox(width: 12),
                          const _ThemeToggle(),
                          const SizedBox(width: 12),
                          _HireButton(),
                        ],
                      )
                    else
                      Row(
                        children: [
                          const _ThemeToggle(),
                          const SizedBox(width: 6),
                          IconButton(
                            onPressed: onMenu,
                            icon: const Icon(Icons.menu_rounded),
                            color: context.textColor,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            gradient: AppColors.brandGradient,
            borderRadius: BorderRadius.circular(11),
          ),
          alignment: Alignment.center,
          child: const Text(
            'MW',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          PortfolioData.firstName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: context.textColor,
          ),
        ),
      ],
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w500,
              color: _hover ? AppColors.accent : context.muted,
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle();

  @override
  Widget build(BuildContext context) {
    final controller = ThemeController.of(context);
    return IconButton(
      onPressed: controller.toggle,
      tooltip: controller.isDark ? 'Light mode' : 'Dark mode',
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, anim) =>
            RotationTransition(turns: anim, child: child),
        child: Icon(
          controller.isDark
              ? Icons.light_mode_rounded
              : Icons.dark_mode_rounded,
          key: ValueKey(controller.isDark),
          color: context.textColor,
          size: 21,
        ),
      ),
    );
  }
}

class _HireButton extends StatefulWidget {
  @override
  State<_HireButton> createState() => _HireButtonState();
}

class _HireButtonState extends State<_HireButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => openUrl(PortfolioData.whatsapp),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            gradient: AppColors.brandGradient,
            borderRadius: BorderRadius.circular(11),
            boxShadow: _hover
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.4),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : null,
          ),
          child: const Text(
            'Hire Me',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

/// Applies a backdrop blur only when [enabled] to keep paint cost low at top.
class BackdropFiltered extends StatelessWidget {
  final bool enabled;
  final Widget child;
  const BackdropFiltered({
    super.key,
    required this.enabled,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
      child: child,
    );
  }
}

class MobileDrawer extends StatelessWidget {
  final List<NavItem> items;
  const MobileDrawer({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const _Logo(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                    color: context.textColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            for (final item in items)
              ListTile(
                title: Text(
                  item.label,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: context.textColor,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: context.muted,
                ),
                onTap: () {
                  Navigator.pop(context);
                  item.onTap();
                },
              ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(22),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => openUrl(PortfolioData.whatsapp),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.chat_rounded, size: 18),
                  label: const Text('Hire Me'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
