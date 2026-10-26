import 'package:flutter_test/flutter_test.dart';
import 'package:new_portfolio/core/visit/visit_message.dart';

void main() {
  test('egypt time follows summer and winter offsets', () {
    expect(
      formatEgyptTime(DateTime.utc(2026, 10, 26, 23, 2)),
      '27 Oct 2026, 2:02 AM',
    );
    expect(
      formatEgyptTime(DateTime.utc(2026, 1, 15, 22, 30)),
      '16 Jan 2026, 12:30 AM',
    );
    expect(
      formatEgyptTime(DateTime.utc(2026, 4, 23, 21, 59)),
      '23 Apr 2026, 11:59 PM',
    );
    expect(
      formatEgyptTime(DateTime.utc(2026, 4, 23, 22)),
      '24 Apr 2026, 1:00 AM',
    );
    expect(
      formatEgyptTime(DateTime.utc(2026, 10, 29, 20, 59)),
      '29 Oct 2026, 11:59 PM',
    );
    expect(
      formatEgyptTime(DateTime.utc(2026, 10, 29, 21)),
      '29 Oct 2026, 11:00 PM',
    );
  });

  test('device label reads the user agent', () {
    expect(
      deviceLabel('Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X)'),
      'Mobile · iPhone',
    );
    expect(
      deviceLabel('Mozilla/5.0 (iPad; CPU OS 17_0 like Mac OS X)'),
      'Tablet · iPad',
    );
    expect(
      deviceLabel('Mozilla/5.0 (Linux; Android 14; Pixel 7) Mobile'),
      'Mobile · Android',
    );
    expect(
      deviceLabel('Mozilla/5.0 (Linux; Android 13; SM-X200)'),
      'Tablet · Android',
    );
    expect(
      deviceLabel('Mozilla/5.0 (Windows NT 10.0; Win64; x64)'),
      'Desktop · Windows',
    );
    expect(
      deviceLabel('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)'),
      'Desktop · Mac',
    );
    expect(deviceLabel(''), 'Desktop');
  });

  test('place parser reads country and city', () {
    expect(
      parsePlace(
        '{"success":true,"country":"Egypt","city":"Cairo","ip":"1.2.3.4"}',
      ),
      (country: 'Egypt', city: 'Cairo'),
    );
    expect(
      parsePlace('{"country_name":"Germany","city":"Berlin","ip":"8.8.8.8"}'),
      (country: 'Germany', city: 'Berlin'),
    );
    expect(parsePlace('{"success":false}'), (
      country: 'Unknown',
      city: 'Unknown',
    ));
    expect(parsePlace(null), (country: 'Unknown', city: 'Unknown'));
  });

  test('visit message keeps the requested fields', () {
    expect(
      buildVisitMessage(
        country: 'Egypt',
        city: 'Cairo',
        egyptTime: '27 Oct 2026, 2:02 AM',
        device: 'Desktop · Mac',
      ),
      '''
New portfolio visit

Country: Egypt
Time (Egypt): 27 Oct 2026, 2:02 AM
City: Cairo
Device: Desktop · Mac''',
    );
  });
}
