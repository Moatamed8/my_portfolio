import 'package:flutter/material.dart';

import '../../core/responsive.dart';
import 'widgets/hero_image.dart';
import 'widgets/hero_text.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onContact;
  const HeroSection({super.key, required this.onContact});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final text = HeroText(onContact: onContact);
    const image = HeroImage();

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
