import 'package:flutter/material.dart';

/// A stat shown in the About section.
class Highlight {
  final String value;
  final String label;

  const Highlight({required this.value, required this.label});
}

/// An external profile linked from the hero, contact section, and footer.
class SocialLink {
  final String label;
  final String url;
  final IconData icon;

  const SocialLink({
    required this.label,
    required this.url,
    required this.icon,
  });
}

/// A service card in the Services section.
class Service {
  final String name;
  final String icon;
  final String description;
  final List<String> tools;

  const Service({
    required this.name,
    required this.icon,
    required this.description,
    required this.tools,
  });
}
