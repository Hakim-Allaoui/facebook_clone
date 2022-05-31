import 'package:fake_it/pages/post_page.dart';
import 'package:fake_it/pages/settings_page.dart';
import 'package:fake_it/services/flutterfire_services.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:fake_it/widgets/home_widgets.dart';
import 'package:fake_it/widgets/profile_pic_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 6);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Tools.confirmExitDialog(context),
      child: DefaultTabController(
        length: 6,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  leading: const SizedBox(),
                  leadingWidth: 0.0,
                  floating: true,
                  snap: true,
                  pinned: true,
                  title: FacebookLogo(
                    color: Prefs.isDarkMode ? S.colors.white : null,
                  ),
                  elevation: 1.0,
                  forceElevated: true,
                  shadowColor: Prefs.isDarkMode ? Colors.white : Colors.black,
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Prefs.isDarkMode
                              ? S.colors.darkGrey
                              : S.colors.light,
                        ),
                        padding: const EdgeInsets.all(6.0),
                        child: FaIcon(
                          FontAwesomeIcons.search,
                          color: Prefs.isDarkMode
                              ? S.colors.white
                              : S.colors.darkGrey,
                          size: 20.0,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Prefs.isDarkMode
                              ? S.colors.darkGrey
                              : S.colors.light,
                        ),
                        padding: const EdgeInsets.all(6.0),
                        child: FaIcon(
                          FontAwesomeIcons.facebookMessenger,
                          color: Prefs.isDarkMode
                              ? S.colors.white
                              : S.colors.darkGrey,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ],
                  bottom: TabBar(
                    controller: _tabController,
                    labelColor: const Color(0xff2C88FF),
                    unselectedLabelColor: Prefs.isDarkMode
                        ? S.colors.lightGrey
                        : S.colors.darkGrey,
                    indicator: MaterialIndicator(
                      color: S.colors.blue,
                      height: 2.0,
                    ),
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.home_filled),
                      ),
                      Tab(
                        icon: Icon(Iconsax.people5),
                      ),
                      Tab(icon: Icon(Iconsax.video_play)),
                      Tab(
                        icon: Icon(Iconsax.shop),
                      ),
                      Tab(
                        icon: Icon(Iconsax.notification),
                      ),
                      Tab(
                        icon: Icon(Iconsax.menu_14),
                      ),
                    ],
                  ),
                )
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                Scrollbar(
                  child: RefreshIndicator(
                    onRefresh: () async {},
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          NewCreatePostWidget(
                            addPost: () async {
                              await postDialog();
                              setState(() {});
                            },
                          ),
                          const StoriesWidget(),
                          ...Fire.posts.keys.map(
                            (postId) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  PostWidget(
                                    post: Fire.posts[postId]!,
                                    postId: postId,
                                    inFeeds: true,
                                    closeButton: () async {
                                      await Fire.deletePost(
                                          context: context, id: postId);
                                      setState(() {});
                                    },
                                    moreButton: () async {
                                      await postDialog(postId: postId);
                                      setState(() {});
                                    },
                                  ),
                                  WriteCommentWidget(
                                    imagePath:
                                        Fire.connectedUser?.profile.photoPath,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Center(child: Text('Group')),
                const Center(child: Text('Watch')),
                const Center(child: Text('Marketplace')),
                const Center(child: Text('Notifications')),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                        child: ProfilePic(
                          path: Fire.connectedUser?.profile.photoPath,
                          size: 120.0,
                        ),
                      ),
                      Text(
                        Fire.connectedUser!.profile.name,
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        Fire.connectedUser!.email!,
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20.0,),
                      MButton(
                        onClicked: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                                return const SettingsPage();
                              }));
                        },
                        text: "Settings",
                        bgColor: Prefs.isDarkMode ? S.colors.darkGrey : S.colors.light,
                        textColor: Prefs.isDarkMode ? S.colors.light : S.colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> postDialog({String? postId}) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
            initialChildSize: 1,
            maxChildSize: 1,
            minChildSize: 0.2,
            builder: (context, scrollController) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  color: Prefs.isDarkMode ? S.colors.dark : S.colors.white,
                ),
                child: Column(
                  children: [
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
                    Expanded(
                        child: PostPage(
                      postId: postId,
                    )),
                  ],
                ),
              );
            });
      },
    );
  }
}
