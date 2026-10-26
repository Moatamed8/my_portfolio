// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:async';
import 'dart:html' as html;

/// Fades out and removes the HTML loading screen defined in `web/index.html`
/// once the Flutter app has rendered its first frame.
void removeSplash() {
  final el = html.document.getElementById('loading');
  if (el == null) return;
  el.classes.add('loaded');
  html.document.body?.style.overflow = 'visible';
  Timer(const Duration(milliseconds: 700), el.remove);
}
