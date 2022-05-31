import 'package:easy_localization/easy_localization.dart';
import 'package:fake_it/widgets/post/post_widget.dart';

class CommentModel {
  ProfileModel profile;
  String text;
  String imagePath;
  String elapsedTime;
  ReactionsModel commentReactions;
  bool isReply;
  List<CommentModel>? replies;

  CommentModel({
    required this.profile,
    this.text = 'Click to add reply text here 📝.',
    this.imagePath = "",
    this.elapsedTime = '30m ago',
    required this.commentReactions,
    this.isReply = false,
    this.replies,
  });

  Map<String, dynamic> toJson() {
    return {
      "user": profile.toJson(),
      "text": text,
      "image": imagePath,
      "elapsedTime": elapsedTime,
      "commentReactions": commentReactions.toJson(),
      "replies": replies!.map((e) => e.toJson()).toList(),
      "isReply": isReply,
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      profile: ProfileModel.fromJson(json["user"]),
      text: json["text"],
      imagePath: json["image"],
      elapsedTime: json["elapsedTime"],
      commentReactions: ReactionsModel.fromJson(json["commentReactions"]),
      replies:
          List.of(json["replies"]).map((i) => CommentModel.fromJson(i)).toList(),
      isReply: json["isReply"],
    );
  }
}

CommentModel createBlankComment() {
  return CommentModel(
    profile: createBlankProfile(),
    text: 'click_to_edit_comment'
        .tr()
        .replaceAll("\\n", "\n"),
    elapsedTime:
    'fifteen_m'.tr(),
    commentReactions: createBlankReactions(),
    replies: [],
    isReply: false,
  );
}

CommentModel createBlankReply() {
  return CommentModel(
    profile: createBlankProfile(),
    text: 'click_to_edit_reply'
        .tr()
        .replaceAll("\\n", "\n"),
    elapsedTime:
    'fifteen_m'.tr(),
    commentReactions: createBlankReactions(),
    replies: [],
    isReply: true,
  );
}