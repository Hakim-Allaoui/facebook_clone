import 'dart:io';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:fake_it/models/story_model.dart';
import 'package:fake_it/models/user_model.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:fake_it/widgets/home_widgets.dart';
import 'package:fake_it/widgets/profile_pic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Fire {
  static late UserModel? connectedUser = null;

  static Map<String, PostModel> posts = <String, PostModel>{};
  static Map<String, ProfileModel> profiles = <String, ProfileModel>{};
  static Map<String, StoryModel> stories = <String, StoryModel>{};

  static signIn({
    required String email,
    required String password,
  }) async {
    try {
      connectedUser = createUserInstance();
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      Tools.logger.e("Error AuthLog: " + e.toString());
    }
  }

  static signUp({
    required String username,
    required String email,
    required String password,
    File? profilePic,
    required BuildContext context,
  }) async {
    try {
      connectedUser = createUserInstance();
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      Tools.logger.e("Error AuthLog: " + e.toString());
    }
  }

  static signOut() async {
    await Future.delayed(const Duration(seconds: 1));
    Fire.posts.clear();
    Fire.stories.clear();
    Fire.profiles.clear();
    Fire.connectedUser = null;
  }

  static Future<bool> getAllStories() async {
    posts.clear();

    try {
      for (var element in storyInstances()) {
        stories[storyInstances().indexOf(element).toString()] = element;
      }
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      Tools.logger.e(e);
    }
    return false;
  }

  static Future<bool> getAllPosts() async {
    posts.clear();

    try {
      for (var element in postInstances()) {
        posts[postInstances().indexOf(element).toString()] = element;
      }

      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      Tools.logger.e("Error getAll Posts: " + e.toString());
    }
    return false;
  }

  static Future<bool> getAllProfiles() async {
    profiles.clear();

    try {
      for (var element in profilesInstances()) {
        profiles[profilesInstances().indexOf(element).toString()] = element;
      }

      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      Tools.logger.e(e);
    }
    return false;
  }

  static Future<PostModel?> getPost(String id) async {
    return posts[id];
  }

  static Future<ProfileModel?> getProfile(String id) async {
    return profiles[id];
  }

  static Future<void> createStory({required BuildContext context}) async {
    File? userImage;
    File? storyImage;

    TextEditingController textControllerUserName = TextEditingController();

    bool isLoading = false;

    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor:
              Prefs.isDarkMode ? S.colors.darkGrey : S.colors.white,
          scrollable: true,
          contentPadding: const EdgeInsets.all(8.0),
          content: StatefulBuilder(builder: (context, setState) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 8.0, left: 8.0),
                              child: Text(
                                'image'.tr().replaceAll("\\n", "\n"),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ImageWidget(
                                height: 130.0,
                                width: 100.0,
                                path: storyImage?.path,
                                onSelected: (img) {
                                  if (img != null) {
                                    storyImage = img;
                                    setState(() {});
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0,
                                        right: 8.0,
                                        left: 8.0,
                                        bottom: 2.0),
                                    child: Text(
                                      'user_pic'.tr().replaceAll("\\n", "\n"),
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      userImage = await Tools.pickImages();
                                      setState(() {});
                                    },
                                    child: ProfilePic(
                                      path: userImage?.path,
                                      size: 40.0,
                                      onSelected: (img) {
                                        if (img != null) {
                                          userImage = img;
                                          setState(() {});
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0,
                                        right: 5.0,
                                        left: 8.0,
                                        bottom: 2.0),
                                    child: Text(
                                      'name'.tr().replaceAll("\\n", "\n"),
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                    child: MTextField(
                                      controller: textControllerUserName,
                                      maxLines: 1,
                                      keyboardType: TextInputType.text,
                                      onChange: (val) {},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "long_click_on_story_to_delete".tr(),
                        style:
                            const TextStyle(color: Colors.red, fontSize: 12.0),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 28.0,
                          child: RawMaterialButton(
                            onPressed: () {
                              Navigator.of(context);
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
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              StoryModel story = createBlankStory();

                              if (textControllerUserName.text.isNotEmpty) {
                                story.user.name = textControllerUserName.text;
                              }

                              if (userImage != null) {
                                story.user.photoPath = userImage!.path;
                              }
                              if (storyImage != null) {
                                story.imageUrl = storyImage!.path;
                              }

                              await Fire.uploadStory(story);

                              setState(() {
                                isLoading = false;
                              });

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
                    ),
                  ],
                ),
                isLoading
                    ? Container(
                        color: Colors.transparent,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            );
          }),
        );
      },
    );
  }

  static Future<String> uploadStory(StoryModel story) async {

    String id = (int.parse(stories.keys.last) + 1).toString();
    stories[id] = story;

    await Future.delayed(const Duration(seconds: 1));

    Tools.logger.i(
      "Story Added successfully ✅"
      "\nUser: ${story.toJson()["user"]["name"]}"
      "\nimageUrl: ${story.toJson()["imageUrl"]}",
    );
    return id;
  }

  static Future<String> uploadPost(PostModel post) async {
    String id = (int.parse(posts.keys.last) + 1).toString();
    posts[id] = post;

    await Future.delayed(const Duration(seconds: 1));

    Tools.logger.i(
      "Post Added successfully ✅"
      "\nUser: ${post.toJson()["user"]["name"]}"
      "\nText: ${post.toJson()["text"]}",
    );
    return id;
  }

  static Future<String> uploadProfile(ProfileModel profile) async {
    String id = (int.parse(profiles.keys.last) + 1).toString();
    profiles[id] = profile;

    await Future.delayed(const Duration(seconds: 1));

    Tools.logger.i("Profile :\n${profile.toJson()}\nAdded successfully ✅");

    return id;
  }

  static Future<void> editPost(String id, PostModel post) async {
    posts[id] = post;

    await Future.delayed(const Duration(seconds: 1));

    Tools.logger.i("Post updated successfully");
  }

  static Future<void> deletePost(
      {required BuildContext context, required String id}) async {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            color: Prefs.isDarkMode ? S.colors.dark : Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4.0,
                width: 50.0,
                decoration: BoxDecoration(
                    color:
                        Prefs.isDarkMode ? S.colors.darkGrey : S.colors.light,
                    borderRadius: BorderRadius.circular(100.0)),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text("confirm_delete".tr()),
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  TextButton(
                    onPressed: () async {
                      posts.removeWhere((key, value) => key == id);

                      await Future.delayed(const Duration(seconds: 1));

                      Tools.logger.i("Post deleted: where id = $id");
                      Navigator.pop(context, true);
                    },
                    child: Text(
                      "yes".tr(),
                      style: TextStyle(
                          color: Prefs.isDarkMode
                              ? S.colors.white
                              : S.colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
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

  //TODO: deleteComment Function
  static Future<void> deleteComment(String postId) async {}

  static Future<void> editUserLanguage(String lang) async {
    connectedUser!.language = lang;
    Tools.logger.i("Language updated successfully");
  }

  static Future<void> registerUser(BuildContext context, String email,
      String username, String password, String? photoPath) async {

    connectedUser = createUserInstance();

    Tools.logger.wtf("User Registered:\n" + connectedUser!.toJson().toString());
  }

  static Future<void> getConnectedUserData() async {
    connectedUser = createUserInstance();
    Tools.logger.i("Connected User: " + connectedUser!.toJson().toString());
  }

  static Future<String> uploadFile(File? file, String collection) async {
    return file!.path;
  }

  static Future<CommentModel?> addComment(
      {required BuildContext context, bool isReply = false}) async {
    File? userImage;
    File? commentImage;
    bool verified = false;

    TextEditingController textControllerUserName = TextEditingController();
    TextEditingController textControllerComment = TextEditingController();
    TextEditingController textControllerElapsedTime = TextEditingController();
    TextEditingController textControllerReactsCount = TextEditingController();

    bool isLoading = false;

    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          backgroundColor:
              Prefs.isDarkMode ? S.colors.darkGrey : S.colors.white,
          scrollable: true,
          contentPadding: const EdgeInsets.all(8.0),
          content: StatefulBuilder(builder: (context, setState) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 8.0, left: 8.0, bottom: 2.0),
                              child: Text(
                                'user_pic'.tr().replaceAll("\\n", "\n"),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            ProfilePic(
                              path: userImage?.path,
                              size: 40.0,
                              onSelected: (img) {
                                if (img != null) {
                                  userImage = img;
                                  setState(() {});
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0,
                                    right: 5.0,
                                    left: 8.0,
                                    bottom: 2.0),
                                child: Text(
                                  'name'.tr().replaceAll("\\n", "\n"),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                              SizedBox(
                                height: 40.0,
                                child: MTextField(
                                  controller: textControllerUserName,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  onChange: (val) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 8.0, left: 8.0, bottom: 2.0),
                              child: Text(
                                'verified'.tr().replaceAll("\\n", "\n"),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            IconButton(
                              icon: SvgPicture.asset(
                                'assets/icons/verified_badge.svg',
                                width: 30.0,
                                color: verified
                                    ? S.colors.blue
                                    : S.colors.lightGrey,
                              ),
                              onPressed: () {
                                verified = !verified;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 8.0, left: 8.0),
                      child: Text(
                        'comment'.tr().replaceAll("\\n", "\n"),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    MTextField(
                      controller: textControllerComment,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      onChange: (val) {},
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 8.0, left: 8.0),
                              child: Text(
                                'image'.tr().replaceAll("\\n", "\n"),
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ImageWidget(
                                path: commentImage?.path,
                                onSelected: (img) {
                                  if (img != null) {
                                    commentImage = img;
                                    setState(() {});
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 8.0, left: 8.0),
                                child: Text(
                                  'elapsed_time'.tr().replaceAll("\\n", "\n"),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                              SizedBox(
                                height: 40.0,
                                child: MTextField(
                                  controller: textControllerElapsedTime,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  onChange: (val) {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 8.0, left: 8.0),
                                child: Text(
                                  'reacts_count'.tr().replaceAll("\\n", "\n"),
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                              SizedBox(
                                height: 40.0,
                                child: MTextField(
                                  controller: textControllerReactsCount,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  onChange: (val) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 28.0,
                          child: RawMaterialButton(
                            onPressed: () {
                              Navigator.of(context).pop(null);
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
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              CommentModel comment = createBlankComment();

                              if (textControllerUserName.text.isNotEmpty) {
                                comment.profile.name =
                                    textControllerUserName.text;
                              }
                              if (textControllerComment.text.isNotEmpty) {
                                comment.text = textControllerComment.text;
                              } else if (isReply) {
                                comment.text = createBlankReply().text;
                              }
                              if (textControllerElapsedTime.text.isNotEmpty) {
                                comment.elapsedTime =
                                    textControllerElapsedTime.text;
                              }
                              if (textControllerReactsCount.text.isNotEmpty) {
                                comment.commentReactions.reactionsCount =
                                    int.parse(textControllerReactsCount.text);
                                comment.commentReactions.reactions.add("like");
                              }
                              if (userImage != null) {
                                comment.profile.photoPath = userImage!.path;
                              }
                              if (commentImage != null) {
                                comment.imagePath = commentImage!.path;
                              }

                              comment.profile.verified = verified;
                              comment.isReply = isReply;

                              setState(() {
                                isLoading = false;
                              });

                              Navigator.pop(context, comment);
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
                    ),
                  ],
                ),
                isLoading
                    ? Container(
                        color: Colors.transparent,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            );
          }),
        );
      },
    );
  }

  static Future<void> deleteStory(
      {required BuildContext context, required String id}) async {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            color: Prefs.isDarkMode ? S.colors.dark : Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4.0,
                width: 50.0,
                decoration: BoxDecoration(
                    color:
                        Prefs.isDarkMode ? S.colors.darkGrey : S.colors.light,
                    borderRadius: BorderRadius.circular(100.0)),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text("confirm_delete".tr()),
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  TextButton(
                    onPressed: () async {
                      await Future.delayed(const Duration(seconds: 1));

                      stories.removeWhere((key, value) => key == id);

                      Tools.logger.w("Story deleted: where id = $id");
                      Navigator.pop(context);
                    },
                    child: Text(
                      "yes".tr(),
                      style: TextStyle(
                          color: Prefs.isDarkMode
                              ? S.colors.white
                              : S.colors.black),
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
  }
}
