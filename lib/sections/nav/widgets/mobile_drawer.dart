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
