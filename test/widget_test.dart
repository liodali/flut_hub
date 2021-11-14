// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flut_hub/src/common/app_localization.dart';
import 'package:flut_hub/src/common/flut_hub_icons_icons.dart';
import 'package:flut_hub/src/view_model/home_view_model.dart';
import 'package:flut_hub/src/views/component/app_bar_search_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets("test search input", (WidgetTester tester) async {
    final homeVM = HomeViewModel();
    await tester.pumpWidget(MaterialApp(
      home: ChangeNotifierProvider.value(
        value: homeVM,
        child: const Scaffold(
          body: CustomScrollView(
            slivers: [
              AppBarSearchHome(),
            ],
          ),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('fr', ''), // English, no country code
      ],
    ));
    await tester.pump();
    await tester.tap(find.byType(TextField));
    await tester.pump();
    expect(find.byIcon(FlutHubIcons.leftArrow), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'flu');

    await tester.pump();
    expect(find.byIcon(Icons.close), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();
    expect(find.text("flu"), findsNothing);

  });
  testWidgets("test search input closed", (WidgetTester tester) async {
    final homeVM = HomeViewModel();
    await tester.pumpWidget(MaterialApp(
      home: ChangeNotifierProvider.value(
        value: homeVM,
        child: const Scaffold(
          body: CustomScrollView(
            slivers: [
              AppBarSearchHome(),
            ],
          ),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('fr', ''), // English, no country code
      ],
    ));
    await tester.pump();
    await tester.tap(find.byType(TextField));
    await tester.pump();
    expect(find.byIcon(FlutHubIcons.leftArrow), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'flu');

    await tester.pump();
    expect(find.byIcon(Icons.close), findsOneWidget);
    await tester.tap(find.byIcon(FlutHubIcons.leftArrow));
    await tester.pump();
    expect(find.text("flu"), findsOneWidget);
    expect(find.byIcon(Icons.close), findsNothing);

  });
}
