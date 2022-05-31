class ProfileDetails {
  String icon;
  String label;
  String detail;

  ProfileDetails({
    this.icon = "assets/icon/home.svg",
    this.label = "from",
    this.detail = "Casablanca, Morocco",
  });

  factory ProfileDetails.fromJson(Map<String, dynamic> json) {
    return ProfileDetails(
      icon: json["icon"],
      label: json["label"],
      detail: json["detail"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "icon": icon,
      "label": label,
      "detail": detail,
    };
  }
}


List<ProfileDetails> createBlankProfileDetails() {
  return [
    ProfileDetails(icon: "assets/icons/profile/followed.svg", label: "followed", detail: "13 784 people"),
  ];
}


List<ProfileDetails> createBlankProfileDetails2() {
  return [
    ProfileDetails(icon: "assets/icons/profile/lives.svg", label: "live", detail: "California"),
    ProfileDetails(icon: "assets/icons/profile/went.svg", label: "went", detail: "University Oxford"),
    ProfileDetails(icon: "assets/icons/profile/manage.svg", label: "manage", detail: "Page"),
    ProfileDetails(icon: "assets/icons/profile/worked.svg", label: "worked", detail: "Facebook"),
    ProfileDetails(icon: "assets/icons/profile/relationship.svg", label: "relationship", detail: "Someone"),
    ProfileDetails(icon: "assets/icons/profile/from.svg", label: "from", detail: "Casablanca, Morocco"),
    ProfileDetails(icon: "assets/icons/profile/followed.svg", label: "followed", detail: "10 000 000 people"),
  ];
}