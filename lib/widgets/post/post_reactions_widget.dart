import 'package:easy_localization/easy_localization.dart';
import 'package:fake_it/utils/constants.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:fake_it/widgets/home_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostReactionsWidget extends StatefulWidget {
  final ReactionsModel? reactions;

  const PostReactionsWidget({
    Key? key,
    required this.reactions,
  }) : super(key: key);

  @override
  _PostReactionsWidgetState createState() => _PostReactionsWidgetState();
}

class _PostReactionsWidgetState extends State<PostReactionsWidget> {
  List<String> reactionsList = [];
  List<bool> reactState = [];

  TextEditingController textControllerReactNb = TextEditingController();
  TextEditingController textControllerComNb = TextEditingController();
  TextEditingController textControllerShrNb = TextEditingController();

  fillReactionsData() {
    textControllerReactNb.text = widget.reactions!.reactionsCount.toString();
    textControllerComNb.text = widget.reactions!.commentsCount.toString();
    textControllerShrNb.text = widget.reactions!.sharesCount.toString();
    reactionsList.addAll(widget.reactions!.reactions.map((e) => e));
    reactState.addAll(widget.reactions!.reactions.map((e) => true));
    for (String react in Strings.reactionsList) {
      if (!widget.reactions!.reactions.contains(react)) {
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
            return WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: AlertDialog(
                backgroundColor:
                    Prefs.isDarkMode ? S.colors.darkGrey : S.colors.light,
                contentPadding: const EdgeInsets.all(10.0),
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
                                },
                                children: reactionsList
                                    .map(
                                      (item) => InkWell(
                                        key: Key(item),
                                        onTap: () {
                                          if (!reactState[reactionsList
                                                  .indexOf(item)] ||
                                              widget.reactions!.reactions
                                                  .isNotEmpty) {
                                            if ((widget.reactions!.reactions
                                                        .length <
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
                                                  widget.reactions!
                                                      .reactionsCount++;
                                                } else {
                                                  if (widget.reactions!
                                                          .reactionsCount >
                                                      0) {
                                                    widget.reactions!
                                                        .reactionsCount--;
                                                  }
                                                }
                                                _updateReactions();
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
                                  widget.reactions!.reactionsCount =
                                      int.tryParse(val) ?? 0;
                                });
                                rebuild();
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text('comments_count'.tr().replaceAll("\\n", "\n"),
                              style: Theme.of(context).textTheme.bodyText2),
                          SizedBox(
                            height: 40.0,
                            child: MTextField(
                              controller: textControllerComNb,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              onChange: (val) {
                                dialogSetState(() {
                                  widget.reactions!.commentsCount =
                                      int.tryParse(val) ?? 0;
                                });
                                rebuild();
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text('share_count'.tr().replaceAll("\\n", "\n"),
                              style: Theme.of(context).textTheme.bodyText2),
                          SizedBox(
                            height: 40.0,
                            child: MTextField(
                              controller: textControllerShrNb,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              onChange: (val) {
                                dialogSetState(() {
                                  widget.reactions!.sharesCount =
                                      int.tryParse(val) ?? 0;
                                });
                                rebuild();
                              },
                            ),
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
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.reactions!.reactionsCount == 0
                ? const SizedBox(height: 0.0)
                : widget.reactions!.reactions.isEmpty
                    ? const SizedBox()
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: widget.reactions!.reactionsCount == 0
                                ? 2.0
                                : 6.0),
                        child: Row(
                          children: <Widget>[
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: widget.reactions!.reactions.reversed
                                  .map((item) {
                                return Container(
                                  margin: EdgeInsets.only(
                                    left: widget.reactions!.reactions
                                            .indexOf(item)
                                            .toDouble() *
                                        16.0,
                                    right: 0,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      border: Border.all(
                                          color: Prefs.isDarkMode
                                              ? const Color(0xff222524)
                                              : Colors.white,
                                          width: 2.0)),
                                  child: SvgPicture.asset(
                                      'assets/icons/reactions/$item.svg',
                                      height: 18),
                                );
                              }).toList(),
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              NumberFormat.compactCurrency(
                                      decimalDigits: 0, symbol: '')
                                  .format(widget.reactions!.reactionsCount)
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .apply(
                                      color: Prefs.isDarkMode
                                          ? S.colors.lightGrey
                                          : S.colors.darkGrey),
                            ),
                          ],
                        ),
                      ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: widget.reactions!.commentsCount == 0 &&
                          widget.reactions!.sharesCount == 0
                      ? 2.0
                      : 9.0),
              child: Row(
                children: [
                  Row(
                    children: <Widget>[
                      widget.reactions!.commentsCount == 0
                          ? const SizedBox()
                          : Text(
                              (widget.reactions!.commentsCount == 1 ||
                                          widget.reactions!.commentsCount ==
                                                  2 &&
                                              Tools.isRTL(context)
                                      ? ''
                                      : NumberFormat.compactCurrency(
                                              decimalDigits: 0, symbol: '')
                                          .format(
                                              widget.reactions!.commentsCount)
                                          .toString()) +
                                  (' ' +
                                      'comment'.plural(
                                          widget.reactions!.commentsCount)),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .apply(
                                      color: Prefs.isDarkMode
                                          ? S.colors.lightGrey
                                          : S.colors.darkGrey),
                            ),
                      widget.reactions!.sharesCount == 0
                          ? const SizedBox()
                          : Text(
                              (widget.reactions!.commentsCount == 0
                                      ? ''
                                      : ' • ') +
                                  (widget.reactions!.sharesCount == 1 ||
                                          widget.reactions!.sharesCount == 2 &&
                                              Tools.isRTL(context)
                                      ? ''
                                      : NumberFormat.compactCurrency(
                                              decimalDigits: 0, symbol: '')
                                          .format(widget.reactions!.sharesCount)
                                          .toString()) +
                                  (' ' +
                                      'share'.plural(
                                          widget.reactions!.sharesCount)),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .apply(
                                      color: Prefs.isDarkMode
                                          ? S.colors.lightGrey
                                          : S.colors.darkGrey),
                            ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _updateItems(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = reactionsList.removeAt(oldIndex);
      reactionsList.insert(newIndex, item);
      final checkItem = reactState.removeAt(oldIndex);
      reactState.insert(newIndex, checkItem);
    });
  }

  void _updateReactions() {
    setState(() {
      widget.reactions!.reactions.clear();
      for (int i = 0; i < reactionsList.length; i++) {
        if (reactState[i]) {
          widget.reactions!.reactions.add(reactionsList[i]);
        }
      }
    });
    if (kDebugMode) {
      print('==============> ${widget.reactions!.reactions}');
    }
  }

  void rebuild() {
    setState(() {});
  }
}
