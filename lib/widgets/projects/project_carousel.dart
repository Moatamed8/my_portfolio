import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

/// Image carousel for a project card.
///
/// The heavy WebP is not requested until the card is near the viewport, and
/// only the next/previous slide is decoded ahead of the one on screen.
class ProjectCarousel extends StatefulWidget {
  final List<String> images;
  final String semanticLabel;
  final bool highlighted;

  const ProjectCarousel({
    super.key,
    required this.images,
    required this.semanticLabel,
    this.highlighted = false,
  });

  @override
  State<ProjectCarousel> createState() => _ProjectCarouselState();
}

class _ProjectCarouselState extends State<ProjectCarousel> {
  static const double _aspectRatio = 16 / 9;
  static const int _maxDecodeWidth = 1440;

  final Set<int> _precached = <int>{};

  PageController? _controller;
  ScrollPosition? _position;
  int _index = 0;
  int? _warmedFor;
  bool _active = false;
  bool _checkScheduled = false;

  bool get _canSlide => widget.images.length > 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final next = Scrollable.maybeOf(context)?.position;
    if (!identical(next, _position)) {
      _position?.removeListener(_onScroll);
      _position = next;
      if (!_active && _position != null) {
        _position!.addListener(_onScroll);
      }
    }
    _scheduleCheck();
  }

  @override
  void didUpdateWidget(ProjectCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_index >= widget.images.length) {
      _index = 0;
      _controller?.jumpToPage(0);
    }
  }

  void _scheduleCheck() {
    if (_active || _checkScheduled) return;
    _checkScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScheduled = false;
      if (mounted) _onScroll();
    });
  }

  void _onScroll() {
    if (_active || !mounted) return;
    if (_position == null || _isNearViewport()) _activate();
  }

  bool _isNearViewport() {
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.hasSize || !box.attached) return false;
    final top = box.localToGlobal(Offset.zero).dy;
    final bottom = top + box.size.height;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return bottom > -240 && top < screenHeight + 240;
  }

  void _activate() {
    if (_active) return;
    _active = true;
    _controller ??= PageController();
    _position?.removeListener(_onScroll);
    if (mounted) setState(() {});
  }

  void _scheduleWarm(int index) {
    if (_warmedFor == index) return;
    _warmedFor = index;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || index != _index) return;
      _warmAround(index);
    });
  }

  void _warmAround(int index) {
    for (final neighbor in [index - 1, index + 1]) {
      if (neighbor < 0 || neighbor >= widget.images.length) continue;
      if (!_precached.add(neighbor)) continue;
      unawaited(_precache(widget.images[neighbor]));
    }
  }

  Future<void> _precache(String asset) async {
    try {
      await precacheImage(AssetImage(asset), context);
    } catch (_) {
      // A failed prefetch should not break the slide the user can already see.
    }
  }

  void _goTo(int index) {
    final controller = _controller;
    if (controller == null || !_canSlide) return;
    final count = widget.images.length;
    final next = (index + count) % count;
    controller.animateToPage(
      next,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _position?.removeListener(_onScroll);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cacheWidth = _cacheWidth(constraints.maxWidth);
        return Semantics(
          container: true,
          label: _canSlide
              ? 'Image ${_index + 1} of ${widget.images.length}'
              : widget.semanticLabel,
          child: AspectRatio(
            aspectRatio: _aspectRatio,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ColoredBox(color: context.surfaceAlt),
                if (_active)
                  ScrollConfiguration(
                    behavior: const _CarouselScrollBehavior(),
                    child: AnimatedScale(
                      scale: widget.highlighted ? 1.06 : 1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                      child: PageView.builder(
                        controller: _controller,
                        itemCount: widget.images.length,
                        physics: _canSlide
                            ? const PageScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) {
                          setState(() => _index = index);
                          _scheduleWarm(index);
                        },
                        itemBuilder: (context, index) {
                          return _CarouselImage(
                            asset: widget.images[index],
                            cacheWidth: cacheWidth,
                            onDisplayed: () => _scheduleWarm(index),
                          );
                        },
                      ),
                    ),
                  ),
                if (_active && _canSlide) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _CarouselArrow(
                      icon: Icons.chevron_left_rounded,
                      tooltip: 'Previous image',
                      onPressed: () => _goTo(_index - 1),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: _CarouselArrow(
                      icon: Icons.chevron_right_rounded,
                      tooltip: 'Next image',
                      onPressed: () => _goTo(_index + 1),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _CarouselDots(
                        count: widget.images.length,
                        index: _index,
                        onSelect: _goTo,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  int? _cacheWidth(double logicalWidth) {
    if (!logicalWidth.isFinite || logicalWidth <= 0) return null;
    final pixels = logicalWidth * MediaQuery.devicePixelRatioOf(context);
    return pixels.round().clamp(1, _maxDecodeWidth).toInt();
  }
}

class _CarouselImage extends StatelessWidget {
  final String asset;
  final int? cacheWidth;
  final VoidCallback onDisplayed;

  const _CarouselImage({
    required this.asset,
    required this.cacheWidth,
    required this.onDisplayed,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      cacheWidth: cacheWidth,
      filterQuality: FilterQuality.medium,
      gaplessPlayback: true,
      excludeFromSemantics: true,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (frame != null) onDisplayed();
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,
          child: child,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const DecoratedBox(
          decoration: BoxDecoration(gradient: AppColors.brandGradient),
        );
      },
    );
  }
}

class _CarouselArrow extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _CarouselArrow({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onPressed,
          child: Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                shape: BoxShape.circle,
              ),
              child: SizedBox(
                width: 34,
                height: 34,
                child: Icon(icon, color: Colors.white, size: 22),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CarouselDots extends StatelessWidget {
  final int count;
  final int index;
  final ValueChanged<int> onSelect;

  const _CarouselDots({
    required this.count,
    required this.index,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.32),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < count; i++)
              Semantics(
                button: true,
                label: 'Show image ${i + 1}',
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onSelect(i),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 3,
                      vertical: 4,
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      width: i == index ? 16 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(
                          alpha: i == index ? 1 : 0.55,
                        ),
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Lets a mouse drag the carousel without changing the page scroll behavior.
class _CarouselScrollBehavior extends MaterialScrollBehavior {
  const _CarouselScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => const {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.trackpad,
  };
}
