import 'package:fake_it/models/comment_model.dart';
import 'package:fake_it/utils/shared_preferences.dart';
import 'package:fake_it/utils/strings.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/widgets/edit_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

class CommentBottomRow extends StatefulWidget {
  final VoidCallback addReply;
  final CommentModel comment;
  final VoidCallback onChanged;
  final Function(String)? addReaction;

  const CommentBottomRow({
    Key? key,
    required this.addReply,
    required this.comment,
    required this.onChanged,
    this.addReaction,
  }) : super(key: key);

  @override
  _CommentBottomRowState createState() => _CommentBottomRowState();
}

class _CommentBottomRowState extends State<CommentBottomRow> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    if (widget.comment.commentReactions.ownReaction != null &&
        widget.comment.commentReactions.ownReaction!.isNotEmpty) {
      selectedIndex = Strings.bottomRowReactions.indexOf(widget
          .comment.commentReactions.ownReaction!
          .replaceAll("like", "like_fill"));
    } else {
      selectedIndex = 0;
    }
  }

  void showReactsRow() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          titlePadding: const EdgeInsets.all(0),
          title: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                color: Prefs.isDarkMode ? S.colors.darkGrey : S.colors.light,
                borderRadius: BorderRadius.circular(100.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 2.0),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: Strings.bottomRowReactions
                      .sublist(2, Strings.bottomRowReactions.length)
                      .map(
                        (item) => InkWell(
                          key: Key(item),
                          onTap: () {
                            if (selectedIndex !=
                                Strings.bottomRowReactions.indexOf(item)) {
                              selectedIndex =
                                  Strings.bottomRowReactions.indexOf(item);
                              widget.addReaction!(item);
                              Navigator.pop(context, item);
                              widget.comment.commentReactions.ownReaction =
                                  item;
                            } else {
                              selectedIndex = 0;
                              widget.addReaction!("");
                              Navigator.pop(context, "");
                            }
                            rebuild();
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    Strings.bottomRowReactions.indexOf(item) ==
                                            selectedIndex
                                        ? 4.0
                                        : 0.0,
                                vertical: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: Strings.bottomRowReactions.indexOf(item) ==
                                        0 ||
                                    Strings.bottomRowReactions.indexOf(item) ==
                                        1
                                ? Container(
                                    padding: const EdgeInsets.all(4.0),
                                    child: SvgPicture.asset(
                                        "assets/icons/reactions/$item.svg",
                                        height: 25),
                                  )
                                : Strings.bottomRowReactions.indexOf(item) ==
                                        selectedIndex
                                    ? SvgPicture.asset(
                                        "assets/icons/reactions/$item.svg",
                                        height: 35)
                                    : Opacity(
                                        opacity: 0.8,
                                        child: SvgPicture.asset(
                                            "assets/icons/reactions/$item.svg",
                                            height: 30),
                                      ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4.0, bottom: 2.0),
      child: Row(
        children: <Widget>[
          MEditText(
            context: context,
            onSubmit: (val) {
              if (val != null) {
                widget.comment.elapsedTime = val;
                widget.onChanged();
                setState(() {});
              }
            },
            text: widget.comment.elapsedTime,
            textStyle: Theme.of(context).textTheme.button!.apply(
                color:
                    Prefs.isDarkMode ? S.colors.lightGrey : S.colors.darkGrey,
                fontSizeFactor: 0.9),
          ),
          const SizedBox(
            width: 10.0,
          ),
          InkWell(
            onTap: () {
              if (selectedIndex != 0) {
                selectedIndex = 0;
                widget.addReaction!("");
              } else {
                selectedIndex = 1;
                widget.addReaction!("like");
              }

              setState(() {});
            },
            onLongPress: showReactsRow,
            child: Text(
              (Strings.bottomRowReactions[selectedIndex]
                          .substring(0, 1)
                          .toUpperCase() +
                      Strings.bottomRowReactions[selectedIndex]
                          .substring(1,
                              Strings.bottomRowReactions[selectedIndex].length)
                          .split("_")
                          .first)
                  .tr()
                  .replaceAll("\\n", "\n"),
              style: Theme.of(context).textTheme.button!.apply(
                  color: Prefs.isDarkMode
                      ? Strings.bottomRowIconColorsDark[selectedIndex]
                      : Strings.bottomRowIconColors[selectedIndex],
                  fontSizeFactor: 0.9),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          InkWell(
              onTap: widget.addReply,
              child: Text(
                'reply'.tr().replaceAll("\\n", "\n"),
                style: Theme.of(context).textTheme.button!.apply(
                    color: Prefs.isDarkMode
                        ? S.colors.lightGrey
                        : S.colors.darkGrey,
                    fontSizeFactor: 0.9),
              )),
        ],
      ),
    );
  }

  void rebuild() {
    setState(() {});
  }
}
