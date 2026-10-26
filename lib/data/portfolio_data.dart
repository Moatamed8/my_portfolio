import '../domain/entities/content.dart';
import '../domain/entities/project.dart';

export '../domain/entities/content.dart';
export '../domain/entities/project.dart';

/// Central place for every piece of personal content shown on the site.
/// Update values here to change the whole portfolio.
class PortfolioData {
  PortfolioData._();

  // --- Identity ---
  static const String name = 'Moatamed Wageh';
  static const String firstName = 'Moatamed';
  static const String role = 'Mobile Application Developer';
  static const String greeting = "Hi there, welcome to my portfolio";

  static const List<String> roles = [
    'Senior Mobile Developer',
    'Senior Software Engineer',
  ];

  static const String heroTagline =
      'I’m a Senior Flutter Developer who turns ideas into polished, '
      'production-ready mobile apps — with a focus on clean architecture, '
      'performance, and great user experiences.';

  // --- About ---
  static const String aboutHeadline =
      "I'm Moatamed Wageh, a Senior Flutter Developer";

  static const String aboutBody =
      'I graduated with a Bachelor of Computer Science and Information Technology '
      'from Zagazig University, Egypt. '
      'I have over 6 years of experience building and shipping production-ready '
      'mobile applications with Flutter, working across e-commerce, education, '
      'healthcare, food delivery, and marketplace products. '
      'I specialize in building scalable, reliable apps with clean architecture, '
      'real-time features, payment integrations, Firebase, and AI-powered experiences.';

  static const List<Highlight> highlights = [
    Highlight(value: '6+', label: 'Years of Experience'),
    Highlight(value: '30+', label: 'Projects Delivered'),
    Highlight(value: '20+', label: 'Apps in Stores'),
  ];

  static const List<String> skills = [
    'Flutter',
    'Dart',
    'Flutter Flavors',
    'Android',
    'iOS',
    'State Management',
    'Clean Architecture',
    'REST APIs',
    'Firebase',
    'Real-Time Apps',
    'WebRTC',
    'Payment Integration',
    'Platform Channels',
    'App Lifecycle',
    'AI Integration',
    'CI/CD',
    'Git & GitHub',
  ];

  // --- Contact ---
  static const String phoneDisplay = '+20 128 858 4664';

  // --- Links ---
  static const String resume =
      "https://drive.google.com/drive/folders/11W6E9Ng2HkRONMFeNT1UN46BmUJEmrgm?usp=sharing";
  static const String gitHub = 'https://github.com/Moatamed8';
  static const String facebook = 'https://www.facebook.com/moatamed.elbana/';
  static const String twitter = 'https://twitter.com/MoatamedElbana';
  static const String linkedin = 'https://www.linkedin.com/in/moatamed-wageh/';
  static const String instagram = 'https://www.instagram.com/m3tmed_wageh/';
  static const String freelancer = 'https://www.freelancer.com/u/Moatamed8';
  static const String whatsapp =
      'https://api.whatsapp.com/send?phone=201288584664';

  // --- Assets ---
  static const String profileImage = 'assets/images/profile.jpeg';

  static const List<SocialLink> socials = [
    SocialLink(label: 'GitHub', url: gitHub, icon: 'assets/icons/github.svg'),
    SocialLink(
      label: 'LinkedIn',
      url: linkedin,
      icon: 'assets/icons/linkedin.svg',
    ),
    SocialLink(
      label: 'Freelancer',
      url: freelancer,
      icon: 'assets/icons/freelancer.svg',
    ),
    SocialLink(
      label: 'WhatsApp',
      url: whatsapp,
      icon: 'assets/icons/whatsapp.svg',
    ),
    SocialLink(
      label: 'Twitter',
      url: twitter,
      icon: 'assets/icons/twitter.svg',
    ),

    SocialLink(
      label: 'Facebook',
      url: facebook,
      icon: 'assets/icons/facebook.svg',
    ),
    SocialLink(
      label: 'Instagram',
      url: instagram,
      icon: 'assets/icons/instagram.svg',
    ),
  ];

  static const List<Service> services = [
    Service(
      name: 'Flutter Development',
      icon: 'assets/icons/flutter.svg',
      description:
          'Build scalable, high-performance cross-platform mobile applications '
          'for iOS and Android using Flutter and a clean, maintainable codebase.',
      tools: [
        'Flutter',
        'Dart',
        'Bloc',
        'Riverpod',
        'Provider',
        'Clean Architecture',
      ],
    ),
    Service(
      name: 'Android Development',
      icon: 'assets/icons/android.svg',
      description:
          'Develop reliable Android applications using Flutter and native '
          'Android technologies, with a focus on performance and user experience.',
      tools: ['Flutter', 'Android', 'Java', 'Gradle', 'Maven'],
    ),
    Service(
      name: 'AI Development',
      icon: 'assets/icons/ai.svg',
      description:
          'Integrate AI-powered features into mobile applications to create '
          'smarter, more engaging, and practical user experiences.',
      tools: [
        'AI Integration',
        'AI Agents',
        'Machine Learning',
        'TensorFlow',
        'Hugging Face',
      ],
    ),
  ];

