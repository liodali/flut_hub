import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flut_hub_core/flut_hub_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../src/view_model/home_view_model.dart';
import '../src/views/pages/home.dart';
import 'src/common/app_localization.dart';
import 'src/common/routes.dart';

void main() {
  configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<HomeViewModel>(
          create: (ctx) => HomeViewModel(),
          dispose: (ctx, homeVM) => homeVM.dispose(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: "/",
        routes: {
          "/": (ctx) => const Home(),
        },
        onGenerateRoute: AppRouter.routes,
        theme: FlexColorScheme.dark(
          scheme: FlexScheme.damask,
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
        ).toTheme.copyWith(backgroundColor: const Color(0xFF1F1A18)),
        themeMode: ThemeMode.light,
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
      ),
    );
  }
}

