import 'package:flut_hub/src/common/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("test text coloration", () async {
    const title = "flutter/plugins";
    const titleSearch = "plug";
    final Color colorTitle = Colors.red;
    final textSpan = await compute(computeTextColorationSearch, [title, titleSearch, colorTitle]);
    final textSpanColors =
        textSpan.where((element) => element.style != null && element.style?.color == colorTitle);
    expect(textSpanColors.first.text!, titleSearch);
  });
}
