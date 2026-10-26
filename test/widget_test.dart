import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:new_portfolio/main.dart';

void main() {
  testWidgets('renders the hero name (mobile layout)', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 100));

    expect(tester.takeException(), isNull);
    expect(find.textContaining('Moatamed Wageh'), findsWidgets);

    // Unmount so repeating animation timers are cancelled before teardown.
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('desktop layout renders without layout exceptions', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 100));

    // Would surface the RenderShrinkWrappingViewport intrinsic-dimension error.
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox());
  });
}
