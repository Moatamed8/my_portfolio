/// Non-web builds never report a visit.
bool get visitAlreadySent => true;

void markVisitSent() {}

String? get visitUserAgent => null;

Future<String?> readVisitText(String url) async => null;

Future<void> sendVisitBeacon(String url) async {}
