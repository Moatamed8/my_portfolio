// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:async';
import 'dart:html' as html;

const _storageKey = 'mw_visit_sent';

bool get visitAlreadySent => html.window.sessionStorage[_storageKey] == '1';

void markVisitSent() {
  html.window.sessionStorage[_storageKey] = '1';
}

String? get visitUserAgent => html.window.navigator.userAgent;

Future<String?> readVisitText(String url) async {
  try {
    return await html.HttpRequest.getString(
      url,
    ).timeout(const Duration(seconds: 4));
  } catch (_) {
    return null;
  }
}

/// Sends without reading the response. Telegram does not allow browser CORS,
/// and a no-cors GET still delivers the message.
Future<void> sendVisitBeacon(String url) async {
  try {
    await html.window.fetch(url, {
      'method': 'GET',
      'mode': 'no-cors',
      'cache': 'no-store',
    });
  } catch (_) {}
}
