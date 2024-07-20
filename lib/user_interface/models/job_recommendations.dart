import 'dart:convert';

class Location {
  String? country;
  String? city;

  Location({this.country, this.city});

  factory Location.fromMap(Map<String, dynamic> json) => Location(
    country: json["country"],
    city: json["city"],
  );

  Map<String, dynamic> toMap() => {
    "country": country,
    "city": city,
  };
}

class SocialUrl {
  String? id;
  String? platform;
  String? url;

  SocialUrl({this.id, this.platform, this.url});

  factory SocialUrl.fromMap(Map<String, dynamic> json) => SocialUrl(
    id: json["_id"],
    platform: json["platform"],
    url: json["url"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "platform": platform,
    "url": url,
  };
}

class PostedBy {
  String? id;
  String? name;
  String? description;
  String? officialEmail;
  String? profilePicUrl;
  String? industry;
  List<SocialUrl>? socialUrls;

  PostedBy({
    this.id,
    this.name,
    this.description,
    this.officialEmail,
    this.profilePicUrl,
    this.industry,
    this.socialUrls,
  });

  factory PostedBy.fromMap(Map<String, dynamic> json) => PostedBy(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    officialEmail: json["officialEmail"],
    profilePicUrl: json["profilePicUrl"],
    industry: json["industry"],
    socialUrls: json["socialUrls"] == null ? [] : List<SocialUrl>.from(json["socialUrls"].map((x) => SocialUrl.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "name": name,
    "description": description,
    "officialEmail": officialEmail,
    "profilePicUrl": profilePicUrl,
    "industry": industry,
    "socialUrls": socialUrls == null ? [] : List<dynamic>.from(socialUrls!.map((x) => x.toMap())),
  };
}

class RequestedBy {
  String? id;
  String? email;
  String? name;

  RequestedBy({this.id, this.email, this.name});

  factory RequestedBy.fromMap(Map<String, dynamic> json) => RequestedBy(
    id: json["_id"],
    email: json["email"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "email": email,
    "name": name,
  };
}

class JobRequisitionDetails {
  String? id;
  String? title;

  JobRequisitionDetails({this.id, this.title});

  factory JobRequisitionDetails.fromMap(Map<String, dynamic> json) => JobRequisitionDetails(
    id: json["_id"],
    title: json["title"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "title": title,
  };
}

class Question {
  String? type;
  List<String>? options;
  String? id;
  String? content;

  Question({this.type, this.options, this.id, this.content});

  factory Question.fromMap(Map<String, dynamic> json) => Question(
    type: json["type"],
    options: json["options"] == null ? [] : List<String>.from(json["options"].map((x) => x)),
    id: json["_id"],
    content: json["content"],
  );

  Map<String, dynamic> toMap() => {
    "type": type,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
    "_id": id,
    "content": content,
  };
}

class GrowthPlan {
  String? title;
  String? description;
  String? id;

  GrowthPlan({this.title, this.description, this.id});

  factory GrowthPlan.fromMap(Map<String, dynamic> json) => GrowthPlan(
    title: json["title"],
    description: json["description"],
    id: json["_id"],
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "description": description,
    "_id": id,
  };
}

class Skill {
  String? id;
  String? name;

  Skill({this.id, this.name});

  factory Skill.fromMap(Map<String, dynamic> json) => Skill(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "name": name,
  };
}

class RequiredSkill {
  Skill? skill;
  int? rating;
  DateTime? lastUpdated;
  String? id;

  RequiredSkill({this.skill, this.rating, this.lastUpdated, this.id});

  factory RequiredSkill.fromMap(Map<String, dynamic> json) => RequiredSkill(
    skill: json["skill"] == null ? null : Skill.fromMap(json["skill"]),
    rating: json["rating"],
    lastUpdated: json["lastUpdated"] == null ? null : DateTime.parse(json["lastUpdated"]),
    id: json["_id"],
  );

  Map<String, dynamic> toMap() => {
    "skill": skill?.toMap(),
    "rating": rating,
    "lastUpdated": lastUpdated?.toIso8601String(),
    "_id": id,
  };
}

class Media {
  String? url;
  String? type;
  String? thumbnail;
  String? id;

  Media({this.url, this.type, this.thumbnail, this.id});

  factory Media.fromMap(Map<String, dynamic> json) => Media(
    url: json["url"],
    type: json["type"],
    thumbnail: json["thumbnail"],
    id: json["_id"],
  );

  Map<String, dynamic> toMap() => {
    "url": url,
    "type": type,
    "thumbnail": thumbnail,
    "_id": id,
  };
}

class JobRecommendations {
  Location? location;
  String? id;
  PostedBy? postedBy;
  RequestedBy? requestedBy;
  JobRequisitionDetails? jobRequisition;
  String? title;
  String? department;
  String? project;
  List<String>? jobMode;
  String? description;
  String? ctc;
  String? status;
  List<Question>? questions;
  List<GrowthPlan>? growthPlan;
  String? perks;
  List<RequiredSkill>? requiredSkills;
  List<Media>? media;
  DateTime? endsOn;
  List<String>? savedApplications;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<String>? leftSwipes;

  JobRecommendations({
    this.location,
    this.id,
    this.postedBy,
    this.requestedBy,
    this.jobRequisition,
    this.title,
    this.department,
    this.project,
    this.jobMode,
    this.description,
    this.ctc,
    this.status,
    this.questions,
    this.growthPlan,
    this.perks,
    this.requiredSkills,
    this.media,
    this.endsOn,
    this.savedApplications,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.leftSwipes,
  });

  factory JobRecommendations.fromMap(Map<String, dynamic> json) => JobRecommendations(
    location: json["location"] == null ? null : Location.fromMap(json["location"]),
    id: json["_id"],
    postedBy: json["postedBy"] == null ? null : PostedBy.fromMap(json["postedBy"]),
    requestedBy: json["requestedBy"] == null ? null : RequestedBy.fromMap(json["requestedBy"]),
    jobRequisition: json["jobRequisition"] == null ? null : JobRequisitionDetails.fromMap(json["jobRequisition"]),
    title: json["title"],
    department: json["department"],
    project: json["project"],
    jobMode: json["jobMode"] == null ? [] : List<String>.from(json["jobMode"].map((x) => x)),
    description: json["description"],
    ctc: json["ctc"],
    status: json["status"],
    questions: json["questions"] == null ? [] : List<Question>.from(json["questions"].map((x) => Question.fromMap(x))),
    growthPlan: json["growth_plan"] == null ? [] : List<GrowthPlan>.from(json["growth_plan"].map((x) => GrowthPlan.fromMap(x))),
    perks: json["perks"],
    requiredSkills: json["requiredSkills"] == null ? [] : List<RequiredSkill>.from(json["requiredSkills"].map((x) => RequiredSkill.fromMap(x))),
    media: json["media"] == null ? [] : List<Media>.from(json["media"].map((x) => Media.fromMap(x))),
    endsOn: json["endsOn"] == null ? null : DateTime.parse(json["endsOn"]),
    savedApplications: json["savedApplications"] == null ? [] : List<String>.from(json["savedApplications"].map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    leftSwipes: json["leftSwipes"] == null ? [] : List<String>.from(json["leftSwipes"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "location": location?.toMap(),
    "_id": id,
    "postedBy": postedBy?.toMap(),
    "requestedBy": requestedBy?.toMap(),
    "jobRequisition": jobRequisition?.toMap(),
    "title": title,
    "department": department,
    "project": project,
    "jobMode": jobMode == null ? [] : List<dynamic>.from(jobMode!.map((x) => x)),
    "description": description,
    "ctc": ctc,
    "status": status,
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toMap())),
    "growth_plan": growthPlan == null ? [] : List<dynamic>.from(growthPlan!.map((x) => x.toMap())),
    "perks": perks,
    "requiredSkills": requiredSkills == null ? [] : List<dynamic>.from(requiredSkills!.map((x) => x.toMap())),
    "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x.toMap())),
    "endsOn": endsOn?.toIso8601String(),
    "savedApplications": savedApplications == null ? [] : List<dynamic>.from(savedApplications!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "leftSwipes": leftSwipes == null ? [] : List<dynamic>.from(leftSwipes!.map((x) => x)),
  };

  factory JobRecommendations.fromJson(String str) => JobRecommendations.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  static List<JobRecommendations> fromJsonList(jsonList) {
    List<JobRecommendations> tempList = [];
    for (var list in jsonList) {
      tempList.add(JobRecommendations.fromMap(list));
    }
    return tempList;
  }
}
