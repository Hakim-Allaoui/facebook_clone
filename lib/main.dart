import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:fake_it/pages/splash_page.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await Tools.initAppSettings();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('fr'),
        Locale('es'),
        Locale('vi'),
        Locale('pt'),
        Locale('it'),
      ],
      path: 'assets/translations/langs.csv',
      fallbackLocale: const Locale('en'),
      assetLoader: CsvAssetLoader(),
      child: const RestartWidget(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fake it',
      theme: S.lightTheme,
      darkTheme: S.darkTheme,
      themeMode: Prefs.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const SplashPage(),
    );
  }
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({Key? key, this.child}) : super(key: key);

  final Widget? child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}