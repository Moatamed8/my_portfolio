import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import 'nav_item.dart';
import 'widgets/hire_button.dart';
import 'widgets/logo.dart';
import 'widgets/nav_blur.dart';
import 'widgets/nav_link.dart';
import 'widgets/theme_toggle.dart';

export 'nav_item.dart';
export 'widgets/mobile_drawer.dart';

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
        child: NavBlur(
          enabled: scrolled,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Logo(),
                    if (isDesktop)
                      Row(
                        children: [
                          for (final item in items)
                            NavLink(label: item.label, onTap: item.onTap),
                          const SizedBox(width: 12),
                          const ThemeToggle(),
                          const SizedBox(width: 12),
                          const HireButton(),
                        ],
                      )
                    else
                      Row(
                        children: [
                          const ThemeToggle(),
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
