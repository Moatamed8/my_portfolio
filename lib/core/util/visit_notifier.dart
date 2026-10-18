import 'visit_notifier_stub.dart'
    if (dart.library.html) 'visit_notifier_web.dart' as impl;

void notifyPortfolioVisit() => impl.notifyPortfolioVisit();
