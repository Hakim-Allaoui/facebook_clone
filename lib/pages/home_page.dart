import 'package:easy_localization/easy_localization.dart';
import 'package:fake_it/pages/news_feed_page.dart';
import 'package:fake_it/pages/post_page.dart';
import 'package:fake_it/pages/settings_page.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:fake_it/widgets/app_logo.dart';
import 'package:fake_it/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Tools.confirmExitDialog(context),
      child: Scaffold(
        backgroundColor: Prefs.isDarkMode ? S.colors.dark : Colors.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            AppLogo(
                              color: Prefs.isDarkMode
                                  ? S.colors.light
                                  : S.colors.dark,
                              size: 120.0,
                            ),
                            SizedBox(
                              width: 28.0,
                              child: RawMaterialButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                        return const SettingsPage();
                                      }));
                                },
                                child: Icon(
                                  Iconsax.setting,
                                  color: Prefs.isDarkMode
                                      ? S.colors.white
                                      : S.colors.dark,
                                ),
                                shape: const CircleBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      MButton(
                        isDarkMode: Prefs.isDarkMode,
                        text: "create_post".tr(),
                        onClicked: () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                                return const PostPage();
                              }));
                        },
                        borderRadius: 8.0,
                        bgColor: S.colors.button,
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      MButton(
                        isDarkMode: Prefs.isDarkMode,
                        text: "news_feed".tr(),
                        onClicked: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (ctx) {
                                return const
                                NewsFeed();
                              }));
                        },
                        borderRadius: 8.0,
                        bgColor: S.colors.button,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
