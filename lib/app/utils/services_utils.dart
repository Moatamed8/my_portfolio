class ServicesUtils {
  final String name;
  final String icon;
  final List<String> tool;
  final String description;

  ServicesUtils(
      {required this.name,
      required this.icon,
      required this.description,
      required this.tool});
}

List<ServicesUtils> servicesUtils = [
  ServicesUtils(
    name: 'Cross Platform Development',
    icon: 'assets/icons/flutter.svg',
    description:
        "Are you interested in the great Mobile app? Let's make it a reality.",
    tool: ['Flutter','Dart'],
  ),
  ServicesUtils(
    name: 'Android App Development',
    icon: 'assets/icons/android.svg',
    description:
        "Are you interested in the great Mobile app? Let's make it a reality.",
    tool: ['Java','Kotlin'],
  ),

 /* ServicesUtils(
    name: 'Web Development',
    icon: 'assets/icons/website.svg',
    description:
        "Do you have an idea for your next great website? Let's make it a reality.",
    tool: ['Flutter'],
  ),*/
  ServicesUtils(
    name: 'AI Development',
    icon: 'assets/icons/ai.svg',
    description:
        "Are you interested in the Ai Models? Let's make it a reality.",
    tool: ["AI AGENT, Cog ", 'Hugging Face, Replicate'],
  ),
];
