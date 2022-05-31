import 'package:fake_it/models/profile_model.dart';

class StoryModel {
  ProfileModel user;
  String imageUrl;
  bool viewed;

  StoryModel({
    required this.user,
    required this.imageUrl,
    this.viewed = false,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      user: ProfileModel.fromJson(json["user"]),
      imageUrl: json["imageUrl"],
      viewed: json["viewed"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": user.toJson(),
      "imageUrl": imageUrl,
      "viewed": viewed,
    };
  }
//
}

StoryModel createBlankStory() {
  return StoryModel(
    user: createBlankProfile(),
    imageUrl: "",
  );
}

List<StoryModel> storyInstances() {
  return [
    StoryModel(
      user: createBlankProfile(),
      imageUrl: "",
    ),
    StoryModel(
      user: createBlankProfile(),
      imageUrl: "",
    ),
    StoryModel(
      user: createBlankProfile(),
      imageUrl: "",
    ),
  ];
}
