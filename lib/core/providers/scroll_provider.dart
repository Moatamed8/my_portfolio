import 'package:flutter/cupertino.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ScrollProvider extends ChangeNotifier {
  final ItemScrollController itemScrollController = ItemScrollController();
  // Reduced duration for faster scrolling
  final scrollDuration = const Duration(milliseconds: 600);

  void jumpTo(int index) => itemScrollController.scrollTo(
      index: index,
      duration: scrollDuration,
      curve: Curves.fastOutSlowIn, // Smoother curve for better feel
      alignment: 0);
}
