import 'package:easy_localization/easy_localization.dart';
import 'package:fake_it/models/profile_details_model.dart';
import 'package:fake_it/utils/constants.dart';


class ProfileModel {
  String name;
  String otherName;
  String photoPath;
  String coverPath;
  String bio;
  bool verified;
  String mainButton;
  List<ProfileDetails>? details;
  bool hasStory;
  bool showOtherName;
  bool showBio;

  ProfileModel(
      {this.name = 'username',
      this.otherName = 'Other Name',
      this.photoPath = "",
      this.coverPath = "",
      this.bio = 'Bio text',
      this.verified = false,
      this.mainButton = 'true',
      this.details,
      this.hasStory = false,
      this.showOtherName = false,
      this.showBio = true});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "otherName": otherName,
      "photoPath": photoPath,
      "coverPath": coverPath,
      "bio": bio,
      "verified": verified,
      "mainButton": mainButton,
      "details": details?.map((e) => e.toJson()).toList(),
      "hasStory": hasStory,
      "showOtherName": showOtherName,
      "showBio": showBio,
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json["name"],
      otherName: json["otherName"],
      photoPath: json["photoPath"],
      coverPath: json["coverPath"],
      bio: json["bio"],
      verified: json["verified"],
      mainButton: json["mainButton"],
      details: List.of(json["details"])
          .map((i) => ProfileDetails.fromJson(i))
          .toList(),
      hasStory: json["hasStory"],
      showOtherName: json["showOtherName"],
      showBio: json["showBio"],
    );
  }
}

ProfileModel createBlankProfile() {
  return ProfileModel(
      name: "username".tr(),
      otherName: "other_name".tr(),
      photoPath: "",
      coverPath: "",
      bio: "Bio Text 💭",
      verified: false,
      mainButton: labelIconsProfile[6],
      details: createBlankProfileDetails(),
      hasStory: false,
      showOtherName: false,
      showBio: true
  );
}


List<ProfileModel> profilesInstances() {
  return [
    createBlankProfile(),
    createBlankProfile(),
    createBlankProfile(),
  ];
}

