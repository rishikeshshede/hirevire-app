import 'dart:convert';

class JobSeekerProfile {
  JobSeekerProfile({
    this.data,
    this.message,
    this.success,
  });

  final JobSeeker? data;
  final String? message;
  final bool? success;

  factory JobSeekerProfile.fromJson(String str) => JobSeekerProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JobSeekerProfile.fromMap(Map<String, dynamic> json) => JobSeekerProfile(
    data: json["data"] == null ? null : JobSeeker.fromMap(json["data"]),
    message: json["message"],
    success: json["success"],
  );

  Map<String, dynamic> toMap() => {
    "data": data?.toMap(),
    "message": message,
    "success": success,
  };

  static List<JobSeekerProfile> fromJsonList(jsonList) {
    List<JobSeekerProfile> tempList = [];
    for (var list in jsonList) {
      tempList.add(JobSeekerProfile.fromMap(list));
    }
    return tempList;
  }
}

class JobSeeker {
  JobSeeker({
    this.headline,
    this.location,
    this.id,
    this.name,
    this.email,
    this.phone,
    this.birthDate,
    this.experience,
    this.skills,
    this.preferredJobModes,
    this.applications,
    this.socialUrls,
    this.media,
    this.createdAt,
    this.updatedAt,
    this.bio,
    this.profilePicUrl,
    this.status,
  });

  final String? headline;
  final Location? location;
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final DateTime? birthDate;
  final List<Experience>? experience;
  final List<SkillElement>? skills;
  final List<String>? preferredJobModes;
  final List<String>? applications;
  final List<SocialUrl>? socialUrls;
  final List<String>? media;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? bio;
  final String? profilePicUrl;
  final String? status;

