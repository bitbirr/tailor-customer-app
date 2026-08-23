import 'package:flutter_test/flutter_test.dart';
import 'package:tailor_customer_app/core/search.dart';

void main() {
  const search = SearchNormalizer();

  test('normalizes names without destroying extra words', () {
    expect(search.normalizeName('  Abebe   Kebede '), 'abebe kebede');
  });

  test('normalizes phones to digits only', () {
    expect(search.normalizePhone('+251 911-00-00-00'), '251911000000');
    expect(search.normalizePhone('n/a'), isNull);
  });

  test('escapes LIKE wildcards so user input cannot broaden a query', () {
    expect(search.escapeLike(r'100% off_sale'), r'100\% off\_sale');
    expect(search.escapeLike('a\\b'), r'a\\b');
    expect(search.likeContains('Abe%', phone: false), r'%abe\%%');
    expect(search.likeContains('911_00', phone: true), r'%911\_00%');
  });
}
