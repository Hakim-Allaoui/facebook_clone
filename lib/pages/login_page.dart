import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fake_it/pages/splash_page.dart';
import 'package:fake_it/services/flutterfire_services.dart';
import 'package:fake_it/utils/constants.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:fake_it/widgets/app_logo.dart';
import 'package:fake_it/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

enum AuthMode {
  signUp,
  signIn,
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthMode authMode = AuthMode.signUp;
  final GlobalKey<FormState> _formKey = GlobalKey();

  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  File? profilePic;

  bool isLoading = false;
  late FocusScopeNode currentFocus;

  @override
  Widget build(BuildContext context) {
    currentFocus = FocusScope.of(context);

    return WillPopScope(
      onWillPop: () => Tools.confirmExitDialog(context),
      child: Scaffold(
        backgroundColor: Prefs.isDarkMode ? S.colors.dark : Colors.white,
        // resizeToAvoidBottomInset: false,
        body: WillPopScope(
          onWillPop: () => Future.value(!isLoading),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: Tools.height(context),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AbsorbPointer(
                            absorbing: true,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppLogo(
                                        color: Prefs.isDarkMode
                                            ? S.colors.light
                                            : S.colors.dark,
                                        size: 80.0,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          authMode == AuthMode.signUp
                                              ? authMode = AuthMode.signIn
                                              : authMode = AuthMode.signUp;
                                          setState(() {});
                                        },
                                        child: Text(
                                          authMode == AuthMode.signIn
                                              ? "signup".tr()
                                              : "login".tr(),
                                          style: TextStyle(
                                            color: S.hkColors["blue"],
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: AnimatedCrossFade(
                                      alignment: Alignment.center,
                                      firstChild: Align(
                                        alignment: Alignment.center,
                                        child: Stack(
                                          alignment: Alignment.bottomRight,
                                          children: [
                                            SizedBox(
                                              height: 100.0,
                                              width: 100.0,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100.0),
                                                child: profilePic != null
                                                    ? Image.file(profilePic!,
                                                        fit: BoxFit.cover)
                                                    : Image.asset(
                                                        'assets/images/profile.png',
                                                        fit: BoxFit.cover),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 35.0,
                                              child: Container(
                                                padding: const EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                  color: Prefs.isDarkMode
                                                      ? S.colors.light.withOpacity(.5)
                                                      : S.colors.dark.withOpacity(.5),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: RawMaterialButton(
                                                  onPressed: () async {
                                                    profilePic =
                                                        await Tools.pickImages();
                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    Iconsax.camera,
                                                    color: Prefs.isDarkMode
                                                        ? S.colors.dark
                                                        : S.colors.light,
                                                  ),
                                                  elevation: .0,
                                                  padding: const EdgeInsets.all(0.0),
                                                  shape: const CircleBorder(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      sizeCurve: Curves.linearToEaseOut,
                                      secondChild: const SizedBox(),
                                      crossFadeState: authMode == AuthMode.signUp
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond,
                                      duration: const Duration(milliseconds: 500)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "email".tr(),
                                  ),
                                ),
                                MTextField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  onSubmit: (val) => submit(),
                                ),
                                Column(
                                  children: [
                                    authMode == AuthMode.signUp
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 8.0,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Text(
                                                  "username".tr().replaceAll("\\n", "\n"),
                                                ),
                                              ),
                                              MTextField(
                                                keyboardType: TextInputType.emailAddress,
                                                controller: usernameController,
                                                onSubmit: (val) => submit(),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text("password".tr()),
                                ),
                                MTextField(
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: passwordController,
                                  obscureText: true,
                                  onSubmit: (val) => submit(),
                                ),
                                authMode == AuthMode.signUp
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text("confirm_Password".tr()),
                                          ),
                                          MTextField(
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            controller: confirmPasswordController,
                                            obscureText: true,
                                            onSubmit: (val) => submit(),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          MButton(
                            isDarkMode: Prefs.isDarkMode,
                            text: authMode == AuthMode.signUp
                                ? "signup".tr()
                                : "login".tr(),
                            onClicked: submit,
                            borderRadius: 8.0,
                            bgColor: isLoading
                                ? S.colors.lightGrey
                                : S.colors.button,
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          authMode == AuthMode.signIn
                              ? Center(
                                  child: TextButton(
                                    onPressed: () {
                                      //TODO: Password recovery
                                    },
                                    child: Text(
                                      "forget_password".tr(),
                                      style: TextStyle(
                                        color: S.hkColors["blue"],
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              isLoading
                  ? Container(
                      height: Tools.height(context),
                      width: Tools.width(context),
                      color: Colors.transparent,
                      child: const SafeArea(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                              height: 2.0, child: LinearProgressIndicator()),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  void submit() async {
    currentFocus.unfocus();

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = true;
    });
    try {
      if (authMode == AuthMode.signUp) {
        await Fire.signUp(
          username: usernameController.text,
          email: emailController.text,
          password: passwordController.text,
          profilePic: profilePic,
          context: context,
        );

      } else {
        await Fire.signIn(
            email: emailController.text, password: passwordController.text);
      }

      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return const SplashPage();
      }));

      return;
    } catch (error) {
      Tools.logger.e("Sign Up Error: " + error.toString());

      Tools.showErrorDialog(
          context: context, error: Strings.handleAuthError(error.toString()));
    }

    setState(() {
      isLoading = false;
    });
  }

  looseAllFocus() {
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
