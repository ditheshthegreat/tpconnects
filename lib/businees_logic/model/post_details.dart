// To parse this JSON data, do
//
//     final postDetailsModel = postDetailsModelFromJson(jsonString);

import 'dart:convert';

PostDetailsModel postDetailsModelFromJson(String str) => PostDetailsModel.fromJson(json.decode(str));

String postDetailsModelToJson(PostDetailsModel data) => json.encode(data.toJson());

class PostDetailsModel {
  PostDetailsModel({
    this.status,
    this.data,
    this.message,
  });

  bool status;
  List<PostDatum> data;
  String message;

  factory PostDetailsModel.fromJson(Map<String, dynamic> json) => PostDetailsModel(
    status: json["status"],
    data: List<PostDatum>.from(json["data"].map((x) => PostDatum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };

  @override
  String toString() {
    return 'PostDetailsModel{status: $status, data: $data, message: $message}';
  }
}

class PostDatum {
  PostDatum({
    this.id,
    this.profileId,
    this.topicId,
    this.postType,
    this.title,
    this.shareLink,
    this.content,
    this.location,
    this.details,
    this.postDate,
    this.postDateUtc,
    this.comments,
    this.image,
    this.video,
    this.audio,
    this.myReact,
    this.reactDetails,
    this.reacts,
    this.tags,
    this.settings,
    this.hashs,
    this.polls,
  });

  int id;
  int profileId;
  String topicId;
  String postType;
  String title;
  String shareLink;
  String content;
  Location location;
  Details details;
  DateTime postDate;
  DateTime postDateUtc;
  int comments;
  String image;
  dynamic video;
  List<dynamic> audio;
  String myReact;
  List<String> reactDetails;
  List<React> reacts;
  List<dynamic> tags;
  Settings settings;
  List<dynamic> hashs;
  Polls polls;

  factory PostDatum.fromJson(Map<String, dynamic> json) => PostDatum(
    id: json["ID"],
    profileId: json["profile_id"],
    topicId: json["topic_id"],
    postType: json["post_type"],
    title: json["title"],
    shareLink: json["share_link"],
    content: json["content"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    details: Details.fromJson(json["details"]),
    postDate: DateTime.parse(json["post_date"]),
    postDateUtc: DateTime.parse(json["post_date_utc"]),
    comments: json["comments"],
    image: json["image"] == null ? null : json["image"],
    video: json["video"],
    audio: List<dynamic>.from(json["audio"].map((x) => x)),
    myReact: json["my_react"] == null ? null : json["my_react"],
    reactDetails: List<String>.from(json["react_details"].map((x) => x)),
    reacts: List<React>.from(json["reacts"].map((x) => React.fromJson(x))),
    tags: List<dynamic>.from(json["tags"].map((x) => x)),
    settings: Settings.fromJson(json["settings"]),
    hashs: List<dynamic>.from(json["hashs"].map((x) => x)),
    polls: json["polls"] == null ? null : Polls.fromJson(json["polls"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "profile_id": profileId,
    "topic_id": topicId,
    "post_type": postType,
    "title": title,
    "share_link": shareLink,
    "content": content,
    "location": location == null ? null : location.toJson(),
    "details": details.toJson(),
    "post_date": postDate.toIso8601String(),
    "post_date_utc": postDateUtc.toIso8601String(),
    "comments": comments,
    "image": image == null ? null : image,
    "video": video,
    "audio": List<dynamic>.from(audio.map((x) => x)),
    "my_react": myReact == null ? null : myReact,
    "react_details": List<dynamic>.from(reactDetails.map((x) => x)),
    "reacts": List<dynamic>.from(reacts.map((x) => x.toJson())),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "settings": settings.toJson(),
    "hashs": List<dynamic>.from(hashs.map((x) => x)),
    "polls": polls == null ? null : polls.toJson(),
  };

  @override
  String toString() {
    return 'PostDatum{id: $id, profileId: $profileId, topicId: $topicId, postType: $postType, title: $title, shareLink: $shareLink, content: $content, location: $location, details: $details, postDate: $postDate, postDateUtc: $postDateUtc, comments: $comments, image: $image, video: $video, audio: $audio, myReact: $myReact, reactDetails: $reactDetails, reacts: $reacts, tags: $tags, settings: $settings, hashs: $hashs, polls: $polls}';
  }
}

class Details {
  Details({
    this.id,
    this.name,
    this.image,
    this.isVolunteer,
  });

  int id;
  String name;
  String image;
  String isVolunteer;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    isVolunteer: json["is_volunteer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "is_volunteer": isVolunteer,
  };
}

class Location {
  Location({
    this.lat,
    this.lon,
    this.address,
  });

  String lat;
  String lon;
  String address;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"],
    lon: json["lon"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
    "address": address,
  };
}

class Polls {
  Polls({
    this.poll,
    this.options,
  });

  Poll poll;
  List<Option> options;

  factory Polls.fromJson(Map<String, dynamic> json) => Polls(
    poll: Poll.fromJson(json["poll"]),
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "poll": poll.toJson(),
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
  };
}

class Option {
  Option({
    this.id,
    this.pollText,
    this.timestamp,
    this.optionId,
    this.name,
    this.votes,
    this.voted,
  });

  int id;
  String pollText;
  DateTime timestamp;
  int optionId;
  String name;
  int votes;
  int voted;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    pollText: json["poll_text"],
    timestamp: DateTime.parse(json["timestamp"]),
    optionId: json["option_id"],
    name: json["name"],
    votes: json["votes"],
    voted: json["voted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "poll_text": pollText,
    "timestamp": timestamp.toIso8601String(),
    "option_id": optionId,
    "name": name,
    "votes": votes,
    "voted": voted,
  };
}

class Poll {
  Poll({
    this.id,
    this.pollText,
    this.timestamp,
  });

  int id;
  String pollText;
  DateTime timestamp;

  factory Poll.fromJson(Map<String, dynamic> json) => Poll(
    id: json["id"],
    pollText: json["poll_text"],
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "poll_text": pollText,
    "timestamp": timestamp.toIso8601String(),
  };
}

class React {
  React({
    this.rc,
    this.cn,
  });

  String rc;
  int cn;

  factory React.fromJson(Map<String, dynamic> json) => React(
    rc: json["rc"],
    cn: json["cn"],
  );

  Map<String, dynamic> toJson() => {
    "rc": rc,
    "cn": cn,
  };
}

class Settings {
  Settings({
    this.shareStoryStatus,
    this.shareGroupStatus,
    this.commentAllowed,
  });

  String shareStoryStatus;
  String shareGroupStatus;
  String commentAllowed;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    shareStoryStatus: json["share_story_status"] == null ? null : json["share_story_status"],
    shareGroupStatus: json["share_group_status"] == null ? null : json["share_group_status"],
    commentAllowed: json["comment_allowed"] == null ? null : json["comment_allowed"],
  );

  Map<String, dynamic> toJson() => {
    "share_story_status": shareStoryStatus == null ? null : shareStoryStatus,
    "share_group_status": shareGroupStatus == null ? null : shareGroupStatus,
    "comment_allowed": commentAllowed == null ? null : commentAllowed,
  };
}
