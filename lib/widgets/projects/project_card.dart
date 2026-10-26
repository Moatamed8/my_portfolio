import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/responsive.dart';
import '../../domain/entities/project.dart';
import 'project_carousel.dart';
import 'project_details.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hover = false;
  bool _touchMode = false;

  bool get _useHoverOverlay => Responsive.isDesktop(context) && !_touchMode;

  void _onPointerDown(PointerDownEvent event) {
    final isTouch =
        event.kind == PointerDeviceKind.touch ||
        event.kind == PointerDeviceKind.stylus;
    if (!isTouch || _touchMode) return;
    setState(() {
      _touchMode = true;
      _hover = false;
    });
  }

  void _openDetails() {
    if (_useHoverOverlay) return;
    showProjectDetails(context, widget.project);
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final showDetails = _hover && _useHoverOverlay;

    return Listener(
      onPointerDown: _onPointerDown,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          if (!_useHoverOverlay) return;
          setState(() => _hover = true);
        },
        onExit: (_) {
          if (!_hover) return;
          setState(() => _hover = false);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          transform: Matrix4.translationValues(0, _hover ? -6 : 0, 0),
          transformAlignment: Alignment.center,
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            color: context.surface,
            borderRadius: BorderRadius.circular(22),
            boxShadow: _hover
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.2),
                      blurRadius: 36,
                      offset: const Offset(0, 18),
                    ),
                  ]
                : null,
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: _hover
                  ? AppColors.accent.withValues(alpha: 0.5)
                  : context.border,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _openDetails,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(21),
                  ),
                  child: Stack(
                    children: [
                      ProjectCarousel(
                        images: project.images,
                        semanticLabel: project.title,
                        highlighted: _hover,
                      ),
                      Positioned(
                        top: 14,
                        left: 14,
                        child: IgnorePointer(
                          child: _CategoryChip(label: project.category),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _ProjectSummary(
                project: project,
                showActions: showDetails,
                onTap: _openDetails,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;

  const _CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _ProjectSummary extends StatelessWidget {
  final Project project;
  final bool showActions;
  final VoidCallback onTap;

  const _ProjectSummary({
    required this.project,
    required this.showActions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        project.icon,
                        width: 38,
                        height: 38,
                        fit: BoxFit.cover,
                        cacheWidth: 114,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 38,
                          height: 38,
                          color: context.surfaceAlt,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        project.title,
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: context.textColor,
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: context.surfaceAlt,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.arrow_outward_rounded,
                        size: 18,
                        color: context.muted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  project.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: showActions
                ? ProjectHoverActions(project: project)
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
