import 'package:flutter/material.dart';

/// Central place for every piece of personal content shown on the site.
/// Update values here to change the whole portfolio.
class PortfolioData {
  PortfolioData._();

  // --- Identity ---
  static const String name = 'Moatamed Wageh';
  static const String firstName = 'Moatamed';
  static const String role = 'Mobile Application Developer';
  static const String greeting = "Hi there, welcome to my space";

  static const List<String> roles = [
    'Mobile Application Developer',
    'Flutter Engineer',
    'iOS & Android Developer',
    'Software Engineer',
  ];

  static const String heroTagline =
      'I craft fast, elegant and reliable mobile experiences. '
      'Freelancer providing services for programming and design needs — '
      "let's build something great together.";

  // --- About ---
  static const String aboutHeadline =
      "I'm Moatamed Wageh, a Mobile App Developer";

  static const String aboutBody =
      'I graduated as a Software Engineer from Zagazig University, Egypt. '
      "I've been developing mobile applications for over 3 years, working with "
      'multiple startups to launch their products and gaining valuable, '
      'hands-on experience along the way. I currently work as an Associate '
      'Software Engineer at Onyxsio (Sri Lanka), building polished, '
      'production-grade apps with Flutter.';

  static const List<Highlight> highlights = [
    Highlight(value: '3+', label: 'Years of Experience'),
    Highlight(value: '15+', label: 'Projects Delivered'),
    Highlight(value: '4+', label: 'Apps in Stores'),
    Highlight(value: '∞', label: 'Cups of Coffee'),
  ];

  static const List<String> skills = [
    'Flutter',
    'Dart',
    'iOS',
    'Android',
    'Firebase',
    'REST APIs',
    'State Management',
    'Clean Architecture',
    'CI/CD',
    'Git',
    'UI/UX',
    'AI Integration',
  ];

  // --- Contact ---
  static const String phoneDisplay = '+20 128 858 4664';

  // --- Links ---
  static const String resume =
      'https://drive.google.com/file/d/1TMId1ZW3_Op3zsqXuVuEiGcTG7c4go1c/view?usp=sharing';
  static const String gitHub = 'https://github.com/Moatamed8';
  static const String facebook = 'https://www.facebook.com/moatamed.elbana/';
  static const String twitter = 'https://twitter.com/MoatamedElbana';
  static const String linkedin =
      'https://www.linkedin.com/in/moatamed-wageh-69a48b112/';
  static const String instagram = 'https://www.instagram.com/m3tmed_wageh/';
  static const String freelancer = 'https://www.freelancer.com/u/Moatamed8';
  static const String whatsapp =
      'https://api.whatsapp.com/send?phone=201288584664';

  // --- Assets ---
  static const String profileImage = 'assets/images/profile.jpeg';

  static const List<SocialLink> socials = [
    SocialLink(label: 'GitHub', url: gitHub, icon: Icons.code_rounded),
    SocialLink(
        label: 'LinkedIn', url: linkedin, icon: Icons.business_center_rounded),
    SocialLink(label: 'WhatsApp', url: whatsapp, icon: Icons.chat_rounded),
    SocialLink(label: 'Twitter', url: twitter, icon: Icons.alternate_email),
    SocialLink(
        label: 'Instagram', url: instagram, icon: Icons.camera_alt_rounded),
    SocialLink(label: 'Facebook', url: facebook, icon: Icons.facebook_rounded),
    SocialLink(label: 'Freelancer', url: freelancer, icon: Icons.work_rounded),
  ];

  static const List<Service> services = [
    Service(
      name: 'AI Development',
      icon: 'assets/icons/ai.svg',
      description:
          'Interested in bringing AI into your product? I integrate modern '
          'AI models and agents to make your app smarter.',
      tools: ['AI Agents', 'Hugging Face', 'Replicate', 'Cog'],
    ),
    Service(
      name: 'Android Development',
      icon: 'assets/icons/android.svg',
      description:
          'High-performance, beautiful Android apps built with Flutter and '
          'native code where it counts.',
      tools: ['Flutter', 'Android (Java)'],
    ),
    Service(
      name: 'iOS Development',
      icon: 'assets/icons/apple.svg',
      description:
          'Smooth, native-feeling iOS apps delivered to the App Store with '
          'a single, maintainable codebase.',
      tools: ['Flutter', 'Swift'],
    ),
    Service(
      name: 'Web Development',
      icon: 'assets/icons/website.svg',
      description:
          'Responsive, fast web apps and landing pages — like this very '
          'portfolio — built with Flutter.',
      tools: ['Flutter', 'Web'],
    ),
  ];

  static const List<Project> projects = [
    Project(
      title: 'Luxury Health',
      category: 'E-commerce',
      banner: 'assets/images/luxury_banner.png',
      icon: 'assets/icons/luxury.png',
      description:
          'An e-commerce app providing a seamless platform for purchasing '
          'medicines and healthcare products online — convenient, reliable '
          'and with fast delivery.',
      url: 'https://apps.apple.com/sa/app/trade-off/id6741512514',
    ),
    Project(
      title: 'Trade Off',
      category: 'Marketplace',
      banner: 'assets/images/tradeoff_banner.jpeg',
      icon: 'assets/icons/tradeoff.png',
      description:
          'A marketplace app to sell, rent and exchange your stuff. It helps '
          'you connect with people interested in buying your used items.',
      url: 'https://apps.apple.com/sa/app/trade-off/id1631203509',
    ),
    Project(
      title: 'Qlines',
      category: 'EdTech',
      banner: 'assets/images/qlines_banner.jpeg',
      icon: 'assets/icons/qlines.png',
      description:
          'The first app in the Arab world enabling teachers and students to '
          'excel in professional exams: licensing assessments, ability and '
          'achievement tests.',
      url:
          'https://play.google.com/store/apps/details?id=com.qlines.qlinesapp',
    ),
    Project(
      title: 'Essaly',
      category: 'Platform',
      banner: 'assets/images/essaly_banner.jpeg',
      icon: 'assets/icons/essaly.png',
      description:
          'An electronic platform packed with services that benefit both shop '
          'owners and consumers, all in one place.',
      url: 'https://apps.apple.com/sa/app/essaly/id1566713714',
    ),
  ];
}

class Highlight {
  final String value;
  final String label;
  const Highlight({required this.value, required this.label});
}

class SocialLink {
  final String label;
  final String url;
  final IconData icon;
  const SocialLink({required this.label, required this.url, required this.icon});
}

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

class Project {
  final String title;
  final String category;
  final String banner;
  final String icon;
  final String description;
  final String url;
  const Project({
    required this.title,
    required this.category,
    required this.banner,
    required this.icon,
    required this.description,
    required this.url,
  });
}
