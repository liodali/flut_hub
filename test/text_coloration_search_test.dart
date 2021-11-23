import 'package:flut_hub/src/common/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const title = "flutter/plugins";
  const titleSearch = "plug";

  test("test text coloration", () async {
    final Color colorTitle = Colors.red;
    final textSpan = await compute(computeTextColorationSearch, [title, titleSearch, colorTitle]);
    final textSpanColors =
        textSpan.where((element) => element.style != null && element.style?.color == colorTitle);
    expect(textSpanColors.first.text!, titleSearch);
  });
  test("test complex text coloration", () async {
    const title = "freeCodeCamp/freeCodeCamp";
    const titleSearch = "free Co";
    final Color colorTitle = Colors.red;
    final textSpan = await compute(computeTextColorationSearch, [title, titleSearch, colorTitle]);
    final textSpanColors =
    textSpan.where((element) => element.style != null && element.style?.color == colorTitle);
    expect(textSpanColors.length, 4);
  });
  test("test text coloration inside", () async {
    final Color colorTitle = Colors.red;
    final textSpans = TextSpan(children: [
      const TextSpan(
        text: "flutter/",
      ),
      TextSpan(
        text: "plug",
        style: TextStyle(
          color: colorTitle,
        ),
      ),
      const TextSpan(text: "ins"),
    ]);
    final resultTextSpan =
        await compute(computeTextColorationSearch, [title, titleSearch, colorTitle]);

    expect(TextSpan(children: resultTextSpan), textSpans);
  });
}
