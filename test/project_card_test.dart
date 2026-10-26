import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_portfolio/core/app_theme.dart';
import 'package:new_portfolio/data/portfolio_data.dart';
import 'package:new_portfolio/sections/projects/widgets/project_card.dart';

void main() {
  final multiImage = PortfolioData.projects.firstWhere(
    (project) => project.images.length > 1,
  );
  final singleImage = PortfolioData.projects.firstWhere(
    (project) => project.images.length == 1,
  );

  testWidgets(
    'carousel controls appear only when a project has several images',
    (tester) async {
      await _pumpCard(tester, ProjectCard(project: multiImage), desktop: true);

      expect(find.byTooltip('Next image'), findsOneWidget);
      expect(find.byTooltip('Previous image'), findsOneWidget);
      expect(
        find.bySemanticsLabel('Image 1 of ${multiImage.images.length}'),
        findsOneWidget,
      );

      await tester.tap(find.byTooltip('Next image'));
      await tester.pumpAndSettle();

      expect(
        find.bySemanticsLabel('Image 2 of ${multiImage.images.length}'),
        findsOneWidget,
      );
      expect(find.byTooltip('Close'), findsNothing);

      await _pumpCard(tester, ProjectCard(project: singleImage), desktop: true);
      expect(find.byTooltip('Next image'), findsNothing);
      expect(find.byTooltip('Previous image'), findsNothing);
    },
  );

  testWidgets('desktop hover reveals downloads and store buttons', (
    tester,
  ) async {
    await _pumpCard(tester, ProjectCard(project: multiImage), desktop: true);

    expect(find.textContaining('Downloads:'), findsNothing);

    final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await gesture.addPointer(location: const Offset(4, 4));
    addTearDown(gesture.removePointer);
    await gesture.moveTo(tester.getCenter(find.byType(ProjectCard)));
    await tester.pumpAndSettle();

    expect(find.text('Downloads: ${multiImage.downloads}'), findsOneWidget);
    expect(find.text('Google Play'), findsOneWidget);
    expect(find.text('App Store'), findsOneWidget);
  });

  testWidgets('tapping a project on a phone opens the same details', (
    tester,
  ) async {
    await _pumpCard(tester, ProjectCard(project: multiImage), desktop: false);

    await tester.tap(find.text(multiImage.title));
    await tester.pumpAndSettle();

    expect(find.text('Downloads: ${multiImage.downloads}'), findsOneWidget);
    expect(find.text('Google Play'), findsOneWidget);
    expect(find.text('App Store'), findsOneWidget);

    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Close'), findsNothing);
  });
}

Future<void> _pumpCard(
  WidgetTester tester,
  Widget card, {
  required bool desktop,
}) async {
  tester.view.physicalSize = desktop
      ? const Size(1280, 900)
      : const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(width: desktop ? 560 : 360, child: card),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump();
}
