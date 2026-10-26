import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/responsive.dart';
import '../sections/about/about_section.dart';
import '../sections/contact/contact_section.dart';
import '../sections/footer/footer.dart';
import '../sections/hero/hero_section.dart';
import '../sections/nav/nav_bar.dart';
import '../sections/projects/projects_section.dart';
import '../sections/services/services_section.dart';
import '../widgets/section_decor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _homeKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _servicesKey = GlobalKey();
  final _workKey = GlobalKey();
  final _contactKey = GlobalKey();

  static const double _navHeight = 72;

  bool _scrolled = false;
  bool _showTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final scrolled = offset > 24;
    final showTop = offset > 500;
    if (scrolled != _scrolled || showTop != _showTop) {
      setState(() {
        _scrolled = scrolled;
        _showTop = showTop;
      });
    }
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  void _toTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<NavItem> get _navItems => [
    NavItem('Home', () => _scrollTo(_homeKey)),
    NavItem('About', () => _scrollTo(_aboutKey)),
    NavItem('Services', () => _scrollTo(_servicesKey)),
    NavItem('Work', () => _scrollTo(_workKey)),
    NavItem('Contact', () => _scrollTo(_contactKey)),
  ];

  /// Invisible anchor that doubles as scroll-margin so content lands below the
  /// floating navbar (like CSS `scroll-margin-top`).
  Widget _anchor(GlobalKey key, {double extra = 40}) =>
      SizedBox(key: key, height: _navHeight + extra);

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final contentWidth = math.min(screenWidth, 1180.0);

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MobileDrawer(items: _navItems),
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 250),
        offset: _showTop ? Offset.zero : const Offset(0, 2),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: _showTop ? 1 : 0,
          child: FloatingActionButton(
            onPressed: _toTop,
            backgroundColor: AppColors.accent,
            foregroundColor: Colors.white,
            mini: true,
            child: const Icon(Icons.arrow_upward_rounded),
          ),
        ),
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: BackgroundDecor()),
          ScrollConfiguration(
            behavior: const _SmoothScrollBehavior(),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Center(
                child: SizedBox(
                  width: contentWidth,
                  child: Column(
                    children: [
                      SizedBox(key: _homeKey, height: _navHeight + 12),
                      HeroSection(onContact: () => _scrollTo(_contactKey)),
                      _anchor(_aboutKey, extra: isMobile ? 60 : 90),
                      const AboutSection(),
                      _anchor(_servicesKey, extra: isMobile ? 60 : 110),
                      const ServicesSection(),
                      _anchor(_workKey, extra: isMobile ? 60 : 110),
                      const ProjectsSection(),
                      _anchor(_contactKey, extra: isMobile ? 60 : 110),
                      const ContactSection(),
                      SizedBox(height: isMobile ? 60 : 90),
                      Footer(onTop: _toTop),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              items: _navItems,
              scrolled: _scrolled,
              onMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
            ),
          ),
        ],
      ),
    );
  }
}

/// Removes the Android glow and keeps scrolling consistent across platforms.
class _SmoothScrollBehavior extends MaterialScrollBehavior {
  const _SmoothScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) => child;
}
