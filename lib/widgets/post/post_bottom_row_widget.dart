import 'package:easy_localization/easy_localization.dart';
import 'package:fake_it/models/reactions_model.dart';
import 'package:fake_it/utils/constants.dart';
import 'package:fake_it/utils/shared_preferences.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostBottomRow extends StatefulWidget {
  final ReactionsModel? reactions;
  final VoidCallback? addComment;
  final Function(String)? addReaction;

  const PostBottomRow({
    Key? key,
    this.addComment,
    this.addReaction,
    required this.reactions,
  }) : super(key: key);

  @override
  _PostBottomRowState createState() => _PostBottomRowState();
}

class _PostBottomRowState extends State<PostBottomRow> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    if (widget.reactions!.ownReaction != null &&
        widget.reactions!.ownReaction!.isNotEmpty) {
      selectedIndex = Strings.bottomRowReactions.indexOf(widget.reactions!.ownReaction!
          .replaceAll("like", "like_fill"));
    } else {
      selectedIndex = 0;
    }
  }

  Future<String?> showReactsRow() {
    return showDialog(
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
                            if (selectedIndex != Strings.bottomRowReactions.indexOf(item)) {
                              selectedIndex = Strings.bottomRowReactions.indexOf(item);
                              widget.addReaction!(item);
                              Navigator.pop(context, item);
                              widget.reactions!.ownReaction = item;
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
                                horizontal: Strings.bottomRowReactions.indexOf(item) == selectedIndex
                                    ? 4.0
                                    : 0.0,
                                vertical: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: Strings.bottomRowReactions.indexOf(item) == 0 ||
                                    Strings.bottomRowReactions.indexOf(item) == 1
                                ? Container(
                                    padding: const EdgeInsets.all(4.0),
                                    child: SvgPicture.asset(
                                        "assets/icons/reactions/$item.svg",
                                        height: 25),
                                  )
                                : Strings.bottomRowReactions.indexOf(item) == selectedIndex
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
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
            onLongPress: () {
              showReactsRow();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    "assets/icons/reactions/${selectedIndex == 0 ? "like_stroke" : selectedIndex == 1 ? "like_fill" : widget.reactions!.ownReaction}.svg",
                    height: 20.0,
                    color: selectedIndex == 0
                        ? Prefs.isDarkMode
                            ? Strings.bottomRowIconColorsDark[selectedIndex]
                            : Strings.bottomRowIconColors[selectedIndex]
                        : null,
                  ),
                ),
                Text(
                  (Strings.bottomRowReactions[selectedIndex].substring(0, 1).toUpperCase() +
                          Strings.bottomRowReactions[selectedIndex]
                              .substring(1, Strings.bottomRowReactions[selectedIndex].length)
                              .split("_")
                              .first)
                      .tr(),
                  style: Theme.of(context).textTheme.bodyText2?.apply(
                      fontSizeFactor: 0.9,
                      color: Prefs.isDarkMode
                          ? Strings.bottomRowIconColorsDark[selectedIndex]
                          : Strings.bottomRowIconColors[selectedIndex]),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              widget.addComment!();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/icons/comment.svg',
                    height: 20.0,
                    color: Prefs.isDarkMode
                        ? S.colors.lightGrey
                        : S.colors.darkGrey,
                  ),
                ),
                Text(
                  ' ' + 'comment'.plural(0),
                  style: Theme.of(context).textTheme.bodyText2!.apply(
                      color: Prefs.isDarkMode
                          ? S.colors.lightGrey
                          : S.colors.darkGrey,
                      fontSizeFactor: 0.9),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(
                    /*Tools.isDirectionRTL(context) ? math.pi :*/
                    0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/icons/share.svg',
                    height: 20.0,
                    color: Prefs.isDarkMode
                        ? S.colors.lightGrey
                        : S.colors.darkGrey,
                  ),
                ),
              ),
              Text(
                ' ' + 'share'.plural(0),
                style: Theme.of(context).textTheme.bodyText2!.apply(
                    color: Prefs.isDarkMode
                        ? S.colors.lightGrey
                        : S.colors.darkGrey,
                    fontSizeFactor: 0.9),
              )
            ],
          ),
        ],
      ),
    );
  }

  void rebuild() {
    setState(() {});
  }
}
