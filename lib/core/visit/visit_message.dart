import 'dart:convert';

const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

/// Africa/Cairo wall time.
///
/// Egypt is UTC+3 from the last Friday in April (00:00 standard time)
/// until the last Thursday in October (24:00 summer time), then UTC+2.
String formatEgyptTime(DateTime utc) {
  final instant = utc.toUtc();
  final wall = instant.add(Duration(hours: _isEgyptSummer(instant) ? 3 : 2));
  final hour24 = wall.hour;
  final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
  final minute = wall.minute.toString().padLeft(2, '0');
  final period = hour24 >= 12 ? 'PM' : 'AM';
  final month = _months[wall.month - 1];
  return '${wall.day} $month ${wall.year}, $hour12:$minute $period';
}

bool _isEgyptSummer(DateTime utc) {
  final start = _dstStartUtc(utc.year);
  final end = _dstEndUtc(utc.year);
  return !utc.isBefore(start) && utc.isBefore(end);
}

/// Friday 00:00 at UTC+2, expressed in UTC.
DateTime _dstStartUtc(int year) {
  final friday = _lastWeekday(year, DateTime.april, DateTime.friday);
  return DateTime.utc(
    friday.year,
    friday.month,
    friday.day,
  ).subtract(const Duration(hours: 2));
}

/// Thursday 21:00 UTC, when clocks leave UTC+3.
DateTime _dstEndUtc(int year) {
  final thursday = _lastWeekday(year, DateTime.october, DateTime.thursday);
  return DateTime.utc(thursday.year, thursday.month, thursday.day, 21);
}

DateTime _lastWeekday(int year, int month, int weekday) {
  final last = DateTime.utc(year, month + 1, 0);
  var delta = last.weekday - weekday;
  if (delta < 0) delta += 7;
  return DateTime.utc(year, month, last.day - delta);
}

/// A short device label from a browser user agent.
String deviceLabel(String userAgent) {
  final ua = userAgent.toLowerCase();
  if (ua.contains('ipad')) return 'Tablet · iPad';
  if (ua.contains('iphone') || ua.contains('ipod')) return 'Mobile · iPhone';
  final android = ua.contains('android');
  if (android && !ua.contains('mobile')) return 'Tablet · Android';
  if (android) return 'Mobile · Android';
  if (ua.contains('windows')) return 'Desktop · Windows';
  if (ua.contains('mac os') || ua.contains('macintosh')) {
    return 'Desktop · Mac';
  }
  if (ua.contains('cros')) return 'Desktop · ChromeOS';
  if (ua.contains('linux')) return 'Desktop · Linux';
  if (ua.contains('tablet')) return 'Tablet';
  if (ua.contains('mobile')) return 'Mobile';
  return 'Desktop';
}

({String country, String city}) parsePlace(String? raw) {
  const unknown = (country: 'Unknown', city: 'Unknown');
  if (raw == null || raw.isEmpty) return unknown;
  try {
    final decoded = jsonDecode(raw);
    if (decoded is! Map) return unknown;
    final data = decoded.map((key, value) => MapEntry(key.toString(), value));
    if (data['error'] == true) return unknown;
    if (data['success'] == false) return unknown;
    final country = _field(data, const ['country_name', 'country']);
    final city = _field(data, const ['city', 'region']);
    if (country == 'Unknown' && city == 'Unknown') return unknown;
    return (country: country, city: city);
  } catch (_) {
    return unknown;
  }
}

String _field(Map<String, Object?> data, List<String> keys) {
  for (final key in keys) {
    final text = data[key]?.toString().trim() ?? '';
    if (text.isNotEmpty && text.toLowerCase() != 'null') return text;
  }
  return 'Unknown';
}

String buildVisitMessage({
  required String country,
  required String city,
  required String egyptTime,
  required String device,
}) {
  return '''
New portfolio visit

Country: $country
Time (Egypt): $egyptTime
City: $city
Device: $device''';
}
