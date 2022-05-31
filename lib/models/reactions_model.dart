class ReactionsModel {
  List<String> reactions;
  int reactionsCount;
  int commentsCount;
  int sharesCount;
  String? ownReaction;

  ReactionsModel({
    required this.reactions, // ["like"]
    this.reactionsCount = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.ownReaction = ""
  });

  Map<String, dynamic> toJson() {
    return {
      "reactions": reactions.toList(),
      "reactionsCount": reactionsCount,
      "commentsCount": commentsCount,
      "sharesCount": sharesCount,
      "ownReaction": ownReaction,
    };
  }

  factory ReactionsModel.fromJson(Map<String, dynamic> json) {
    return ReactionsModel(
      reactions: List.of(json["reactions"]).map((i) => i.toString()).toList(),
      reactionsCount: json["reactionsCount"],
      commentsCount: json["commentsCount"],
      sharesCount: json["sharesCount"],
      ownReaction: json["ownReaction"],
    );
  }
}

ReactionsModel createBlankReactions() {
  return ReactionsModel(
    reactions: [],
    ownReaction: "",
    reactionsCount: 0,
    commentsCount: 0,
    sharesCount: 0,
  );
}