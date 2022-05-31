import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Strings {
  static const String appName = "Fake it";
  static const String home = "Home";
  static const String rate = "Rate";
  static const String more = "More Apps";
  static const String about = "About";
  static const String login = "Login";
  static const String logout = "Logout";
  static const String privacy = "Privacy Policy";
  static const String contactEmail = "amgos@live.com";
  static const String storeId = "";

  static const String collectionPUsersPic = "UsersPics";
  static const String collectionProfilesPic = "ProfilesPics";
  static const String collectionCommentsPic = "CommentPics";
  static const String collectionRepliesPic = "RepliesPics";
  static const String collectionStoriesPic = "StoriesPics";
  static const String collectionPostsPics = "PostsPics";

  static const String packageName = "com.hvkiw.facebook_clone";

  static List<String> languages = [
    'English',
    'العربية',
    'Francais',
    'Spanish',
    'Vietnamese',
    'Portuguese',
    'Italian'
  ];

  static List<String> languageCodes = [
    'en',
    'ar',
    'fr',
    'es',
    'vi',
    'pt',
    'it',
  ];

  static List<String> reactionsList = [
    "like",
    "love",
    "care",
    "haha",
    "wow",
    "sad",
    "angry"
  ];

  static final List<String> bottomRowReactions = [
    "like_stroke",
    "like_fill",
    "love",
    "care",
    "haha",
    "wow",
    "sad",
    "angry",
  ];

  static final List<Color> bottomRowIconColors = [
    const Color(0xff373a39),
    const Color(0XFF5C94FF),
    const Color(0XFFE4455C),
    const Color(0XFFFFC33A),
    const Color(0XFFFFC33A),
    const Color(0XFFFFC33A),
    const Color(0XFFFFC33A),
    const Color(0XFFDC751E),
  ];

  static final List<Color> bottomRowIconColorsDark = [
    const Color(0xffB0B4B7),
    const Color(0XFF5C94FF),
    const Color(0XFFE4455C),
    const Color(0XFFFFC33A),
    const Color(0XFFFFC33A),
    const Color(0XFFFFC33A),
    const Color(0XFFFFC33A),
    const Color(0XFFDC751E),
  ];

  static handleAuthError(String error) {
    var errorMessage = 'auth_failed'.tr();
    if (error.toString().contains('email-already-in-use')) {
      errorMessage = 'email-already-in-use'.tr();
    } else if (error.toString().contains('invalid-email')) {
      errorMessage = 'invalid-email'.tr();
    } else if (error.toString().contains('weak-password')) {
      errorMessage = 'weak-password'.tr();
    } else if (error.toString().contains('wrong-password')) {
      errorMessage = 'wrong-password'.tr();
    } else if (error.toString().contains('user-not-found')) {
      errorMessage = 'user-not-found'.tr();
    } else if (error.toString().contains('email-already-in-use')) {
      errorMessage = 'user-not-found'.tr();
    } else if (error.toString().contains('user-disabled')) {
      errorMessage = """
        __${'account_suspended'.tr()}__
        ${'contact_us'.tr()} __[${Strings.contactEmail}](mailto:${Strings.contactEmail}?subject=Facebook%20Clone%20Account_Suspended)__ ${'more_information'.tr()}.
        """;
    }

    return errorMessage;
  }
}
