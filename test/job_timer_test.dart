import 'package:flut_hub/src/common/job_timer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test simple job timer", () async{
    var i = 0;
    final jobTimer = JobTimer(
        duration: const Duration(seconds: 2),
        callback: () {
          i++;
        });
    jobTimer.run();
    await Future.delayed(const Duration(seconds: 2));
    expect(i, 1);
    jobTimer.run();
    jobTimer.dispose();
    expect(i, 1);
    jobTimer.run();
    await Future.delayed(const Duration(seconds: 2));
    expect(i, 2);
  });
}
