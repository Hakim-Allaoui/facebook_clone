import 'package:easy_localization/easy_localization.dart';
import 'package:fake_it/main.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Prefs extends ChangeNotifier {
  static late SharedPreferences instance;

  static Future<void> initPrefs() async {
    instance = await SharedPreferences.getInstance();
  }

  setDarkMode(BuildContext context, bool isDarkMode) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            color: Prefs.isDarkMode ? S.colors.dark : Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("app_will_restart".tr()),
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  TextButton(
                    onPressed: () {
                      isDarkMode = isDarkMode;
                      instance.setBool('isDarkMode', isDarkMode);
                      Tools.switchStatusBarColor(isDarkMode);

                      RestartWidget.restartApp(context);
                      Navigator.pop(context);
                      return;
                    },
                    child: Text(
                      "yes".tr(),
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("no".tr()),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    // notifyListeners();
  }

  static setFirstRun(bool isFirstRun) async {
    await instance.setBool('isFirstTime', isFirstRun);
  }

  static bool isFirstRun() {
    bool isFirstTime = instance.getBool('isFirstTime') ?? true;
    return isFirstTime;
  }

  bool get isDarkM =>
      instance.getBool('isDarkMode') ??
      SchedulerBinding.instance.window.platformBrightness == Brightness.dark;

  static bool get isDarkMode =>
      instance.getBool('isDarkMode') ??
      SchedulerBinding.instance.window.platformBrightness == Brightness.dark;

  static setCurrentLang(String languageCode) async {
    await Prefs.instance.setString('lang', languageCode);
  }

  static getCurrentLang() => instance.getString('lang') ?? "en";
}
