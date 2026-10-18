class ProjectUtils {
  final List<String> banners;
  final String icons;
  final String titles;
  final String description;
  final String? playStoreUrl;
  final String? appStoreUrl;

  ProjectUtils({
    required this.banners,
    required this.icons,
    required this.titles,
    required this.description,
    this.playStoreUrl,
    this.appStoreUrl,
  });
}

List<ProjectUtils> projectUtils = [
  ProjectUtils(
    banners: [
      'assets/imgs/2rbly1.png',
      'assets/imgs/2rbly2.png',
      'assets/imgs/2rbly3.png'
    ],
    icons: 'assets/imgs/2rblylogo.png',
    titles: '2rbly',
    description:
        "A user-facing food delivery application that allows customers to discover nearby restaurants, browse menus, and order their favorite meals with ease. The app also supports custom shopping requests, enabling users to request specific items and have delivery partners purchase and deliver them. It provides a seamless ordering experience with real-time order tracking and convenient delivery management.",
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.Qrbly.customer',
    appStoreUrl:
        'https://apps.apple.com/eg/app/2rbly-%D9%82%D8%B1%D8%A8%D9%84%D9%8A/id1602011671',
  ),
  ProjectUtils(
    banners: ['assets/imgs/2rblyd1.png', 'assets/imgs/2rblyd2.png'],
    icons: 'assets/imgs/2rblylogo.png',
    titles: '2rbly - Delivery',
    description:
        "A delivery partner application designed to help drivers efficiently manage and fulfill delivery orders in real time. Delivery partners can track active and completed orders, monitor their earnings and performance, view customer ratings, and access detailed insights into their delivery activities through a centralized dashboard.",
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.qrbly.delivery',
    appStoreUrl: 'https://apps.apple.com/eg/app/2rbly-delivery/id1603425039',
  ),
  ProjectUtils(
    banners: ['assets/imgs/2rblyp1.png', 'assets/imgs/2rblyp2.png'],
    icons: 'assets/imgs/2rblylogo.png',
    titles: '2rbly Partner',
    description:
        "A restaurant partner management application that enables restaurants to manage incoming orders, assign deliveries to available delivery partners, and maintain their digital menus. Partners can add and manage products, create offers and features, update order statuses, and access a wide range of tools to streamline restaurant operations and improve order fulfillment",
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.qrbly.vendor',
    appStoreUrl: 'https://apps.apple.com/eg/app/2rbly-partner/id1603431879',
  ),
  ProjectUtils(
    banners: [
      'assets/imgs/02.jpeg',
      'assets/imgs/essaly1.png',
      'assets/imgs/essaly2.png'
    ],
    icons: 'assets/imgs/essaly.png',
    titles: 'Essaly',
    description:
        'Essaly is an electronic platform that contains a lot of electronic services that can be benefit for  the owners of the shops and consumers',
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.essalyapp',
    appStoreUrl: 'https://apps.apple.com/sa/app/essaly/id1566713714',
  ),
  ProjectUtils(
    banners: ['assets/imgs/luxury1.png', 'assets/imgs/luxury2.png'],
    icons: 'assets/imgs/luxury.png',
    titles: 'Luxury Health',
    description:
        "E-commerce application designed and developed to provide a seamless platform for purchasing medicines and healthcare products online, ensuring convenience, reliability, and fast delivery.",
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.lenience.luxuryhealth',
    appStoreUrl: 'https://apps.apple.com/app/luxury-health/id6741512514',
  ),
  ProjectUtils(
    banners: ['assets/imgs/03.jpeg'],
    icons: 'assets/imgs/tradeoff.png',
    titles: 'Trade Off',
    description:
        'Tradeoff is an application designed and developed to sell, rent, and exchange your stuff. I helps you to communicate	with people may be interested to buy your used stuff, check below.',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=com.lenience.tradeoff',
    appStoreUrl: 'https://apps.apple.com/sa/app/trade-off/id1631203509',
  ),
  ProjectUtils(
    banners: ['assets/imgs/1.jpeg'],
    icons: 'assets/imgs/qlines.png',
    titles: 'Qlines',
    description:
        'Qlines App is the first App in the Arab world to enable teachers and students to achieve an excellent level in their professional examinations; licensing assessments, ability tests, and achievement tests, check below.',
    playStoreUrl: 'https://play.google.com/store/apps/details?id=com.qlines',
    appStoreUrl:
        'https://apps.apple.com/sa/app/qlines-%D8%AA%D8%B7%D8%A8%D9%8A%D9%82-%D9%83%D9%8A%D9%88%D9%84%D8%A7%D9%8A%D9%86%D8%B2/id6736682146',
  ),
];
