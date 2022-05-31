import 'package:easy_localization/easy_localization.dart';
import 'package:fake_it/services/flutterfire_services.dart';
import 'package:fake_it/utils/shared_preferences.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:fake_it/widgets/edit_text.dart';
import 'package:fake_it/widgets/post/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key, this.postId}) : super(key: key);

  final String? postId;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late PostModel currentPost;
  String? createdPostId;
  String title = "posts_title".tr();

  @override
  void initState() {
    super.initState();
    currentPost = Fire.posts[widget.postId] ?? createBlankPost();
    createdPostId = widget.postId;

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Prefs.isDarkMode ? S.colors.dark : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            bool? exit = await askToSavePost();
            if (exit != null) {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: MEditText(
          context: context,
          onSubmit: (val) {
            if (val != null) {
              title = val;
              setState(() {});
            }
          },
          text: title,
          textStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
            color: Prefs.isDarkMode ? S.colors.white : S.colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Prefs.isDarkMode ? S.colors.light : S.colors.dark,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: WillPopScope(
        onWillPop: () async {
          final bool? exit = await askToSavePost();

          if (exit != null) {
            return Future.value(true);
          }

          if (exit!) {
            // await ads.loadAndShowInter(context);
          }
          return Future.value(exit);
        },
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: PostWidget(
                    post: currentPost,
                    postId: createdPostId,
                    closeButton: () async {
                      bool? exit = await askToSavePost();
                      if (exit != null) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
              /*WriteCommentWidget(
                imagePath: currentPost.user.photoPath,
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> askToSavePost() async {
    bool saving = false;
    return await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (_, setState) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              color: Prefs.isDarkMode ? S.colors.dark : S.colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(
                    Iconsax.save_21,
                    color: Prefs.isDarkMode ? S.colors.light : S.colors.dark,
                  ),
                  title: Text(
                    createdPostId == null
                        ? "save".tr()
                        : "save_modifications".tr(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    saving = true;
                    setState(() {});

                    if (createdPostId == null) {
                      createdPostId = await Fire.uploadPost(currentPost);
                    } else {
                      await Fire.editPost(createdPostId!, currentPost);
                    }

                    saving = false;
                    if (!mounted) setState(() {});
                    
                    Navigator.pop(context, true);
                  },
                  trailing: saving
                      ? SizedBox(
                          height: 20.0,
                          width: 20.0,
                          child: CircularProgressIndicator(
                            color: Prefs.isDarkMode
                                ? S.colors.light
                                : S.colors.dark,
                          ),
                        )
                      : null,
                ),
                ListTile(
                  leading: const Icon(
                    Iconsax.trash,
                    color: Colors.redAccent,
                  ),
                  title: Text(
                    "discard".tr(),
                    style: const TextStyle(
                        color: Colors.redAccent, fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    
                    Navigator.pop(context, false);
                  },
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
