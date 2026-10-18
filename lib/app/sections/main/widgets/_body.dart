part of '../main_section.dart';

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scrollProvider = Provider.of<ScrollProvider>(context);

    return ScrollConfiguration(
      behavior: _SmoothScrollBehavior(),
      child: ScrollablePositionedList.builder(
        padding: EdgeInsets.zero,
        itemCount: BodyUtils.views.length,
        itemBuilder: (context, index) => BodyUtils.views[index],
        itemScrollController: scrollProvider.itemScrollController,
        physics: const ClampingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
      ),
    );
  }
}

// Custom scroll behavior for smoother, faster scrolling
class _SmoothScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    );
  }

  @override
  Widget buildScrollbar(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
