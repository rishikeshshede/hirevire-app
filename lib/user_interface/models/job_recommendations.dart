
import 'dart:convert';

class JobRecommendations {
  Location? location;
  String? id;
  PostedBy? postedBy;
  String? requestedBy;
  JobRequisition? jobRequisition;
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
  });

  JobRecommendations copyWith({
    Location? location,
    String? id,
    PostedBy? postedBy,
    String? requestedBy,
    JobRequisition? jobRequisition,
    String? title,
    String? department,
    String? project,
    List<String>? jobMode,
    String? description,
    String? ctc,
    String? status,
    List<Question>? questions,
    List<GrowthPlan>? growthPlan,
    String? perks,
    List<RequiredSkill>? requiredSkills,
    List<Media>? media,
    DateTime? endsOn,
    List<String>? savedApplications,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      JobRecommendations(
        location: location ?? this.location,
        id: id ?? this.id,
        postedBy: postedBy ?? this.postedBy,
        requestedBy: requestedBy ?? this.requestedBy,
        jobRequisition: jobRequisition ?? this.jobRequisition,
        title: title ?? this.title,
        department: department ?? this.department,
        project: project ?? this.project,
        jobMode: jobMode ?? this.jobMode,
        description: description ?? this.description,
        ctc: ctc ?? this.ctc,
        status: status ?? this.status,
        questions: questions ?? this.questions,
        growthPlan: growthPlan ?? this.growthPlan,
        perks: perks ?? this.perks,
        requiredSkills: requiredSkills ?? this.requiredSkills,
        media: media ?? this.media,
        endsOn: endsOn ?? this.endsOn,
        savedApplications: savedApplications ?? this.savedApplications,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory JobRecommendations.fromJson(String str) => JobRecommendations.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JobRecommendations.fromMap(Map<String, dynamic> json) => JobRecommendations(
    location: json["location"] == null ? null : Location.fromMap(json["location"]),
    id: json["_id"],
    postedBy: json["postedBy"] == null ? null : PostedBy.fromMap(json["postedBy"]),
    requestedBy: json["requestedBy"],
    jobRequisition: json["jobRequisition"] == null ? null : JobRequisition.fromMap(json["jobRequisition"]),
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
  );

  Map<String, dynamic> toMap() => {
    "location": location?.toMap(),
    "_id": id,
    "postedBy": postedBy?.toMap(),
    "requestedBy": requestedBy,
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
  };

  static List<JobRecommendations> fromJsonList(jsonList) {
    List<JobRecommendations> tempList = [];
    for (var list in jsonList) {
      tempList.add(JobRecommendations.fromMap(list));
    }
    return tempList;
  }
}

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

class PostedBy {
  Size? size;
  Headquarters? headquarters;
  PeopleNCulture? peopleNCulture;
  String? id;
  String? name;
  String? description;
  String? officialEmail;
  String? profilePicUrl;
  String? industry;
  String? websiteUrl;
  int? foundedYear;
  List<String>? specialties;
  List<LocationElement>? locations;
  List<String>? jobPosts;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  PostedBy({
    this.size,
    this.headquarters,
    this.peopleNCulture,
    this.id,
    this.name,
    this.description,
    this.officialEmail,
    this.profilePicUrl,
    this.industry,
    this.websiteUrl,
    this.foundedYear,
    this.specialties,
    this.locations,
    this.jobPosts,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PostedBy.fromMap(Map<String, dynamic> json) => PostedBy(
    size: json["size"] == null ? null : Size.fromMap(json["size"]),
    headquarters: json["headquarters"] == null ? null : Headquarters.fromMap(json["headquarters"]),
    peopleNCulture: json["peopleNCulture"] == null ? null : PeopleNCulture.fromMap(json["peopleNCulture"]),
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    officialEmail: json["officialEmail"],
    profilePicUrl: json["profilePicUrl"],
    industry: json["industry"],
    websiteUrl: json["websiteUrl"],
    foundedYear: json["foundedYear"],
    specialties: json["specialties"] == null ? [] : List<String>.from(json["specialties"].map((x) => x)),
    locations: json["locations"] == null ? [] : List<LocationElement>.from(json["locations"].map((x) => LocationElement.fromMap(x))),
    jobPosts: json["jobPosts"] == null ? [] : List<String>.from(json["jobPosts"].map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "size": size?.toMap(),
    "headquarters": headquarters?.toMap(),
    "peopleNCulture": peopleNCulture?.toMap(),
    "_id": id,
    "name": name,
    "description": description,
    "officialEmail": officialEmail,
    "profilePicUrl": profilePicUrl,
    "industry": industry,
    "websiteUrl": websiteUrl,
    "foundedYear": foundedYear,
    "specialties": specialties == null ? [] : List<dynamic>.from(specialties!.map((x) => x)),
    "locations": locations == null ? [] : List<dynamic>.from(locations!.map((x) => x.toMap())),
    "jobPosts": jobPosts == null ? [] : List<dynamic>.from(jobPosts!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Size {
  int? min;
  int? max;

  Size({this.min, this.max});

  factory Size.fromMap(Map<String, dynamic> json) => Size(
    min: json["min"],
    max: json["max"],
  );

  Map<String, dynamic> toMap() => {
    "min": min,
    "max": max,
  };
}

class Headquarters {
  Address? address;
  String? country;
  String? state;
  String? city;

  Headquarters({this.address, this.country, this.state, this.city});

  factory Headquarters.fromMap(Map<String, dynamic> json) => Headquarters(
    address: json["address"] == null ? null : Address.fromMap(json["address"]),
    country: json["country"],
    state: json["state"],
    city: json["city"],
  );

  Map<String, dynamic> toMap() => {
    "address": address?.toMap(),
    "country": country,
    "state": state,
    "city": city,
  };
}

class Address {
  String? line1;
  String? line2;

  Address({this.line1, this.line2});

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    line1: json["line1"],
    line2: json["line2"],
  );

  Map<String, dynamic> toMap() => {
    "line1": line1,
    "line2": line2,
  };
}

class PeopleNCulture {
  String? description;
  List<String>? videos;
  List<String>? images;

  PeopleNCulture({
    this.description,
    this.videos,
    this.images,
  });

  factory PeopleNCulture.fromMap(Map<String, dynamic> json) => PeopleNCulture(
    description: json["description"],
    videos: json["videos"] == null ? [] : List<String>.from(json["videos"].map((x) => x)),
    images: json["images"] == null ? [] : List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "description": description,
    "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x)),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
  };

  factory PeopleNCulture.fromJson(String str) => PeopleNCulture.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  static List<PeopleNCulture> fromJsonList(String str) {
    return List<PeopleNCulture>.from(json.decode(str).map((x) => PeopleNCulture.fromMap(x)));
  }
}

class JobRequisition {
  String? id;
  String? requestedBy;
  String? title;
  String? department;
  String? project;
  List<String>? jobMode;
  String? description;
  int? budgetAllocation;
  int? openingsCount;
  String? status;
  List<String>? assignedRecruiters;
  List<RequiredSkill>? requiredSkills;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  JobRequisition({
    this.id,
    this.requestedBy,
    this.title,
    this.department,
    this.project,
    this.jobMode,
    this.description,
    this.budgetAllocation,
    this.openingsCount,
    this.status,
    this.assignedRecruiters,
    this.requiredSkills,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory JobRequisition.fromMap(Map<String, dynamic> json) => JobRequisition(
    id: json["_id"],
    requestedBy: json["requestedBy"],
    title: json["title"],
    department: json["department"],
    project: json["project"],
    jobMode: json["jobMode"] == null ? [] : List<String>.from(json["jobMode"].map((x) => x)),
    description: json["description"],
    budgetAllocation: json["budgetAllocation"],
    openingsCount: json["openingsCount"],
    status: json["status"],
    assignedRecruiters: json["assignedRecruiters"] == null ? [] : List<String>.from(json["assignedRecruiters"].map((x) => x)),
    requiredSkills: json["requiredSkills"] == null ? [] : List<RequiredSkill>.from(json["requiredSkills"].map((x) => RequiredSkill.fromMap(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "requestedBy": requestedBy,
    "title": title,
    "department": department,
    "project": project,
    "jobMode": jobMode == null ? [] : List<dynamic>.from(jobMode!.map((x) => x)),
    "description": description,
    "budgetAllocation": budgetAllocation,
    "openingsCount": openingsCount,
    "status": status,
    "assignedRecruiters": assignedRecruiters == null ? [] : List<dynamic>.from(assignedRecruiters!.map((x) => x)),
    "requiredSkills": requiredSkills == null ? [] : List<dynamic>.from(requiredSkills!.map((x) => x.toMap())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };

  factory JobRequisition.fromJson(String str) => JobRequisition.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  static List<JobRequisition> fromJsonList(String str) {
    return List<JobRequisition>.from(json.decode(str).map((x) => JobRequisition.fromMap(x)));
  }
}

class Question {
  String? type;
  List<String>? options;
  String? content;
  String? id;

  Question({
    this.type,
    this.options,
    this.content,
    this.id,
  });

  factory Question.fromMap(Map<String, dynamic> json) => Question(
    type: json["type"],
    options: json["options"] == null ? [] : List<String>.from(json["options"].map((x) => x)),
    content: json["content"],
    id: json["_id"],
  );

  Map<String, dynamic> toMap() => {
    "type": type,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
    "content": content,
    "_id": id,
  };

  factory Question.fromJson(String str) => Question.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  static List<Question> fromJsonList(String str) {
    return List<Question>.from(json.decode(str).map((x) => Question.fromMap(x)));
  }
}

class GrowthPlan {
  String? title;
  String? description;
  String? id;

  GrowthPlan({
    this.title,
    this.description,
    this.id,
  });

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

  factory GrowthPlan.fromJson(String str) => GrowthPlan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  static List<GrowthPlan> fromJsonList(String str) {
    return List<GrowthPlan>.from(json.decode(str).map((x) => GrowthPlan.fromMap(x)));
  }
}

class RequiredSkill {
  String? skill;
  int? rating;
  DateTime? lastUpdated;
  String? id;

  RequiredSkill({
    this.skill,
    this.rating,
    this.lastUpdated,
    this.id,
  });

  factory RequiredSkill.fromMap(Map<String, dynamic> json) => RequiredSkill(
    skill: json["skill"],
    rating: json["rating"],
    lastUpdated: json["lastUpdated"] == null ? null : DateTime.parse(json["lastUpdated"]),
    id: json["_id"],
  );

  Map<String, dynamic> toMap() => {
    "skill": skill,
    "rating": rating,
    "lastUpdated": lastUpdated?.toIso8601String(),
    "_id": id,
  };

  factory RequiredSkill.fromJson(String str) => RequiredSkill.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  static List<RequiredSkill> fromJsonList(String str) {
    return List<RequiredSkill>.from(json.decode(str).map((x) => RequiredSkill.fromMap(x)));
  }
}

class Media {
  String? url;
  String? type;
  String? thumbnail;
  String? id;

  Media({
    this.url,
    this.type,
    this.thumbnail,
    this.id,
  });

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

  factory Media.fromJson(String str) => Media.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  static List<Media> fromJsonList(String str) {
    return List<Media>.from(json.decode(str).map((x) => Media.fromMap(x)));
  }
}

class LocationElement {
  Address? address;
  String? country;
  String? state;
  String? city;
  String? id;

  LocationElement({
    this.address,
    this.country,
    this.state,
    this.city,
    this.id,
  });

  factory LocationElement.fromMap(Map<String, dynamic> json) => LocationElement(
    address: json["address"] == null ? null : Address.fromMap(json["address"]),
    country: json["country"],
    state: json["state"],
    city: json["city"],
    id: json["_id"],
  );

  Map<String, dynamic> toMap() => {
    "address": address?.toMap(),
    "country": country,
    "state": state,
    "city": city,
    "_id": id,
  };

  factory LocationElement.fromJson(String str) => LocationElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  static List<LocationElement> fromJsonList(String str) {
    return List<LocationElement>.from(json.decode(str).map((x) => LocationElement.fromMap(x)));
  }
}


