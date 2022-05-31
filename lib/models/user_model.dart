import 'package:easy_localization/easy_localization.dart';
import 'package:fake_it/models/profile_model.dart';
import 'package:fake_it/widgets/home_widgets.dart';

class UserModel {
  ProfileModel profile;
  DateTime createdAt;
  String? userId;
  String? email;
  String? username;
  String? password;
  String? language;

  UserModel({
    required this.profile,
    required this.createdAt,
    this.userId,
    this.email,
    this.username,
    this.password,
    this.language,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      profile: ProfileModel.fromJson(json["profile"]),
      createdAt: DateTime.parse(json["createdAt"]),
      userId: json["userId"],
      email: json["email"],
      username: json["username"],
      password: json["password"],
      language: json["language"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "profile": profile.toJson(),
      "createdAt": createdAt.toIso8601String(),
      "userId": userId,
      "email": email,
      "username": username,
      "password": password,
      "language": language,
    };
  }
}

UserModel createUserInstance() {
  return UserModel.fromJson({
    "profile": {
      "name": "username".tr(),
      "otherName": "other_name".tr(),
      "photoPath":
          "",
      "coverPath": "",
      "bio": "Bio Text 💭",
      "verified": false,
      "mainButton": "Add to Story",
      "details": [
        {
          "icon": "assets/icons/profile/followed.svg",
          "label": "followed",
          "detail": "13 784 people"
        }
      ],
      "hasStory": false,
      "showOtherName": false,
      "showBio": true
    },
    "createdAt": "2022-05-30T16:23:54.640278",
    "userId": "hSPQYp6CiKaHHOeZAIAtdCpN3mA2",
    "email": "user.mail@gmail.com",
    "username": "username".tr(),
    "password": "12341234",
    "language": "en_US"
  });
}
