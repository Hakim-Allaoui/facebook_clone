import 'package:easy_localization/easy_localization.dart';
import 'package:fake_it/widgets/post/post_widget.dart';

class PostModel {
  ProfileModel user;
  String text;
  List<String>? imagesPath;
  int imagesNb;
  String elapsedTime;
  double imagesHeight;
  ReactionsModel? postReactions;
  List<CommentModel> comments;

  PostModel({
    required this.user,
    this.text = 'Click to write your own post text',
    this.imagesPath,
    this.imagesNb = 0,
    this.elapsedTime = 'Just Now',
    required this.comments,
    required this.postReactions,
    this.imagesHeight = 300.0,
  });

  Map<String, dynamic> toJson() {
    return {
      "user": user.toJson(),
      "text": text,
      "images": imagesPath!.toList(),
      "imagesNb": imagesNb,
      "elapsedTime": elapsedTime,
      "postReactions": postReactions!.toJson(),
      "comments": comments.map((e) => e.toJson()).toList(),
      "imagesHeight": imagesHeight,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      user: ProfileModel.fromJson(json["user"]),
      text: json["text"],
      imagesPath: List.of(json["images"]).map((e) => e.toString()).toList(),
      imagesNb: json["imagesNb"],
      elapsedTime: json["elapsedTime"],
      postReactions: ReactionsModel.fromJson(json["postReactions"]),
      comments: List.of(json["comments"])
          .map((i) => CommentModel.fromJson(i))
          .toList(),
      imagesHeight: json["imagesHeight"] ?? 300.0,
    );
  }
}

PostModel createBlankPost() {
  return PostModel(
    user: createBlankProfile(),
    elapsedTime: 'just_now'.tr().replaceAll("\\n", "\n"),
    text: 'click_to_write_your_own_post_text'.tr(),
    postReactions: createBlankReactions(),
    imagesPath: [],
    imagesNb: 1,
    comments: [
      /*createBlankComment()*/
    ],
  );
}

List<PostModel> postInstances() {
  return [
    createBlankPost(),
    createBlankPost(),
    createBlankPost(),
  ];
}
