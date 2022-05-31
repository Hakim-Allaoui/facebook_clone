class RemoteConfigModel {
  final String currentAppVersion;
  final bool forceUpdate;
  final String title;
  final String body;
  final String link;
  final bool approved;

  RemoteConfigModel({
    required this.currentAppVersion,
    required this.forceUpdate,
    required this.title,
    required this.body,
    required this.link,
    required this.approved,
  });

  factory RemoteConfigModel.fromJson(Map<String, dynamic> json) {
    return RemoteConfigModel(
      currentAppVersion: json["currentAppVersion"],
      forceUpdate: json["forceUpdate"].toLowerCase() == 'true',
      title: json["title"],
      body: json["body"],
      link: json["link"],
      approved: true/*json["approved"].toLowerCase() == 'true'*/,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "currentAppVersion": currentAppVersion,
      "forceUpdate": forceUpdate,
      "title": title,
      "body": body,
      "link": link,
      "approved": approved,
    };
  }
//



}