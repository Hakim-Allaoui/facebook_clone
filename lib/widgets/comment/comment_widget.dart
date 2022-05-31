import 'package:fake_it/services/flutterfire_services.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:fake_it/widgets/comment/comment_bottom_row_widget.dart';
import 'package:fake_it/widgets/comment/comment_reactions_widget.dart';
import 'package:fake_it/widgets/edit_text.dart';
import 'package:fake_it/widgets/home_widgets.dart';
import 'package:fake_it/widgets/profile_pic_widget.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatefulWidget {
  final CommentModel comment;
  final VoidCallback onChanged;
  final bool isReply;

  const CommentWidget({
    Key? key,
    required this.comment,
    required this.onChanged,
    this.isReply = false,
  }) : super(key: key);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ProfilePic(
          size: widget.isReply ? 35.0 : 45.0,
          path: widget.comment.profile.photoPath,
          onSelected: (img) async {
            if (img != null) {
              widget.comment.profile.photoPath = img.path;
              setState(() {});
              widget.onChanged();
            }
          },
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Prefs.isDarkMode ? S.colors.darkGrey : S.colors.light,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MEditTextBadge(
                      context: context,
                      onSubmit: (val) {
                        if (val != null) {
                          widget.comment.profile.name = val["text"];
                          widget.comment.profile.verified = val["verified"];
                          widget.onChanged();
                          setState(() {});
                        }
                      },
                      text: widget.comment.profile.name,
                      verified: widget.comment.profile.verified,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    MEditText(
                      context: context,
                      text: widget.comment.text,
                      maxLines: 20,
                      onSubmit: (val) {
                        if (val != null) {
                          widget.comment.text = val;
                          widget.onChanged();
                          setState(() {});
                        }
                      },
                    ),
                  ],
                ),
              ),
              widget.comment.imagePath.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: ImageWidget(
                        path: widget.comment.imagePath,
                        height: 180.0,
                        radius: 15.0,
                        onSelected: (img) async {
                          if (img != null) {
                            widget.comment.imagePath = img.path;
                            setState(() {});
                          }
                        },
                      ),
                    )
                  : const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommentBottomRow(
                    comment: widget.comment,
                    onChanged: widget.onChanged,
                    addReply: () async {
                      if (!widget.isReply) {
                        Fire.addComment(
                                context: context, isReply: !widget.isReply)
                            .then((reply) {
                          if (reply != null) {
                            widget.comment.replies!.add(reply);
                          }
                          rebuild();
                          widget.onChanged();
                        });
                      }
                    },
                    addReaction: (reaction) {
                      Tools.logger.wtf("reaction to added : " + reaction);
                      if (reaction.isNotEmpty) {
                        if (!widget.comment.commentReactions.reactions
                            .contains(reaction) &&
                            widget.comment.commentReactions.reactions.length < 3) {
                          widget.comment.commentReactions.reactions.add(reaction);
                        }
                        widget.comment.commentReactions.reactionsCount++;
                        widget.comment.commentReactions.ownReaction = reaction;
                      } else {
                        if (widget.comment.commentReactions.reactions.isNotEmpty) {
                          widget.comment.commentReactions.reactionsCount--;
                        }
                        widget.comment.commentReactions.ownReaction = "";
                      }
                      setState(() {});
                    },
                  ),
                  widget.comment.commentReactions.reactionsCount != 0
                      ? CommentReactions(
                          comment: widget.comment,
                          onChanged: widget.onChanged,
                        )
                      : const SizedBox(),
                ],
              ),
              SizedBox(
                height: widget.comment.replies!.isNotEmpty ? 2.0 : 5.0,
              ),
              if (!widget.isReply && widget.comment.replies!.isNotEmpty)
                Column(
                    children: widget.comment.replies!
                        .map(
                          (item) => Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.startToEnd,
                            background: const DismissibleBackground(),
                            onDismissed: (_) {
                              setState(() {
                                widget.comment.replies!.remove(item);
                              });
                            },
                            child: CommentWidget(
                              comment: item,
                              isReply: true,
                              onChanged: () {
                                setState(() {});
                              },
                            ),
                          ),
                        )
                        .toList()),
            ],
          ),
        ),
      ],
    );
  }

  void rebuild() {
    setState(() {});
  }
}
