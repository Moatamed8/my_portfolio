import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/utils.dart';
import '../../../data/portfolio_data.dart';
import '../nav_item.dart';
import 'logo.dart';

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
                  const Logo(),
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
                child: Material(
                  color: Colors.transparent,
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: AppColors.buttonGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () => openUrl(PortfolioData.whatsapp),
                      borderRadius: BorderRadius.circular(12),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat_rounded,
                              size: 18,
                              color: AppColors.textColor,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Hire Me',
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
