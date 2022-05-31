import 'package:fake_it/utils/strings.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:fake_it/widgets/home_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

class CommentReactions extends StatefulWidget {
  final CommentModel comment;
  final VoidCallback onChanged;

  const CommentReactions({
    Key? key,
    required this.comment,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CommentReactionsState createState() => _CommentReactionsState();
}

class _CommentReactionsState extends State<CommentReactions> {
  List<String> reactionsList = [];
  List<bool> reactState = [];

  TextEditingController textControllerReactNb = TextEditingController();
  
  fillReactionsData() {
    textControllerReactNb.text = widget.comment.commentReactions.reactionsCount.toString();
    
    reactionsList.addAll(widget.comment.commentReactions.reactions.map((e) => e));
    reactState.addAll(widget.comment.commentReactions.reactions.map((e) => true));
    for(String react in Strings.reactionsList) {
      if(!widget.comment.commentReactions.reactions.contains(react)) {
        reactionsList.add(react);
        reactState.add(false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fillReactionsData();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                backgroundColor:
                    Prefs.isDarkMode ? S.colors.darkGrey : S.colors.light,
                contentPadding: const EdgeInsets.all(4.0),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                content: StatefulBuilder(
                  builder: (context, dialogSetState) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 52.0,
                            margin: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                                color: Prefs.isDarkMode
                                    ? S.colors.darkGrey
                                    : S.colors.light,
                                borderRadius: BorderRadius.circular(100.0),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black54,
                                      offset: Offset(0.0, 2.0),
                                      blurRadius: 2.0)
                                ]),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: ReorderableListView(
                                scrollDirection: Axis.horizontal,
                                onReorder: (int start, int current) {
                                  dialogSetState(() {
                                    _updateItems(start, current);
                                    _updateReactions();
                                  });
                                  widget.onChanged();
                                },
                                children: reactionsList
                                    .map(
                                      (item) => InkWell(
                                        key: Key(item),
                                        onTap: () {
                                          if (!reactState[reactionsList
                                                  .indexOf(item)] ||
                                              widget.comment.commentReactions
                                                  .reactions.isNotEmpty) {
                                            if ((widget.comment.commentReactions
                                                        .reactions.length <
                                                    3 ||
                                                reactState[reactionsList
                                                    .indexOf(item)])) {
                                              dialogSetState(() {
                                                reactState[reactionsList
                                                        .indexOf(item)] =
                                                    !reactState[reactionsList
                                                        .indexOf(item)];
                                                if (reactState[reactionsList
                                                    .indexOf(item)]) {
                                                  widget
                                                      .comment
                                                      .commentReactions
                                                      .reactionsCount++;
                                                } else {
                                                  if (widget
                                                          .comment
                                                          .commentReactions
                                                          .reactionsCount >
                                                      0) {
                                                    widget
                                                        .comment
                                                        .commentReactions
                                                        .reactionsCount--;
                                                  }
                                                }
                                                _updateReactions();
                                                widget.onChanged();
                                              });
                                            }
                                          }
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0),
                                              ),
                                              child: reactState[reactionsList
                                                      .indexOf(item)]
                                                  ? SvgPicture.asset(
                                                      'assets/icons/reactions/$item.svg',
                                                      height: 40)
                                                  : Opacity(
                                                      opacity: 0.6,
                                                      child: SvgPicture.asset(
                                                          'assets/icons/reactions/$item.svg',
                                                          height: 40),
                                                    ),
                                            ),
                                            if (reactState[
                                                reactionsList.indexOf(item)])
                                              Container(
                                                height: 4.0,
                                                width: 4.0,
                                                decoration: BoxDecoration(
                                                  color: S.hkColors["blue"],
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text('reactions_count'.tr().replaceAll("\\n", "\n"),
                              style: Theme.of(context).textTheme.bodyText2),
                          SizedBox(
                            height: 40.0,
                            child: MTextField(
                              controller: textControllerReactNb,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              onChange: (val) {
                                dialogSetState(() {
                                  widget.comment.commentReactions
                                      .reactionsCount = int.tryParse(val) ?? 0;
                                });
                                rebuild();
                                widget.onChanged();
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                actions: [
                  SizedBox(
                    width: 28.0,
                    child: RawMaterialButton(
                      onPressed: () {
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
                  )
                ],
              );
            });
      },
      child: widget.comment.commentReactions.reactionsCount == 0
          ? const SizedBox()
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    NumberFormat.compactCurrency(decimalDigits: 0, symbol: '')
                        .format(widget.comment.commentReactions.reactionsCount)
                        .toString(),
                    style: TextStyle(
                        color: Prefs.isDarkMode
                            ? S.colors.lightGrey
                            : S.colors.darkGrey),
                  ),
                ),
                widget.comment.commentReactions.reactions.isEmpty
                    ? const SizedBox()
                    : Stack(
                        alignment: !Tools.isRTL(context)
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        children: widget
                            .comment.commentReactions.reactions.reversed
                            .map((item) {
                          return Container(
                            margin: EdgeInsets.only(
                              left: !Tools.isRTL(context)
                                  ? widget.comment.commentReactions.reactions
                                          .indexOf(item)
                                          .toDouble() *
                                      14.0
                                  : 0,
                              right: Tools.isRTL(context)
                                  ? widget.comment.commentReactions.reactions
                                          .indexOf(item)
                                          .toDouble() *
                                      14.0
                                  : 0,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                border: Border.all(
                                    color: Prefs.isDarkMode
                                        ? S.colors.dark
                                        : S.colors.white,
                                    width: 2.0)),
                            child: SvgPicture.asset(
                                'assets/icons/reactions/$item.svg',
                                height: 15),
                          );
                        }).toList(),
                      ),
              ],
            ),
    );
  }

  void _updateItems(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = reactionsList.removeAt(oldIndex);
    reactionsList.insert(newIndex, item);
    final checkItem = reactState.removeAt(oldIndex);
    reactState.insert(newIndex, checkItem);
  }

  void _updateReactions() {
      widget.comment.commentReactions.reactions.clear();
      for (int i = 0; i < reactionsList.length; i++) {
        if (reactState[i]) {
          widget.comment.commentReactions.reactions.add(reactionsList[i]);
        }
      }

    if (kDebugMode) {
      print('======> ${widget.comment.commentReactions.reactions}');
    }

      if (!mounted) return;
      setState(() {});
  }

  void rebuild() {
    setState(() {});
  }
}
