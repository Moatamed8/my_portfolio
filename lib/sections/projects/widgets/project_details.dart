import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_theme.dart';
import '../../../core/utils.dart';
import '../../../domain/entities/project.dart';
import 'store_link_button.dart';

/// Title, description, downloads, and store buttons for the mobile dialog.
class ProjectDetailsBody extends StatelessWidget {
  final Project project;
  final bool compact;
  final bool showClose;
  final VoidCallback? onClose;

  const ProjectDetailsBody({
    super.key,
    required this.project,
    this.compact = false,
    this.showClose = false,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final titleSize = compact ? 18.0 : 22.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                project.title,
                style: TextStyle(
                  fontFamily: AppTheme.display,
                  fontSize: titleSize,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  color: context.textColor,
                ),
              ),
            ),
            if (showClose)
              IconButton(
                tooltip: 'Close',
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                onPressed: onClose,
                icon: Icon(Icons.close_rounded, color: context.muted, size: 20),
              ),
          ],
        ),
        SizedBox(height: compact ? 8 : 10),
        Text(
          project.description,
          maxLines: compact ? 3 : null,
          overflow: compact ? TextOverflow.ellipsis : TextOverflow.clip,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: compact ? 10 : 14),
        Row(
          children: [
            const Icon(
              Icons.download_rounded,
              size: 16,
              color: AppColors.accent,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                'Downloads: ${project.downloads}',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: context.textColor,
                ),
              ),
            ),
          ],
        ),
        if (project.hasGooglePlay || project.hasAppStore) ...[
          SizedBox(height: compact ? 12 : 16),
          ProjectStoreLinks(project: project),
        ],
      ],
    );
  }
}

/// Downloads and store buttons shown under the card copy on desktop hover.
class ProjectHoverActions extends StatelessWidget {
  final Project project;

  const ProjectHoverActions({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Row(
          children: [
            const Icon(
              Icons.download_rounded,
              size: 16,
              color: AppColors.accent,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                'Downloads: ${project.downloads}',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: context.textColor,
                ),
              ),
            ),
          ],
        ),
        if (project.hasGooglePlay || project.hasAppStore) ...[
          const SizedBox(height: 12),
          ProjectStoreLinks(project: project),
        ],
      ],
    );
  }
}

class ProjectStoreLinks extends StatelessWidget {
  final Project project;

  const ProjectStoreLinks({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        if (project.hasGooglePlay)
          StoreLinkButton(
            label: 'Google Play',
            iconAsset: 'assets/icons/google_play.svg',
            onPressed: () => openUrl(project.googlePlayUrl!),
          ),
        if (project.hasAppStore)
          StoreLinkButton(
            label: 'App Store',
            iconAsset: 'assets/icons/apple.svg',
            onPressed: () => openUrl(project.appStoreUrl!),
          ),
      ],
    );
  }
}

Future<void> showProjectDetails(BuildContext context, Project project) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withValues(alpha: 0.56),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (dialogContext, animation, secondaryAnimation) {
      return _ProjectDetailsDialog(project: project);
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.96, end: 1).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class _ProjectDetailsDialog extends StatelessWidget {
  final Project project;

  const _ProjectDetailsDialog({required this.project});

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.sizeOf(context).height * 0.86;
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
          child: Material(
            color: context.surface,
            elevation: 18,
            shadowColor: Colors.black.withValues(alpha: 0.35),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
              side: BorderSide(color: context.border),
            ),
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 440, maxHeight: maxHeight),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 14, 14, 22),
                child: ProjectDetailsBody(
                  project: project,
                  showClose: true,
                  onClose: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
