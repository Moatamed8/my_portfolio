import 'package:flutter/material.dart';
import 'package:mysite/core/util/visit_notifier.dart';
import 'my_site.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  notifyPortfolioVisit();
  runApp(const MySite());
}
