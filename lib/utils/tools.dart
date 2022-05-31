import 'dart:io';

import 'package:fake_it/services/flutterfire_services.dart';
import 'package:fake_it/utils/shared_preferences.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/widgets/home_widgets.dart';
import 'package:fake_it/widgets/profile_pic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart' as intl;
export 'package:fake_it/utils/shared_preferences.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Tools {
  static late PackageInfo packageInfo;

  static initAppSettings() async {
    //Flutter Ensure Initialized
    WidgetsFlutterBinding.ensureInitialized();

    //ini Shared Preferences:
    await Prefs.initPrefs();
    switchStatusBarColor(Prefs.isDarkMode);

    //init Translation:
    await EasyLocalization.ensureInitialized();

    //init PackageInfo:
    packageInfo = await PackageInfo.fromPlatform();
  }

  static height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static Future<void> iniFirebase() async {

  }

  static bool isFirstRun() {
    bool isFirstTime = Prefs.instance.getBool('isFirstTime') ?? true;
    return isFirstTime;
  }

  static bool isRTL(BuildContext context) {
    return intl.Bidi.isRtlLanguage(
        Localizations.localeOf(context).languageCode);
  }

  static Future<File?> selectPic(BuildContext context) async {
    final picker = ImagePicker();
    File _image;

    final imageSource = await showModalBottomSheet<ImageSource>(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0))),
        builder: (BuildContext ctx) {
          return Wrap(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 4.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                        color: S.colors.lightGrey,
                        borderRadius: BorderRadius.circular(100.0)),
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: S.colors.lightGrey,
                      borderRadius: BorderRadius.circular(100.0)),
                  child: Icon(
                    Icons.image,
                    color: S.colors.darkGrey,
                  ),
                ),
                title: Text(
                  'gallery'.tr().replaceAll("\\n", "\n"),
                ),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: S.colors.lightGrey,
                      borderRadius: BorderRadius.circular(100.0)),
                  child: Icon(
                    Icons.camera_alt,
                    color: S.colors.darkGrey,
                  ),
                ),
                title: Text(
                  'camera'.tr().replaceAll("\\n", "\n"),
                ),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
            ],
          );
        });

    File newPic;
    if (imageSource != null) {
      final file = await picker.pickImage(source: imageSource);
      if (file != null) {
        _image = File(file.path);

        final newPath =
            '${(await getApplicationDocumentsDirectory()).path}/${_image.path.split('/').last}';
        if (!File(newPath).existsSync()) {
          newPic = await _image.copy(newPath);
          await _image.delete();
          return newPic;
        }
      }
    }

    return null;
  }

  static void switchStatusBarColor(bool isDarkMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDarkMode ? S.colors.dark : Colors.white,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isDarkMode ? S.colors.darker : Colors.white,
        systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
  }

  static var logger = Logger(
    printer: PrettyPrinter(methodCount: 2, colors: true, printEmojis: true),
  );

  static Future<dynamic> fetchRemoteConfig(String key) async {
    try {

      return "";
    } on Exception catch (e) {
      Tools.logger.e("Error remoteConfig: " + e.toString());
    }
  }

  static checkUpdate(BuildContext context) async {
  }

  static launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    try {
      await launchUrl(_url);
    } catch (e) {
      logger.wtf("error launch url Could not launch $_url \n error $e");
    }
  }

  static Future<dynamic> textEditDialog(
      {BuildContext? context,
      String text = "",
      int maxLines = 1,
      bool obscureText = false,
      bool? verifiedButton}) async {
    TextEditingController textController = TextEditingController();

    textController.text = text;

    return await showDialog(
        context: context!,
        builder: (builderContext) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            actionsPadding: const EdgeInsets.all(0.0),
            backgroundColor:
                Prefs.isDarkMode ? S.colors.darkGrey : S.colors.white,
            scrollable: true,
            contentPadding: const EdgeInsets.all(8.0),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Prefs.isDarkMode
                                  ? S.colors.dark
                                  : S.colors.light,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: MTextField(
                                controller: textController,
                                maxLines: maxLines,
                                keyboardType: maxLines == 1
                                    ? TextInputType.text
                                    : TextInputType.multiline,
                                onSubmit: (text) {},
                                obscureText: obscureText,
                              ),
                            ),
                          ),
                        ),
                        verifiedButton != null
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('verified'.tr()),
                                    IconButton(
                                      icon: SvgPicture.asset(
                                        'assets/icons/verified_badge.svg',
                                        width: 30.0,
                                        color: verifiedButton ?? false
                                            ? Colors.blue
                                            : S.colors.lightGrey,
                                      ),
                                      onPressed: () {
                                        if (verifiedButton != null) {
                                          verifiedButton = !verifiedButton!;
                                        }
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                );
              },
            ),
            actions: [
              SizedBox(
                width: 28.0,
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    return;
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  padding: const EdgeInsets.all(0.0),
                  shape: const CircleBorder(),
                ),
              ),
              SizedBox(
                width: 28.0,
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      "text": textController.text,
                      "verified": verifiedButton
                    });
                    return;
                  },
                  child: Icon(
                    Icons.done,
                    color: Prefs.isDarkMode
                        ? S.colors.lightGrey
                        : S.hkColors["greyDark"],
                  ),
                  elevation: .0,
                  padding: const EdgeInsets.all(0.0),
                  shape: const CircleBorder(),
                ),
              ),
            ],
          );
        });
  }

  static Future<bool> confirmExitDialog(BuildContext context) async {
    return await showModalBottomSheet(
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
              Text("do_you_want_to_exit".tr()),
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                      return;
                    },
                    child: Text(
                      "yes".tr(),
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                      return;
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
  }

  static Future<File?> pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final ImageCropper _imageCropper = ImageCropper();

    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 80,
    );

    if (image == null) {
      return null;
    }

    return await _imageCropper.cropImage(
        sourcePath: image.path,
        maxWidth: 800,
        maxHeight: 800,
        androidUiSettings: AndroidUiSettings(
          lockAspectRatio: false,
          toolbarTitle: 'edit'.tr().replaceAll("\\n", "\n"),
          toolbarColor: S.colors.dark,
          toolbarWidgetColor: S.colors.light,
        ));
  }

  static Future<List<XFile>?> pickMultiImages() async {
    final ImagePicker _picker = ImagePicker();

    final List<XFile>? images = await _picker.pickMultiImage(
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 80,
    );

    if (images == null) {
      return null;
    }

    return images;
  }

  static Future<void> changeLang(
      BuildContext context, String languageCode) async {
    context.setLocale(Locale(languageCode.split("_").first));
    Prefs.setCurrentLang(languageCode);
    await Fire.editUserLanguage(languageCode);
  }

  static void showErrorDialog(
      {required BuildContext context, required String error}) {
    showTopSnackBar(
      context,
      CustomSnackBar.error(message: error),
      displayDuration: const Duration(milliseconds: 1000),
    );
  }

  static Future<void> editPictures({
    required BuildContext context,
    required PostModel post,
    Function(int, List<String>)? onResult,
  }) async {
    TextEditingController textControllerPhotosCount = TextEditingController();

    textControllerPhotosCount.text = post.imagesNb.toString();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            backgroundColor:
                Prefs.isDarkMode ? S.colors.darkGrey : S.colors.white,
            scrollable: true,
            contentPadding: const EdgeInsets.all(8.0),
            content: StatefulBuilder(builder: (context, bottomSheetSetState) {
              return SizedBox(
                height: 400.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (post.imagesPath!.isNotEmpty)
                      ...post.imagesPath!.map((path) {
                        return Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Prefs.isDarkMode
                                    ? S.colors.dark
                                    : S.colors.light,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ImageWidget(
                                      height: 400.0,
                                      path: path,
                                      radius: 15.0,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Iconsax.gallery_edit,
                                      color: Prefs.isDarkMode
                                          ? S.colors.light
                                          : S.colors.dark,
                                    ),
                                    onPressed: () async {
                                      var myImage = await Tools.pickImages();

                                      if (myImage != null) {
                                        post.imagesPath![post.imagesPath!
                                            .indexOf(path)] = myImage.path;
                                        bottomSheetSetState(() {});
                                      }
                                    },
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      post.imagesPath!.removeAt(
                                          post.imagesPath!.indexOf(path));
                                      bottomSheetSetState(() {});
                                    },
                                    icon: const Icon(
                                      Iconsax.trash,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList()
                    else
                      Expanded(child: Center(child: Text("no_image".tr()))),
                    if (post.imagesPath!.length >= 5)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Prefs.isDarkMode
                                      ? S.colors.dark
                                      : S.colors.lightGrey,
                                ),
                                child: const Text('+')),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: SizedBox(
                                  height: 40.0,
                                  child: MTextField(
                                    controller: textControllerPhotosCount,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    onChange: (val) {
                                      post.imagesNb = int.parse(val);
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Prefs.isDarkMode
                                      ? S.colors.dark
                                      : S.colors.lightGrey,
                                ),
                                child: Text('photos'.tr())),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    MButton(
                      isDarkMode: Prefs.isDarkMode,
                      text: "add_images".tr(),
                      onClicked: post.imagesPath!.length >= 5
                          ? null
                          : () async {
                              var myImages = await Tools.pickMultiImages();

                              if (myImages != null && myImages.isNotEmpty) {
                                for (XFile file in myImages) {
                                  if (post.imagesPath!.length < 5) {
                                    post.imagesPath!.add(file.path);
                                  }

                                  bottomSheetSetState(() {});
                                }
                              }
                            },
                      borderRadius: 8.0,
                      bgColor: post.imagesPath!.length >= 5
                          ? S.colors.dark.withOpacity(0.3)
                          : S.colors.button,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 28.0,
                          child: RawMaterialButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.done,
                              color: Prefs.isDarkMode
                                  ? S.colors.lightGrey
                                  : S.hkColors["greyDark"],
                            ),
                            elevation: .0,
                            padding: const EdgeInsets.all(0.0),
                            shape: const CircleBorder(),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }));
      },
    );
  }

  static Future<bool> isConnectedToNetwork() async {
    final bool isConnectedToNetwork = await InternetConnectionChecker().hasConnection;
    Tools.logger.wtf("isConnectedToNetwork: " + isConnectedToNetwork.toString());
    return isConnectedToNetwork;
  }

  static waitingDialog(
      {required BuildContext context, required VoidCallback process}) async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {

          process();

          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            backgroundColor:
            Prefs.isDarkMode ? S.colors.darkGrey : S.colors.white,
            content: WillPopScope(
              onWillPop: () => Future.value(false),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("loading".tr()),
                  const SizedBox(
                    height: 40.0,
                  ),
                  SizedBox(
                    height: 40.0,
                    width: 40.0,
                    child: CircularProgressIndicator(
                      color: Prefs.isDarkMode ? S.colors.light : S.colors.dark,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
