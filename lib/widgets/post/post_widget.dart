import 'package:easy_localization/easy_localization.dart';
import 'package:fake_it/services/flutterfire_services.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:fake_it/widgets/comment/comment_widget.dart';
import 'package:fake_it/widgets/edit_text.dart';
import 'package:fake_it/widgets/home_widgets.dart';
import 'package:fake_it/widgets/post/post_bottom_row_widget.dart';
import 'package:fake_it/widgets/post/post_pictures_widgets.dart';
import 'package:fake_it/widgets/post/post_reactions_widget.dart';
import 'package:fake_it/widgets/post/resizable_widget.dart';
import 'package:fake_it/widgets/profile_pic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';

export 'package:fake_it/models/comment_model.dart';
export 'package:fake_it/models/post_model.dart';
export 'package:fake_it/models/profile_details_model.dart';
export 'package:fake_it/models/profile_model.dart';
export 'package:fake_it/models/reactions_model.dart';

class PostWidget extends StatefulWidget {
  final PostModel post;
  final String? postId;
  final bool inFeeds;
  final VoidCallback? closeButton;
  final VoidCallback? moreButton;

  const PostWidget({
    Key? key,
    required this.post,
    this.inFeeds = false,
    this.postId,
    this.closeButton,
    this.moreButton,
  }) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
            color: Prefs.isDarkMode ? S.colors.dark : Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10.0,
                    ),
                    ProfilePic(
                      path: widget.post.user.photoPath,
                      onSelected: (img) async {
                        if (img != null) {
                          widget.post.user.photoPath = img.path;
                          setState(() {});
                        }
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MEditTextBadge(
                              context: context,
                              onSubmit: (val) {
                                if (val != null) {
                                  widget.post.user.name = val["text"];
                                  widget.post.user.verified = val["verified"];
                                  setState(() {});
                                }
                              },
                              verified: widget.post.user.verified,
                              text: widget.post.user.name,
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Row(
                              children: [
                                MEditText(
                                  context: context,
                                  onSubmit: (val) {
                                    if (val != null) {
                                      widget.post.elapsedTime = val;
                                      setState(() {});
                                    }
                                  },
                                  text: widget.post.elapsedTime,
                                  textStyle: TextStyle(
                                    color: Prefs.isDarkMode
                                        ? S.colors.lightGrey
                                        : S.hkColors["greyDark"],
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  ' • ',
                                  style: TextStyle(
                                    color: Prefs.isDarkMode
                                        ? S.colors.lightGrey
                                        : S.hkColors["greyDark"],
                                    fontSize: 8.0,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  child: SvgPicture.asset(
                                    'assets/icons/globe.svg',
                                    height: 15.0,
                                    color: Prefs.isDarkMode
                                        ? S.colors.lightGrey
                                        : S.hkColors["greyDark"],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 28.0,
                          child: RawMaterialButton(
                            onPressed: postOptions,
                            child: Icon(
                              FontAwesomeIcons.ellipsisH,
                              size: 18,
                              color: Prefs.isDarkMode
                                  ? S.colors.lightGrey
                                  : S.hkColors["greyDark"],
                            ),
                            elevation: .0,
                            padding: const EdgeInsets.all(0.0),
                            shape: const CircleBorder(),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        SizedBox(
                          width: 28.0,
                          child: RawMaterialButton(
                            onPressed: widget.closeButton,
                            child: Icon(
                              Icons.close_rounded,
                              color: Prefs.isDarkMode
                                  ? S.colors.lightGrey
                                  : S.hkColors["greyDark"],
                            ),
                            elevation: .0,
                            padding: const EdgeInsets.all(0.0),
                            shape: const CircleBorder(),
                          ),
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                      ],
                    ),
                  ],
                ),
                widget.post.text.isEmpty
                    ? const SizedBox(height: 8.0)
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8.0),
                        child: MEditText(
                          context: context,
                          maxLines: 15,
                          onSubmit: (val) {
                            if (val != null) {
                              widget.post.text = val;
                              setState(() {});
                            }
                          },
                          text: widget.post.text,
                        ),
                      ),
                widget.post.imagesPath!.isEmpty
                    ? const SizedBox()
                    : ResizableWidget(
                        onTap: (val) {
                          // disableScrolling = val;
                        },
                        onRelease: (val) {
                          widget.post.imagesHeight = val;
                          setState(() {});
                        },
                        maxHeight: Tools.height(context) * 0.6,
                        height: widget.post.imagesHeight,
                        dividerHeight: 4.0,
                        child: PostPictures(
                          post: widget.post,
                          maxHeight: Tools.height(context) * 0.6,
                          imagesNb: widget.post.imagesNb,
                        ),
                      ),
                PostReactionsWidget(reactions: widget.post.postReactions),
                const Divider(height: 4, thickness: 0.2),
                PostBottomRow(
                  reactions: widget.post.postReactions,
                  addComment: () async {
                    Fire.addComment(context: context, isReply: false)
                        .then((comment) {
                      if (comment != null) {
                        widget.post.comments.add(comment);
                        Tools.logger.i("Comment added: " +
                            comment.profile.name +
                            "\nText: " +
                            comment.text);
                      }
                      setState(() {});
                    });
                  },
                  addReaction: (reaction) {
                    Tools.logger.wtf("reaction to added : " + reaction);
                    if (reaction.isNotEmpty) {
                      if (!widget.post.postReactions!.reactions
                              .contains(reaction) &&
                          widget.post.postReactions!.reactions.length < 3) {
                        widget.post.postReactions!.reactions.add(reaction);
                      }
                      widget.post.postReactions!.reactionsCount++;
                      widget.post.postReactions!.ownReaction = reaction;
                    } else {
                      if (widget.post.postReactions!.reactions.isNotEmpty) {
                        widget.post.postReactions!.reactionsCount--;
                      }
                      widget.post.postReactions!.ownReaction = "";
                    }
                    setState(() {});
                  },
                ),
                const Divider(height: 4, thickness: 0.2),
                const SizedBox(height: 8.0),
                Column(
                  children: widget.post.comments.map((comment) {
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      background: const DismissibleBackground(),
                      onDismissed: (_) {
                        setState(() {
                          widget.post.comments.remove(comment);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: CommentWidget(
                          comment: comment,
                          onChanged: () {},
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
  }

  void postOptions() {
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
            color: Prefs.isDarkMode ? S.colors.dark : S.colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.inFeeds
                  ? ListTile(
                      leading: Icon(
                        Iconsax.edit,
                        color:
                            Prefs.isDarkMode ? S.colors.light : S.colors.dark,
                      ),
                      title: Text("edit_post".tr()),
                      onTap: () {
                        Navigator.pop(context);
                        widget.moreButton!();
                      },
                    )
                  : const SizedBox(),
              ListTile(
                leading: Icon(
                  Iconsax.gallery,
                  color: Prefs.isDarkMode ? S.colors.light : S.colors.dark,
                ),
                title: Text("edit_pictures".tr()),
                onTap: () async {
                  Navigator.pop(context);

                  await Tools.editPictures(
                    context: context,
                    post: widget.post,
                    onResult: (imgNb, images) {
                      if (images.isNotEmpty) {
                        for (String path in images) {
                          widget.post.imagesPath!.add(path);
                        }
                      }

                      widget.post.imagesNb = imgNb;
                    },
                  );
                  setState(() {});
                },
              ),
              ListTile(
                leading: Icon(
                  Iconsax.message,
                  color: Prefs.isDarkMode ? S.colors.light : S.colors.dark,
                ),
                title: Text("add_comment".tr()),
                onTap: () async {
                  Navigator.pop(context);
                  Fire.addComment(context: context, isReply: false)
                      .then((comment) {
                    if (comment != null) {
                      widget.post.comments.add(comment);
                      Tools.logger
                          .wtf("added cmt: " + comment.toJson().toString());
                    }
                    setState(() {});
                  });
                },
              ),
              widget.post.text.isEmpty
                  ? ListTile(
                      leading: Icon(
                        Iconsax.textalign_left,
                        color:
                            Prefs.isDarkMode ? S.colors.light : S.colors.dark,
                      ),
                      title: Text("add_text".tr()),
                      onTap: () async {
                        Navigator.pop(context);

                        widget.post.text = createBlankPost().text;

                        setState(() {});
                      },
                    )
                  : const SizedBox(),
              if (!widget.inFeeds)
                ListTile(
                  leading: const Icon(
                    Iconsax.trash,
                    color: Colors.redAccent,
                  ),
                  title: Text(
                    "delete_post".tr(),
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

class WriteCommentWidget extends StatelessWidget {
  final String? imagePath;

  const WriteCommentWidget({Key? key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Prefs.isDarkMode ? S.colors.dark : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ProfilePic(path: imagePath),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  color: Prefs.isDarkMode ? S.colors.darkGrey : S.colors.light,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                    alignment: Tools.isRTL(context)
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Text(
                      'write_a_comment'.tr().replaceAll("\\n", "\n"),
                      textAlign: TextAlign.left,
                    ),
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
