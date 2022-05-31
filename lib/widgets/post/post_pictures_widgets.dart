import 'package:fake_it/models/post_model.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:fake_it/widgets/profile_pic_widget.dart';
import 'package:flutter/material.dart';

class PostPictures extends StatefulWidget {
  final double maxHeight;
  final int imagesNb;
  final PostModel post;

  const PostPictures({
    Key? key,
    required this.post,
    this.maxHeight = 300.0,
    this.imagesNb = 0,
  }) : super(key: key);

  @override
  _PostPicturesState createState() => _PostPicturesState();
}

class _PostPicturesState extends State<PostPictures> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Prefs.isDarkMode ? S.colors.dark : Colors.white,
      ),
      child: widget.post.imagesPath!.length <= 4
          ? widget.post.imagesPath!.length <= 3
              ? widget.post.imagesPath!.length <= 2
                  ? widget.post.imagesPath!.length <= 1
                      ? widget.post.imagesPath!.isEmpty
                          ? const SizedBox()
                          : ImageWidget(
                              path: widget.post.imagesPath![0],
                              radius: 0.0,
                            )
                      : Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ImageWidget(
                                path: widget.post.imagesPath![0],
                                radius: 0.0,
                                width: Tools.width(context),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Expanded(
                              flex: 1,
                              child: ImageWidget(
                                path: widget.post.imagesPath![1],
                                radius: 0.0,
                                width: Tools.width(context),
                              ),
                            )
                          ],
                        ) //2 Pics
                  : Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ImageWidget(
                              path: widget.post.imagesPath![0],
                              radius: 0.0,
                              height: widget.maxHeight),
                        ),
                        const SizedBox(
                          width: 4.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ImageWidget(
                                    path: widget.post.imagesPath![1],
                                    radius: 0.0,
                                    width: Tools.width(context) * 0.5),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Expanded(
                                flex: 1,
                                child: ImageWidget(
                                    path: widget.post.imagesPath![2],
                                    radius: 0.0,
                                    width: Tools.width(context) * 0.5),
                              ),
                            ],
                          ),
                        )
                      ],
                    ) //3 Pics
              : Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ImageWidget(
                        path: widget.post.imagesPath![0],
                        radius: 0.0,
                        width: Tools.width(context),
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ImageWidget(
                              path: widget.post.imagesPath![1],
                              radius: 0.0,
                              width: widget.maxHeight * 0.3,
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: ImageWidget(
                              path: widget.post.imagesPath![2],
                              radius: 0.0,
                              width: widget.maxHeight * 0.3,
                            ),
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: ImageWidget(
                              path: widget.post.imagesPath![3],
                              radius: 0.0,
                              width: widget.maxHeight * 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ) //4 Pics//5 Pics
          : Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ImageWidget(
                          path: widget.post.imagesPath![0],
                          radius: 0.0,
                          width: Tools.width(context),
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: ImageWidget(
                          path: widget.post.imagesPath![1],
                          radius: 0.0,
                          width: Tools.width(context),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4.0),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ImageWidget(
                          path: widget.post.imagesPath![2],
                          radius: 0.0,
                          width: Tools.width(context),
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: ImageWidget(
                          path: widget.post.imagesPath![3],
                          radius: 0.0,
                          width: Tools.width(context),
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              color: Colors.black,
                              child: Opacity(
                                opacity: widget.imagesNb == 0 ? 1.0 : 0.5,
                                child: ImageWidget(
                                    path: widget.post.imagesPath![4],
                                    radius: 0.0,
                                    width: Tools.width(context)),
                              ),
                            ),
                            widget.imagesNb == 0
                                ? const SizedBox()
                                : Center(
                                    child: Text(
                                      '+${widget.imagesNb}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ), //more than 5 Pics
    );
  }
}
