import 'package:auto_direction/auto_direction.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fake_it/services/flutterfire_services.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:fake_it/widgets/profile_pic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

export 'package:fake_it/widgets/post/post_widget.dart';

class FacebookLogo extends StatelessWidget {
  final double? size;
  final Color? color;

  const FacebookLogo({Key? key, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/facebook_typo_logo.svg',
      width: size ?? MediaQuery.of(context).size.width * 0.3,
      color: color,
    );
  }
}

class CreatePostWidget extends StatelessWidget {
  const CreatePostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Prefs.isDarkMode ? S.colors.dark : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.asset(
                    'assets/images/profile.png',
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(
                        color: const Color(0xffB0B4B7),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'whats_on_your_mind'.tr(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Prefs.isDarkMode ? S.colors.lightGrey : S.colors.darkGrey,
          width: MediaQuery.of(context).size.width,
          height: 0.5,
        ),
        Container(
          color: Prefs.isDarkMode ? S.colors.dark : Colors.white,
          height: 43,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/go_live.svg",
                    height: 16.0,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    'Live',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.apply(fontSizeFactor: 0.9),
                  ),
                ],
              ),
              const VerticalDivider(
                thickness: 1.0,
                indent: 0.0,
                endIndent: 0.0,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/add_photo.svg",
                    height: 16.0,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    'Photo',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.apply(fontSizeFactor: 0.9),
                  ),
                ],
              ),
              const VerticalDivider(
                thickness: 1.0,
                indent: 0.0,
                endIndent: 0.0,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/add_room.svg",
                    height: 16.0,
                    color: const Color(0XFF925CF3),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    'Room',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.apply(fontSizeFactor: 0.9),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class NewCreatePostWidget extends StatelessWidget {
  final VoidCallback? addPost;

  const NewCreatePostWidget({Key? key, this.addPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Prefs.isDarkMode ? S.colors.dark : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                ProfilePic(
                  path: Fire.connectedUser?.profile.photoPath,
                  size: 40.0,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: InkWell(
                    onTap: addPost,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        border: Border.all(
                          color: const Color(0xffB0B4B7),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'whats_on_your_mind'.tr(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset("assets/icons/add_photo.svg",
                      height: 18.0),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Prefs.isDarkMode
              ? const Color(0xff333436)
              : const Color(0xfff9f7fb),
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CreatePostButton(
                isDarkMode: Prefs.isDarkMode,
                svgPicture: "assets/icons/reels.svg",
                text: "reel".tr(),
              ),
              CreatePostButton(
                isDarkMode: Prefs.isDarkMode,
                svgPicture: "assets/icons/add_room.svg",
                text: "room".tr(),
              ),
              CreatePostButton(
                isDarkMode: Prefs.isDarkMode,
                svgPicture: "assets/icons/group_new.svg",
                text: "group".tr(),
              ),
              CreatePostButton(
                isDarkMode: Prefs.isDarkMode,
                svgPicture: "assets/icons/go_live.svg",
                text: "live".tr(),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}

class CreatePostButton extends StatelessWidget {
  final String svgPicture;
  final String text;

  const CreatePostButton(
      {Key? key,
      required this.isDarkMode,
      required this.svgPicture,
      required this.text})
      : super(key: key);

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 14.0),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0XFF3f4042) : Colors.white,
        borderRadius: BorderRadius.circular(100.0),
        border: Border.all(
          color: isDarkMode ? const Color(0xff222524) : const Color(0xffeeecef),
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgPicture,
            height: 20.0,
          ),
          const SizedBox(
            width: 8.0,
          ),
          Text(
            text,
            style:
                Theme.of(context).textTheme.button?.apply(fontSizeFactor: 0.9),
          ),
        ],
      ),
    );
  }
}

class StoriesWidget extends StatefulWidget {
  const StoriesWidget({Key? key}) : super(key: key);

  @override
  State<StoriesWidget> createState() => _StoriesWidgetState();
}

class _StoriesWidgetState extends State<StoriesWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Prefs.isDarkMode ? S.colors.dark : Colors.white,
      height: 270.0,
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: S.colors.blue,
              labelStyle: Theme.of(context).textTheme.bodyMedium!,
              unselectedLabelColor:
                  Prefs.isDarkMode ? S.colors.lightGrey : S.colors.darkGrey,
              indicator: MaterialIndicator(
                color: S.colors.blue,
                height: 2.0,
                horizontalPadding: 10.0,
              ),
              tabs: const [
                Tab(
                  child: Text("Stories"),
                ),
                Tab(
                  child: Text("Reels"),
                ),
                Tab(
                  child: Text("Rooms"),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Stack(
                    alignment: Tools.isRTL(context)
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.all(9.0),
                        itemCount: Fire.stories.length + 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          if(index == 0) {
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: InkWell(
                                onTap: () async {
                                  await Fire.createStory(context: context);
                                  setState(() {});
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Container(
                                    color: Prefs.isDarkMode
                                        ? S.colors.darker
                                        : S.colors.light,
                                    width: 105.0,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      alignment: Alignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: ImageWidget(
                                                width: 110.0,
                                                path: Fire.connectedUser?.profile.photoPath,
                                                radius: 0.0,
                                              ),
                                            ),
                                            const Expanded(
                                                flex: 2, child: SizedBox()),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "create_story".tr(),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 105.0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(100.0),
                                              border: Border.all(
                                                width: 3.0,
                                                color: Prefs.isDarkMode
                                                    ? S.colors.darker
                                                    : S.colors.light,
                                              ),
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/icons/button_add_blue.svg",
                                              height: 30.0,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return InkWell(
                            onLongPress: () async {
                              await Fire.deleteStory(
                                  context: context,
                                  id: Fire.stories.keys.elementAt(index-1));
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Container(
                                  color: S.colors.darkGrey,
                                  width: 105.0,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      ImageWidget(
                                          width: 110.0,
                                          path: Fire.stories.values
                                              .toList()[index-1]
                                              .imageUrl),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black38,
                                                Colors.transparent,
                                                Colors.transparent,
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            Fire.stories.values
                                                .toList()[index-1]
                                                .user
                                                .name,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            padding: const EdgeInsets.all(2.0),
                                            height: 40.0,
                                            width: 40.0,
                                            decoration: BoxDecoration(
                                              color: S.colors.darkGrey,
                                              border: Border.all(
                                                color: Colors.blue,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                            ),
                                            child: ProfilePic(
                                              path: Fire.stories.values
                                                  .toList()[index-1]
                                                  .user
                                                  .photoPath,
                                              size: 40.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Fire.stories.isEmpty
                          ? const SizedBox()
                          : InkWell(
                              onTap: () async {
                                await Fire.createStory(context: context);
                                setState(() {});
                              },
                              child: Container(
                                height: 52,
                                width: 52,
                                padding: const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                    color: Prefs.isDarkMode
                                        ? S.colors.darkGrey
                                        : S.colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          Tools.isRTL(context) ? 0.0 : 100.0),
                                      topRight: Radius.circular(
                                          Tools.isRTL(context) ? 0.0 : 100.0),
                                      bottomLeft: Radius.circular(
                                          Tools.isRTL(context) ? 100.0 : 0.0),
                                      topLeft: Radius.circular(
                                          Tools.isRTL(context) ? 100.0 : 0.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Prefs.isDarkMode
                                            ? Colors.black12
                                            : Colors.white24,
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: const Offset(2.0, 0.0),
                                      ),
                                    ]),
                                child: Stack(
                                  alignment: Tools.isRTL(context)
                                      ? Alignment.bottomLeft
                                      : Alignment.bottomRight,
                                  children: [
                                    ProfilePic(
                                      path: Fire.connectedUser?.profile.photoPath,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: const RadialGradient(
                                          colors: [
                                            Colors.white,
                                            Colors.white,
                                            Colors.transparent,
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                      ),
                                      child: const Icon(
                                        Icons.add_circle,
                                        size: 16.0,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                  const Center(child: Text("Reels")),
                  const Center(child: Text("Rooms")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MTextField extends StatelessWidget {
  const MTextField({
    Key? key,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.obscureText = false,
    this.onSubmit,
    this.maxLines = 1,
    this.onChange,
  }) : super(key: key);

  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool obscureText;
  final Function(String)? onSubmit;
  final Function(String)? onChange;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return AutoDirection(
      text: controller!.text,
      onDirectionChange: (val) {},
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textAlignVertical: TextAlignVertical.top,
        maxLines: maxLines,
        decoration: InputDecoration(
          filled: true,
          contentPadding: const EdgeInsets.all(8.0),
          fillColor: S.colors.lightGrey.withOpacity(0.1),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Prefs.isDarkMode ? S.colors.lightGrey : S.colors.darkGrey,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Prefs.isDarkMode ? S.colors.darkGrey : S.colors.lightGrey,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onSubmitted: onSubmit,
        onChanged: onChange,
      ),
    );
  }
}

class MButton extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback? onClicked;
  final String text;
  final Color? bgColor;
  final Color? textColor;
  final double borderRadius;

  const MButton({
    Key? key,
    this.isDarkMode = false,
    required this.onClicked,
    this.text = "Button",
    this.bgColor = const Color(0xff8ab4f8),
    this.borderRadius = 8.0,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: bgColor,
          padding: const EdgeInsets.symmetric(vertical: 4),
        ),
        onPressed: onClicked,
        child: Container(
          width: Tools.width(context),
          height: 50,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? S.colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class DismissibleBackground extends StatelessWidget {
  const DismissibleBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Prefs.isDarkMode ? S.colors.darker : S.colors.light,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Align(
          alignment: Tools.isRTL(context)
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: const Icon(
            Iconsax.trash,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
