import 'dart:convert';
import 'dart:html' as html;

import 'package:http/http.dart' as http;
import 'package:mysite/changes/telegram.dart';

Future<void> notifyPortfolioVisit() async {
  if (telegramBotToken.isEmpty || telegramChatId.isEmpty) return;

  try {
    final storage = html.window.sessionStorage;

    // Prevent multiple notifications in the same browser session.
    if (storage['portfolio_visit_notified'] == '1') return;

    storage['portfolio_visit_notified'] = '1';
  } catch (_) {}

  final navigator = html.window.navigator;
  final location = html.window.location;

  // -----------------------------
  // Basic browser information
  // -----------------------------

  final referrer = html.document.referrer;

  final userAgent = navigator.userAgent.replaceAll('\n', ' ');

  final language = navigator.language;

  final screenWidth = html.window.screen?.width;
  final screenHeight = html.window.screen?.height;

  // -----------------------------
  // Detect device
  // -----------------------------

  String device = 'Desktop';

  if (userAgent.contains(RegExp(
    r'Mobile|Android|iPhone|iPad|iPod',
    caseSensitive: false,
  ))) {
    device = 'Mobile';
  }

  if (userAgent.contains('iPad')) {
    device = 'Tablet';
  }

  // -----------------------------
  // Detect operating system
  // -----------------------------

  String os = 'Unknown';

  if (userAgent.contains('Windows')) {
    os = 'Windows';
  } else if (userAgent.contains('Mac OS X')) {
    os = 'macOS';
  } else if (userAgent.contains('Android')) {
    os = 'Android';
  } else if (userAgent.contains('iPhone') ||
      userAgent.contains('iPad') ||
      userAgent.contains('iPod')) {
    os = 'iOS';
  } else if (userAgent.contains('Linux')) {
    os = 'Linux';
  }

  // -----------------------------
  // Detect browser
  // -----------------------------

  String browser = 'Unknown';

  if (userAgent.contains('Edg/')) {
    browser = 'Microsoft Edge';
  } else if (userAgent.contains('OPR/')) {
    browser = 'Opera';
  } else if (userAgent.contains('Chrome/') &&
      !userAgent.contains('Edg/')) {
    browser = 'Google Chrome';
  } else if (userAgent.contains('Firefox/')) {
    browser = 'Firefox';
  } else if (userAgent.contains('Safari/') &&
      !userAgent.contains('Chrome/')) {
    browser = 'Safari';
  }

  // -----------------------------
  // UTM tracking
  // -----------------------------

  final uri = Uri.parse(location.href);

  final utmSource =
      uri.queryParameters['utm_source'] ?? 'unknown';

  final utmMedium =
      uri.queryParameters['utm_medium'] ?? 'unknown';

  final utmCampaign =
      uri.queryParameters['utm_campaign'] ?? 'unknown';

  // -----------------------------
  // Get IP + location
  // -----------------------------

  String ip = 'Unknown';
  String country = 'Unknown';
  String countryCode = 'Unknown';
  String city = 'Unknown';
  String region = 'Unknown';
  String timezone = 'Unknown';

  try {
    final response = await http.get(
      Uri.parse('https://ipapi.co/json/'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      ip = data['ip']?.toString() ?? 'Unknown';
      country = data['country_name']?.toString() ?? 'Unknown';
      countryCode = data['country_code']?.toString() ?? 'Unknown';
      city = data['city']?.toString() ?? 'Unknown';
      region = data['region']?.toString() ?? 'Unknown';
      timezone = data['timezone']?.toString() ?? 'Unknown';
    }
  } catch (_) {
    // Keep default values if location API fails.
  }

  // -----------------------------
  // Build Telegram message
  // -----------------------------

  final text = StringBuffer()
    ..writeln('🚀 New Portfolio Visit')
    ..writeln()
    ..writeln(
      '🕐 Time: ${DateTime.now().toUtc().toIso8601String()}',
    )
    ..writeln()
    ..writeln('🌍 LOCATION')
    ..writeln('Country: $country ($countryCode)')
    ..writeln('City: $city')
    ..writeln('Region: $region')
    ..writeln('Timezone: $timezone')
    ..writeln('IP: $ip')
    ..writeln()
    ..writeln('🔗 SOURCE')
    ..writeln(
      'UTM Source: $utmSource',
    )
    ..writeln(
      'UTM Medium: $utmMedium',
    )
    ..writeln(
      'UTM Campaign: $utmCampaign',
    )
    ..writeln(
      'Referrer: ${referrer.isEmpty ? 'Direct / Unknown' : referrer}',
    )
    ..writeln()
    ..writeln('💻 DEVICE')
    ..writeln('Type: $device')
    ..writeln('OS: $os')
    ..writeln('Browser: $browser')
    ..writeln('Language: $language')
    ..writeln(
      'Screen: ${screenWidth ?? '?'} x ${screenHeight ?? '?'}',
    )
    ..writeln()
    ..writeln('📄 PAGE')
    ..writeln('URL: ${location.href}')
    ..writeln()
    ..writeln('🔎 USER AGENT')
    ..writeln(userAgent);

  // -----------------------------
  // Send to Telegram
  // -----------------------------

  final url = Uri.https(
    'api.telegram.org',
    '/bot$telegramBotToken/sendMessage',
    {
      'chat_id': telegramChatId,
      'text': text.toString(),
    },
  );

  html.ImageElement()
    ..src = url.toString();
}
