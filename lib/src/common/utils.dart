import 'package:flutter/material.dart';

final List<String> languages = [
  "",
  "java",
  "cpp",
  "dart",
  "kotlin",
  "objective-c",
  "swift",
  "python",
  "ruby",
  "rust",
  "c",
  "groovy",
  "r",
  "ada",
  "php",
  "javascript",
  "csharp",
  "fsharp",
  "assembly",
  "bash"
];

const sizeItem = 184.0;

List<TextSpan> computeTextColorationSearch(List<dynamic> data) {
  final String textToColor = data[1];
  final Color textColor = data[2];
  final String nameTitle = data[0];
  final String nameTitleLowerCase = nameTitle.toLowerCase();
  List<TextSpan> textsSpanTitle = [];
  List<String> searchWords = textToColor.toLowerCase().split(" ");

  /// 2. remove duplicated searchable text
  searchWords = Set<String>.from(searchWords).toList();

  /// 3. organize filter by length for more precision
  /// and save  existing  filters in title
  searchWords.sort((a, b) => b.length.compareTo(a.length));
  searchWords = searchWords
      .where(
          (searchWord) => searchWord.trim().isNotEmpty && nameTitleLowerCase.contains(searchWord))
      .map((searchWord) => searchWord.toLowerCase())
      .toList();

  /// 4. organize  filters with their position in title
  searchWords
      .sort((a, b) => nameTitleLowerCase.indexOf(a).compareTo(nameTitleLowerCase.indexOf(b)));
  String titleName = nameTitleLowerCase;
  searchWords.sort((a, b) {
    if (searchWords.indexOf(a) > 0) {
      titleName = titleName.replaceFirst(searchWords[searchWords.indexOf(a) - 1], "");
    }
    return (titleName.indexOf(a) == titleName.indexOf(b))
        ? b.length.compareTo(a.length)
        : titleName.indexOf(a).compareTo(titleName.indexOf(b));
  });

  String mtitle = nameTitle;
  textsSpanTitle = generateColorationText(mtitle,searchWords,textColor);
  return textsSpanTitle;
}

List<TextSpan> generateColorationText(String mtitle, List<String> searchWords, Color textColor) {
  List<TextSpan> textsSpanTitle = [];

  while (mtitle.isNotEmpty) {
    /// 5.search for existing filter and add it  to textSpanTitles and  remove it
    searchWords = searchWords
        .where((searchWord) =>
            searchWord.length <= mtitle.length && mtitle.toLowerCase().contains(searchWord))
        .toList();

    if (searchWords.isNotEmpty &&
        mtitle.toLowerCase().indexOf(searchWords.first.toLowerCase()) == 0) {
      textsSpanTitle.add(
        TextSpan(
          text: mtitle.substring(0, searchWords.first.length),
          style: TextStyle(color: textColor),
        ),
      );
      mtitle = mtitle.substring(searchWords.first.length);
      if (!mtitle.contains(searchWords.first)) {
        searchWords.removeAt(0);
        //mtitle = nameTitle;
      }
    } else if (searchWords.isNotEmpty && mtitle.toLowerCase().indexOf(searchWords.first) != 0) {
      String subText = mtitle.substring(0, mtitle.toLowerCase().indexOf(searchWords.first));
      bool isContain = searchWords.skip(1).where((words) => subText.toLowerCase().contains(words)).isNotEmpty;
      if (isContain) {
        List<TextSpan> innerSpansChildren =
            generateColorationText(subText, searchWords.skip(1).toList(), textColor);
        textsSpanTitle.addAll(innerSpansChildren);

      } else {
        textsSpanTitle.add(TextSpan(text: subText));

      }
      mtitle = mtitle.substring(mtitle.toLowerCase().indexOf(searchWords.first));
    } else {
      textsSpanTitle.add(
        TextSpan(text: mtitle.substring(0)),
      );
      mtitle = "";
    }
  }
  return textsSpanTitle;
}