  /// Download labels follow the public Google Play install bracket.
  /// Edit a value here when a store number changes.
  static const List<Project> projects = [
    Project(
      title: 'Bokidz',
      category: 'Kids',
      icon: 'assets/icons/bokidz.png',
      description:
          'Bokidz is a children\'s application that provides a safe and '
          'entertaining user experience for your child. The application offers '
          'a variety of games and educational activities that help children '
          'learn essential skills such as reading, writing, and math in a fun '
          'and interactive way. Bokidz is committed to safety and privacy '
          'standards, providing a secure environment for children.',
      images: [
        'assets/projects/bokidz/image_1.webp',
        'assets/projects/bokidz/image_2.webp',
      ],
      googlePlayUrl:
          'https://play.google.com/store/apps/details?id=com.lenience.bokidz&hl=en',
      appStoreUrl: 'https://apps.apple.com/sg/app/bokidz/id6449681123',
      downloads: '37K+',
    ),
    Project(
      title: 'Luxury Health',
      category: 'E-commerce',
      icon: 'assets/icons/luxury.png',
      description:
          'E-commerce application designed and developed to provide a seamless '
          'platform for purchasing medicines and healthcare products online, '
          'ensuring convenience, reliability, and fast delivery.',
      images: [
        'assets/projects/luxury_health/image_1.webp',
        'assets/projects/luxury_health/image_2.webp',
        'assets/projects/luxury_health/image_3.webp',
      ],
      googlePlayUrl:
          'https://play.google.com/store/apps/details?id=com.lenience.luxuryhealth',
      appStoreUrl: 'https://apps.apple.com/app/luxury-health/id6741512514',
      downloads: '1K+',
    ),
    Project(
      title: 'Trade Off',
      category: 'Marketplace',
      icon: 'assets/icons/tradeoff.png',
      description:
          'Tradeoff is an application designed and developed to sell, rent, '
          'and exchange your stuff. It helps you to communicate with people '
          'who may be interested to buy your used stuff.',
      images: ['assets/projects/trade_off/image_1.webp'],
      googlePlayUrl:
          'https://play.google.com/store/apps/details?id=com.lenience.tradeoff',
      appStoreUrl: 'https://apps.apple.com/sa/app/trade-off/id1631203509',
      downloads: '1K+',
    ),
    Project(
      title: 'Qlines',
      category: 'EdTech',
      icon: 'assets/icons/qlines.png',
      description:
          'Qlines App is the first App in the Arab world to enable teachers '
          'and students to achieve an excellent level in their professional '
          'examinations; licensing assessments, ability tests, and achievement '
          'tests.',
      images: ['assets/projects/qlines/image_1.webp'],
      googlePlayUrl: 'https://play.google.com/store/apps/details?id=com.qlines',
      appStoreUrl:
          'https://apps.apple.com/sa/app/qlines-%D8%AA%D8%B7%D8%A8%D9%8A%D9%82-%D9%83%D9%8A%D9%88%D9%84%D8%A7%D9%8A%D9%86%D8%B2/id6736682146',
      downloads: '1K+',
    ),
    Project(
      title: 'Essaly',
      category: 'Platform',
      icon: 'assets/icons/essaly.png',
      description:
          'Essaly is an electronic platform that contains a lot of electronic '
          'services that can benefit the owners of the shops and consumers.',
      images: [
        'assets/projects/essaly/image_1.webp',
        'assets/projects/essaly/image_2.webp',
        'assets/projects/essaly/image_3.webp',
      ],
      googlePlayUrl:
          'https://play.google.com/store/apps/details?id=com.essalyapp',
      appStoreUrl: 'https://apps.apple.com/sa/app/essaly/id1566713714',
      downloads: '1K+',
    ),
    Project(
      title: '2rbly',
      category: 'Food & Drink',
      icon: 'assets/projects/2rbly/icon.webp',
      description:
          'A user-facing food delivery application that allows customers to '
          'discover nearby restaurants, browse menus, and order their favorite '
          'meals with ease. The app also supports custom shopping requests, '
          'enabling users to request specific items and have delivery partners '
          'purchase and deliver them. It provides a seamless ordering '
          'experience with real-time order tracking and convenient delivery '
          'management.',
      images: [
        'assets/projects/2rbly/image_1.webp',
        'assets/projects/2rbly/image_2.webp',
        'assets/projects/2rbly/image_3.webp',
      ],
      googlePlayUrl:
          'https://play.google.com/store/apps/details?id=com.Qrbly.customer',
      appStoreUrl:
          'https://apps.apple.com/eg/app/2rbly-%D9%82%D8%B1%D8%A8%D9%84%D9%8A/id1602011671',
      downloads: '20K+',
    ),
    Project(
      title: '2rbly - Delivery',
      category: 'Food & Drink',
      icon: 'assets/projects/2rbly/icon.webp',
      description:
          'A delivery partner application designed to help drivers efficiently '
          'manage and fulfill delivery orders in real time. Delivery partners '
          'can track active and completed orders, monitor their earnings and '
          'performance, view customer ratings, and access detailed insights '
          'into their delivery activities through a centralized dashboard.',
      images: [
        'assets/projects/2rbly_driver/image_1.webp',
        'assets/projects/2rbly_driver/image_2.webp',
      ],
      googlePlayUrl:
          'https://play.google.com/store/apps/details?id=com.qrbly.delivery',
      appStoreUrl: 'https://apps.apple.com/eg/app/2rbly-delivery/id1603425039',
      downloads: '10+',
    ),
    Project(
      title: '2rbly Partner',
      category: 'Food & Drink',
      icon: 'assets/projects/2rbly/icon.webp',
      description:
          'A restaurant partner management application that enables restaurants '
          'to manage incoming orders, assign deliveries to available delivery '
          'partners, and maintain their digital menus. Partners can add and '
          'manage products, create offers and features, update order statuses, '
          'and access a wide range of tools to streamline restaurant operations '
          'and improve order fulfillment.',
      images: [
        'assets/projects/2rbly_partner/image_1.webp',
        'assets/projects/2rbly_partner/image_2.webp',
      ],
      googlePlayUrl:
          'https://play.google.com/store/apps/details?id=com.qrbly.vendor',
      appStoreUrl: 'https://apps.apple.com/eg/app/2rbly-partner/id1603431879',
      downloads: '200+',
    ),
  ];
}
