import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyAppLocalizations {
  MyAppLocalizations(this.locale);

  final Locale locale;


  static MyAppLocalizations? of(BuildContext context) {
    return Localizations.of<MyAppLocalizations>(context, MyAppLocalizations);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title_app': 'Search Github Repository',
      'loading_text': 'Loading ...',
      'home_appbar_title': 'Github Repositories',
      'hint_search_text_field': 'Search for Repositories',
      'stars_title': 'Stars',
      'sort_title': 'Sort',
      'language_title': 'Language',
      'order_title': 'Order',
      'hint_min_text_field': 'min',
      'hint_max_text_field': 'max',
      'adv_filter_title': "Advanced Filter",
    },
    'fr': {
      'title_app': 'Search Github Repository',
      'loading_text': 'Chargement ...',
      'home_appbar_title': 'Github Repositories',
      'hint_search_text_field': 'Recherche ...',
      'stars_title': 'Stars',
      'sort_title': 'Sort',
      'order_title': 'Order',
      'language_title': 'Language',
      'hint_min_text_field': 'min',
      'hint_max_text_field': 'max',
      'adv_filter_title': "Advanced Filter",
    },
  };

  String get titleApp => _localizedValues[locale.languageCode]!['title_app']!;

  String get loadingText => _localizedValues[locale.languageCode]!['loading_text']!;

  String get homeTitles => _localizedValues[locale.languageCode]!['home_appbar_title']!;

  String get hintSearchRepoTextField =>
      _localizedValues[locale.languageCode]!['hint_search_text_field']!;

  String get starsTitleFilter => _localizedValues[locale.languageCode]!['stars_title']!;

  String get sortTitleFilter => _localizedValues[locale.languageCode]!['sort_title']!;

  String get orderTitleFilter => _localizedValues[locale.languageCode]!['order_title']!;

  String get languageTitleFilter => _localizedValues[locale.languageCode]!['language_title']!;

  String get hintMinTextField => _localizedValues[locale.languageCode]!['hint_min_text_field']!;

  String get hintMaxTextField => _localizedValues[locale.languageCode]!['hint_max_text_field']!;

  String get titleAdvFilter => _localizedValues[locale.languageCode]!['adv_filter_title']!;

  String get titleIssue => "Issues";

}

class AppLocalizationsDelegate extends LocalizationsDelegate<MyAppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fr'].contains(locale.languageCode);

  @override
  Future<MyAppLocalizations> load(Locale locale) {
    return SynchronousFuture<MyAppLocalizations>(MyAppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
