import 'package:fake_it/pages/login_page.dart';
import 'package:fake_it/pages/news_feed_page.dart';
import 'package:fake_it/services/flutterfire_services.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:fake_it/widgets/app_logo.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    init();
  }

  init() async {
    await Tools.iniFirebase();

    await Tools.checkUpdate(context);

    if (Fire.connectedUser == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) {
        return const LoginPage();
      }));
    } else {
      await Fire.getAllStories();
      await Fire.getAllPosts();
      // await Fire.getAllProfiles();

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) {
        return const NewsFeed();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Tools.height(context),
        width: Tools.width(context),
        color: Prefs.isDarkMode ? S.colors.dark : S.colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppLogo(
                size: 200.0,
                color: Prefs.isDarkMode ? S.colors.white : S.colors.dark,
              ),
              SizedBox(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator(
                  color: Prefs.isDarkMode ? S.colors.light : S.colors.dark,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
