import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_it/utils/theme.dart';
import 'package:fake_it/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfilePic extends StatelessWidget {
  final double size;
  final String? path;
  final Function(File?)? onSelected;

  const ProfilePic({
    Key? key,
    this.size = 40.0,
    required this.path,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageWidget(
      height: size,
      width: size,
      radius: 100.0,
      onSelected: onSelected,
      path: path,
    );
  }
}

class ImageWidget extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final String? path;
  final Function(File?)? onSelected;

  const ImageWidget({
    Key? key,
    this.height = 100.0,
    this.width = 100.0,
    this.radius = 10.0,
    this.path,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: () async {
          if (onSelected != null) {
            File? image = await Tools.pickImages();
            onSelected!(image);
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: path == null || path!.isEmpty || path!.contains("asset")
              ? Image.asset("assets/images/blank.png", fit: BoxFit.cover)
              : path!.contains("http")
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: path!,
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          height: 20.0,
                          width: 20.0,
                          child: CircularProgressIndicator(
                            color: Prefs.isDarkMode
                                ? S.colors.light
                                : S.colors.dark,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                          "assets/images/blank.png",
                          fit: BoxFit.cover),
                    )
                  : Stack(
                      fit: StackFit.expand,
                      children: [
                        File(path!).existsSync()
                            ? Image.file(File(path!), fit: BoxFit.cover)
                            : Image.asset("assets/images/blank.png",
                                fit: BoxFit.cover),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                              right: 16.0,
                              bottom: 6.0,
                              left: 6.0,
                            ),
                            decoration: const BoxDecoration(
                              gradient: RadialGradient(
                                colors: [
                                  Colors.black87,
                                  Colors.transparent,
                                ],
                                center: Alignment.bottomLeft,
                                radius: 1.0,
                              ),
                            ),
                            child: const Icon(
                              Iconsax.folder,
                              color: Colors.white,
                              size: 10.0,
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
