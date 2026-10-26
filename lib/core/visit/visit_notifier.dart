import 'package:flutter/foundation.dart';

import 'telegram_secrets.dart';
import 'visit_message.dart';
import 'visit_platform.dart';

bool _started = false;

/// Tells Telegram about this browser tab, once. Does nothing when the bot
/// token is missing or the app is not running on the web.
Future<void> notifyVisit() async {
  if (!kIsWeb || _started || !_configured) return;
  try {
    if (visitAlreadySent) return;
    _started = true;
    markVisitSent();
    final place = await _lookupPlace();
    final text = buildVisitMessage(
      country: place.country,
      city: place.city,
      egyptTime: formatEgyptTime(DateTime.now()),
      device: deviceLabel(visitUserAgent ?? ''),
    );
    final uri = Uri.parse(
      'https://api.telegram.org/bot$telegramBotToken/sendMessage',
    ).replace(queryParameters: {'chat_id': telegramChatId, 'text': text});
    await sendVisitBeacon(uri.toString());
  } catch (_) {}
}

bool get _configured =>
    telegramBotToken.isNotEmpty && telegramChatId.isNotEmpty;

const _placeUrls = [
  'https://get.geojs.io/v1/ip/geo.json',
  'https://ipwho.is/?fields=success,country,city,region',
  'https://ipapi.co/json/',
];

Future<({String country, String city})> _lookupPlace() async {
  for (final url in _placeUrls) {
    final place = parsePlace(await readVisitText(url));
    if (place.country != 'Unknown' || place.city != 'Unknown') return place;
  }
  return (country: 'Unknown', city: 'Unknown');
}
