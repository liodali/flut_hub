import 'package:clock/clock.dart';
import 'package:flut_hub_domain/src/common/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  withClock(Clock.fixed(DateTime(2021, 11, 12,14,30,00)), () async {
    setNow(clock.now());
    test("test date difference week result", () async {
      DateTime d = DateTime(2021, 10, 22, 11, 00, 00, 00);
      String days = differenceDaysFromNow(d);
      expect(days, "3w");
    });
    test("test date difference days", () async {
      DateTime d = DateTime(2021, 11, 10, 11, 00, 00, 00);
      String days = differenceDaysFromNow(d);
      expect(days, "2d");
    });
    test("test date difference months", () async {
      DateTime d = DateTime(2021, 09, 26, 11, 00, 00, 00);
      String days = differenceDaysFromNow(d);
      expect(days, "2mo");
    });
    test("test date difference same day", () async {
      DateTime d = DateTime(2021, 11, 12, 10, 15, 23, 00);
      String days = differenceDaysFromNow(d);
      expect(days, "10:15");
    });
    test("test format", () {
      DateTime d = format.parse("2021-11-12T10:24:32Z");
      DateTime other = DateTime(2021, 11, 12, 10, 24, 32, 00);
      expect(d, other);
    });
  });
}
