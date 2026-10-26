import 'dart:async';

import 'package:flutter/material.dart';

import '../core/app_colors.dart';

/// Typewriter-style text that cycles through a list of [roles].
class AnimatedRole extends StatefulWidget {
  final List<String> roles;
  final TextStyle style;

  const AnimatedRole({super.key, required this.roles, required this.style});

  @override
  State<AnimatedRole> createState() => _AnimatedRoleState();
}

class _AnimatedRoleState extends State<AnimatedRole> {
  int _roleIndex = 0;
  int _charCount = 0;
  bool _deleting = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _tick();
  }

  void _tick() {
    final current = widget.roles[_roleIndex];
    Duration next;

    if (!_deleting) {
      _charCount++;
      next = const Duration(milliseconds: 85);
      if (_charCount == current.length) {
        _deleting = true;
        next = const Duration(milliseconds: 1400);
      }
    } else {
      _charCount--;
      next = const Duration(milliseconds: 40);
      if (_charCount == 0) {
        _deleting = false;
        _roleIndex = (_roleIndex + 1) % widget.roles.length;
        next = const Duration(milliseconds: 250);
      }
    }

    if (mounted) setState(() {});
    _timer = Timer(next, _tick);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.roles[_roleIndex].substring(0, _charCount);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: ShaderMask(
            shaderCallback: (rect) =>
                AppColors.brandGradient.createShader(rect),
            child: Text(
              text,
              style: widget.style.copyWith(color: Colors.white),
            ),
          ),
        ),
        _Cursor(style: widget.style),
      ],
    );
  }
}

class _Cursor extends StatefulWidget {
  final TextStyle style;
  const _Cursor({required this.style});

  @override
  State<_Cursor> createState() => _CursorState();
}

class _CursorState extends State<_Cursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _c,
      child: Container(
        width: 3,
        height: (widget.style.fontSize ?? 24) * 0.95,
        margin: const EdgeInsets.only(left: 4, bottom: 2),
        decoration: BoxDecoration(
          color: AppColors.accent2,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
