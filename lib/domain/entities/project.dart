/// A shipped product shown in the Selected Work section.
///
/// [images] is a list of local WebP assets and must contain at least one path.
/// Store links are optional so a project can ship on one store without a dead
/// button.
class Project {
  final String title;
  final String category;
  final String description;
  final List<String> images;
  final String icon;
  final String downloads;
  final String? googlePlayUrl;
  final String? appStoreUrl;

  const Project({
    required this.title,
    required this.category,
    required this.description,
    required this.images,
    required this.icon,
    required this.downloads,
    this.googlePlayUrl,
    this.appStoreUrl,
  });

  bool get hasMultipleImages => images.length > 1;

  bool get hasGooglePlay => _hasLink(googlePlayUrl);

  bool get hasAppStore => _hasLink(appStoreUrl);

  static bool _hasLink(String? url) => url != null && url.isNotEmpty;
}