  factory JobSeeker.fromJson(String str) => JobSeeker.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JobSeeker.fromMap(Map<String, dynamic> json) => JobSeeker(
    headline: json["headline"],
    location: json["location"] == null ? null : Location.fromMap(json["location"]),
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    birthDate: json["birthDate"] == null ? null : DateTime.parse(json["birthDate"]),
    experience: json["experience"] == null ? null : List<Experience>.from(json["experience"].map((x) => Experience.fromMap(x))),
    skills: json["skills"] == null ? null : List<SkillElement>.from(json["skills"].map((x) => SkillElement.fromMap(x))),
    preferredJobModes: json["preferredJobModes"] == null ? null : List<String>.from(json["preferredJobModes"].map((x) => x)),
    applications: json["applications"] == null ? null : List<String>.from(json["applications"].map((x) => x)),
    socialUrls: json["socialUrls"] == null ? null : List<SocialUrl>.from(json["socialUrls"].map((x) => SocialUrl.fromMap(x))),
    media: json["media"] == null ? null : List<String>.from(json["media"].map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    bio: json["bio"],
    profilePicUrl: json["profilePicUrl"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "headline": headline,
    "location": location?.toMap(),
    "_id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "birthDate": birthDate?.toIso8601String(),
    "experience": experience == null ? null : List<dynamic>.from(experience!.map((x) => x.toMap())),
    "skills": skills == null ? null : List<dynamic>.from(skills!.map((x) => x.toMap())),
    "preferredJobModes": preferredJobModes == null ? null : List<dynamic>.from(preferredJobModes!.map((x) => x)),
    "applications": applications == null ? null : List<dynamic>.from(applications!.map((x) => x)),
    "socialUrls": socialUrls == null ? null : List<dynamic>.from(socialUrls!.map((x) => x.toMap())),
    "media": media == null ? null : List<dynamic>.from(media!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "bio": bio,
    "profilePicUrl": profilePicUrl,
    "status": status,
  };
}

class Location {
  Location({
    this.address,
    this.country,
    this.state,
    this.city,
  });

  final Address? address;
  final String? country;
  final String? state;
  final String? city;

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
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
  Address({
    this.line1,
    this.line2,
  });

  final String? line1;
  final String? line2;

  factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Address.fromMap(Map<String, dynamic> json) => Address(
    line1: json["line1"],
    line2: json["line2"],
  );

  Map<String, dynamic> toMap() => {
    "line1": line1,
    "line2": line2,
  };
}

class Experience {
  Experience({
    this.title,
    this.company,
    this.location,
    this.id,
    this.description,
    this.media,
    this.employmentType,
    this.jobMode,
    this.startDate,
    this.endDate,
    this.stillWorking,
    this.skills,
    this.createdAt,
    this.updatedAt,
  });

  final Title? title;
  final Company? company;
  final Location? location;
  final String? id;
  final String? description;
  final List<Media>? media;
  final String? employmentType;
  final String? jobMode;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool? stillWorking;
  final List<String>? skills;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Experience.fromJson(String str) => Experience.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Experience.fromMap(Map<String, dynamic> json) => Experience(
    title: json["title"] == null ? null : Title.fromMap(json["title"]),
    company: json["company"] == null ? null : Company.fromMap(json["company"]),
    location: json["location"] == null ? null : Location.fromMap(json["location"]),
    id: json["_id"],
    description: json["description"],
    media: json["media"] == null ? null : List<Media>.from(json["media"].map((x) => Media.fromMap(x))),
    employmentType: json["employmentType"],
    jobMode: json["jobMode"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    stillWorking: json["stillWorking"],
    skills: json["skills"] == null ? null : List<String>.from(json["skills"].map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toMap() => {
    "title": title?.toMap(),
    "company": company?.toMap(),
    "location": location?.toMap(),
    "_id": id,
    "description": description,
    "media": media == null ? null : List<dynamic>.from(media!.map((x) => x.toMap())),
    "employmentType": employmentType,
    "jobMode": jobMode,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "stillWorking": stillWorking,
    "skills": skills == null ? null : List<dynamic>.from(skills!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Company {
  Company({
    this.data,
    this.name,
  });

  final CompanyData? data;
  final String? name;

  factory Company.fromJson(String str) => Company.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Company.fromMap(Map<String, dynamic> json) => Company(
    data: json["data"] == null ? null : CompanyData.fromMap(json["data"]),
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "data": data?.toMap(),
    "name": name,
  };
}

class CompanyData {
  CompanyData({
    this.id,
    this.name,
    this.address,
    this.website,
    this.industry,
    this.logoUrl,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? address;
  final String? website;
  final String? industry;
  final String? logoUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CompanyData.fromJson(String str) => CompanyData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CompanyData.fromMap(Map<String, dynamic> json) => CompanyData(
    id: json["_id"],
    name: json["name"],
    address: json["address"],
    website: json["website"],
    industry: json["industry"],
    logoUrl: json["logoUrl"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "name": name,
    "address": address,
    "website": website,
    "industry": industry,
    "logoUrl": logoUrl,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Media {
  Media({
    this.title,
    this.url,
    this.type,
    this.thumbnail,
    this.id,
  });

  final String? title;
  final String? url;
  final String? type;
  final String? thumbnail;
  final String? id;

  factory Media.fromJson(String str) => Media.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Media.fromMap(Map<String, dynamic> json) => Media(
    title: json["title"],
    url: json["url"],
    type: json["type"],
    thumbnail: json["thumbnail"],
    id: json["_id"],
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "url": url,
    "type": type,
    "thumbnail": thumbnail,
    "_id": id,
  };
}

class SkillElement {
  SkillElement({
    this.skill,
    this.rating,
    this.lastUpdated,
    this.id,
  });

  final Skill? skill;
  final int? rating;
  final DateTime? lastUpdated;
  final String? id;

  factory SkillElement.fromJson(String str) => SkillElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SkillElement.fromMap(Map<String, dynamic> json) => SkillElement(
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

class Skill {
  Skill({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Skill.fromJson(String str) => Skill.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Skill.fromMap(Map<String, dynamic> json) => Skill(
    id: json["_id"],
    name: json["name"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "name": name,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class SocialUrl {
  SocialUrl({
    this.id,
  });

  final String? id;

  factory SocialUrl.fromJson(String str) => SocialUrl.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SocialUrl.fromMap(Map<String, dynamic> json) => SocialUrl(
    id: json["_id"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
  };
}

class Title {
  Title({
    this.data,
    this.name,
  });

  final TitleData? data;
  final String? name;

  factory Title.fromJson(String str) => Title.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Title.fromMap(Map<String, dynamic> json) => Title(
    data: json["data"] == null ? null : TitleData.fromMap(json["data"]),
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "data": data?.toMap(),
    "name": name,
  };
}

class TitleData {
  TitleData({
    this.id,
    this.description,
    this.industry,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  final String? id;
  final String? description;
  final String? industry;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;

  factory TitleData.fromJson(String str) => TitleData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TitleData.fromMap(Map<String, dynamic> json) => TitleData(
    id: json["_id"],
    description: json["description"],
    industry: json["industry"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "description": description,
    "industry": industry,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "name": name,
  };
}
