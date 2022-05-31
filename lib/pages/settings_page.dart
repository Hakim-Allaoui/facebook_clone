import 'package:easy_localization/easy_localization.dart';
import 'package:fake_it/main.dart';
import 'package:fake_it/pages/splash_page.dart';
import 'package:fake_it/services/flutterfire_services.dart';
import 'package:fake_it/utils/constants.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:fake_it/widgets/profile_pic_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String lang = Prefs.getCurrentLang();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Prefs(),
      child: Consumer<Prefs>(
        builder: (BuildContext context, prefs, Widget? child) {
          return Scaffold(
            backgroundColor: Prefs.isDarkMode ? S.colors.dark : S.colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Prefs.isDarkMode ? S.colors.light : S.colors.dark,
              ),
              title: Text(
                "settings".tr(),
                style: TextStyle(
                    color: Prefs.isDarkMode ? S.colors.light : S.colors.dark),
              ),
              centerTitle: true,
              elevation: 0.0,
            ),
            body: Column(
              children: [
                SettingsTile(
                  child: ListTile(
                    leading: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ProfilePic(
                          path: Fire.connectedUser?.profile.photoPath,
                          size: 50.0,
                          onSelected: (img) async {
                            if (img != null) {
                              Fire.connectedUser!.profile.photoPath = img.path;
                              setState(() {});
                            }
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Prefs.isDarkMode
                                ? S.colors.light.withOpacity(.8)
                                : S.colors.dark.withOpacity(.8),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Iconsax.camera,
                            size: 10.0,
                            color: Prefs.isDarkMode
                                ? S.colors.dark
                                : S.colors.light,
                          ),
                        ),
                      ],
                    ),
                    title: Text(Fire.connectedUser!.username!),
                    subtitle: Text(Fire.connectedUser!.email!),
                    onTap: () async {},
                  ),
                ),
                const SizedBox(height: 8.0),
                SettingsTile(
                  child: ListTile(
                    leading: Prefs.isDarkMode
                        ? Icon(
                            Iconsax.sun_1,
                            color: S.colors.white,
                          )
                        : Icon(
                            Iconsax.moon,
                            color: S.colors.dark,
                          ),
                    title: Text("dark_mode".tr()),
                    onTap: () async {
                      prefs.setDarkMode(context, !Prefs.isDarkMode);
                    },
                    trailing: Switch(
                      activeColor: S.colors.white,
                      value: Prefs.isDarkMode,
                      onChanged: (val) {
                        prefs.setDarkMode(context, val);
                      },
                    ),
                  ),
                ),
                SettingsTile(
                  child: ListTile(
                    leading: Icon(
                      Iconsax.language_square4,
                      color: Prefs.isDarkMode ? S.colors.white : S.colors.dark,
                    ),
                    title: const Text("language").tr(),
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        isDismissible: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return DraggableScrollableSheet(
                              initialChildSize: 0.9,
                              maxChildSize: 1,
                              minChildSize: 0.75,
                              expand: true,
                              builder: (context, scrollController) {
                                return Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15)),
                                    color: Prefs.isDarkMode
                                        ? S.colors.dark
                                        : S.colors.lightGrey,
                                  ),
                                  child: ListView(
                                      children:
                                          Strings.languageCodes.map((lang) {
                                    return SettingsTile(
                                      child: ListTile(
                                        title: Text(Strings.languages[Strings
                                            .languageCodes
                                            .indexOf(lang)]),
                                        trailing: Radio(
                                          value: lang,
                                          groupValue: Prefs.getCurrentLang(),
                                          onChanged: (val) {},
                                        ),
                                        onTap: () async {
                                          Tools.changeLang(context, lang);
                                          RestartWidget.restartApp(context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    );
                                  }).toList()),
                                );
                              });
                        },
                      );
                    },
                  ),
                ),
                SettingsTile(
                  child: ListTile(
                    leading: Icon(
                      Iconsax.translate,
                      color: Prefs.isDarkMode ? S.colors.white : S.colors.dark,
                    ),
                    title: const Text(
                      "help_translate",
                    ).tr(),
                    onTap: () async {
                      Tools.launchURL(
                          'mailto:${Strings.contactEmail}?subject=Help%20Translate%20${Tools.packageInfo.appName.split(' ').join('%20')}');
                    },
                  ),
                ),
                SettingsTile(
                  child: ListTile(
                    leading: const Icon(
                      Iconsax.arrow_left,
                      color: Colors.redAccent,
                    ),
                    title: const Text(
                      "logout",
                      style: TextStyle(color: Colors.redAccent),
                    ).tr(),
                    onTap: () async {
                      await Fire.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) {
                        return const SplashPage();
                      }));
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Prefs.isDarkMode ? S.colors.black : S.colors.light,
        ),
        child: child,
      ),
    );
  }
}
