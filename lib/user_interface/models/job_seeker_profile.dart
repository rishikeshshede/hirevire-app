import 'dart:convert';

import 'package:hirevire_app/user_interface/models/job_recommendations.dart';

class JobSeekerProfile {
  String? headline;
  Location? location;
  String? id;
  String? name;
  String? email;
  String? phone;
  DateTime? birthDate;
  List<Experience>? experience;
  List<SkillElement>? skills;
  List<String>? preferredJobModes;
  List<String>? applications;
  List<SocialUrl>? socialUrls;
  List<String>? media;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bio;
  String? profilePicUrl;
  String? status;
  DateTime? updatedTime;
  List<ProfileView>? profileViews;
  int? totalProfileViewCount;

  JobSeekerProfile({
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
    this.updatedTime,
    this.profileViews,
    this.totalProfileViewCount,
  });

  JobSeekerProfile copyWith({
    String? headline,
    Location? location,
    String? id,
    String? name,
    String? email,
    String? phone,
    DateTime? birthDate,
    List<Experience>? experience,
    List<SkillElement>? skills,
    List<String>? preferredJobModes,
    List<String>? applications,
    List<SocialUrl>? socialUrls,
    List<String>? media,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? bio,
    String? profilePicUrl,
    String? status,
    DateTime? updatedTime,
    List<ProfileView>? profileViews,
    int? totalProfileViewCount,
  }) =>
      JobSeekerProfile(
        headline: headline ?? this.headline,
        location: location ?? this.location,
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        birthDate: birthDate ?? this.birthDate,
        experience: experience ?? this.experience,
        skills: skills ?? this.skills,
        preferredJobModes: preferredJobModes ?? this.preferredJobModes,
        applications: applications ?? this.applications,
        socialUrls: socialUrls ?? this.socialUrls,
        media: media ?? this.media,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        bio: bio ?? this.bio,
        profilePicUrl: profilePicUrl ?? this.profilePicUrl,
        status: status ?? this.status,
        updatedTime: updatedTime ?? this.updatedTime,
        profileViews: profileViews ?? this.profileViews,
        totalProfileViewCount:
            totalProfileViewCount ?? this.totalProfileViewCount,
      );

  factory JobSeekerProfile.fromJson(String str) =>
      JobSeekerProfile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JobSeekerProfile.fromMap(Map<String, dynamic> json) =>
      JobSeekerProfile(
        headline: json["headline"],
        location: json["location"] == null
            ? null
            : Location.fromMap(json["location"]),
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        birthDate: json["birthDate"] == null
            ? null
            : DateTime.parse(json["birthDate"]),
        experience: json["experience"] == null
            ? []
            : List<Experience>.from(
                json["experience"]!.map((x) => Experience.fromMap(x))),
        skills: json["skills"] == null
            ? []
            : List<SkillElement>.from(
                json["skills"]!.map((x) => SkillElement.fromMap(x))),
        preferredJobModes: json["preferredJobModes"] == null
            ? []
            : List<String>.from(json["preferredJobModes"]!.map((x) => x)),
        applications: json["applications"] == null
            ? []
            : List<String>.from(json["applications"]!.map((x) => x)),
        socialUrls: json["socialUrls"] == null
            ? []
            : List<SocialUrl>.from(
                json["socialUrls"]!.map((x) => SocialUrl.fromMap(x))),
        media: json["media"] == null
            ? []
            : List<String>.from(json["media"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        bio: json["bio"],
        profilePicUrl: json["profilePicUrl"],
        status: json["status"],
        updatedTime: json["updatedTime"] == null
            ? null
            : DateTime.parse(json["updatedTime"]),
        profileViews: json["profileViews"] == null
            ? []
            : List<ProfileView>.from(
                json["profileViews"]!.map((x) => ProfileView.fromMap(x))),
        totalProfileViewCount: json["totalProfileViewCount"],
      );

  Map<String, dynamic> toMap() => {
        "headline": headline,
        "location": location?.toMap(),
        "_id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "birthDate": birthDate?.toIso8601String(),
        "experience": experience == null
            ? []
            : List<dynamic>.from(experience!.map((x) => x.toMap())),
        "skills": skills == null
            ? []
            : List<dynamic>.from(skills!.map((x) => x.toMap())),
        "preferredJobModes": preferredJobModes == null
            ? []
            : List<dynamic>.from(preferredJobModes!.map((x) => x)),
        "applications": applications == null
            ? []
            : List<dynamic>.from(applications!.map((x) => x)),
        "socialUrls": socialUrls == null
            ? []
            : List<dynamic>.from(socialUrls!.map((x) => x.toMap())),
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "bio": bio,
        "profilePicUrl": profilePicUrl,
        "status": status,
        "updatedTime": updatedTime?.toIso8601String(),
        "profileViews": profileViews == null
            ? []
            : List<dynamic>.from(profileViews!.map((x) => x.toMap())),
        "totalProfileViewCount": totalProfileViewCount,
      };
}

class Experience {
  Title? title;
  Company? company;
  Location? location;
  String? id;
  String? description;
  List<Media>? media;
  String? employmentType;
  String? jobMode;
  DateTime? startDate;
  DateTime? endDate;
  bool? stillWorking;
  List<String>? skills;
  DateTime? createdAt;
  DateTime? updatedAt;

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

  Experience copyWith({
    Title? title,
    Company? company,
    Location? location,
    String? id,
    String? description,
    List<Media>? media,
    String? employmentType,
    String? jobMode,
    DateTime? startDate,
    DateTime? endDate,
    bool? stillWorking,
    List<String>? skills,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Experience(
        title: title ?? this.title,
        company: company ?? this.company,
        location: location ?? this.location,
        id: id ?? this.id,
        description: description ?? this.description,
        media: media ?? this.media,
        employmentType: employmentType ?? this.employmentType,
        jobMode: jobMode ?? this.jobMode,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        stillWorking: stillWorking ?? this.stillWorking,
        skills: skills ?? this.skills,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Experience.fromJson(String str) =>
      Experience.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Experience.fromMap(Map<String, dynamic> json) => Experience(
        title: json["title"] == null ? null : Title.fromMap(json["title"]),
        company:
            json["company"] == null ? null : Company.fromMap(json["company"]),
        location: json["location"] == null
            ? null
            : Location.fromMap(json["location"]),
        id: json["_id"],
        description: json["description"],
        media: json["media"] == null
            ? []
            : List<Media>.from(json["media"]!.map((x) => Media.fromMap(x))),
        employmentType: json["employmentType"],
        jobMode: json["jobMode"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        stillWorking: json["stillWorking"],
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "title": title?.toMap(),
        "company": company?.toMap(),
        "location": location?.toMap(),
        "_id": id,
        "description": description,
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toMap())),
        "employmentType": employmentType,
        "jobMode": jobMode,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "stillWorking": stillWorking,
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Company {
  CompanyData? data;
  String? name;

  Company({
    this.data,
    this.name,
  });

  Company copyWith({
    CompanyData? data,
    String? name,
  }) =>
      Company(
        data: data ?? this.data,
        name: name ?? this.name,
      );

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
  String? id;
  String? name;
  String? address;
  String? website;
  String? industry;
  String? logoUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

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

  CompanyData copyWith({
    String? id,
    String? name,
    String? address,
    String? website,
    String? industry,
    String? logoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CompanyData(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        website: website ?? this.website,
        industry: industry ?? this.industry,
        logoUrl: logoUrl ?? this.logoUrl,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CompanyData.fromJson(String str) =>
      CompanyData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CompanyData.fromMap(Map<String, dynamic> json) => CompanyData(
        id: json["_id"],
        name: json["name"],
        address: json["address"],
        website: json["website"],
        industry: json["industry"],
        logoUrl: json["logoUrl"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
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

class Location {
  Address? address;
  String? country;
  String? state;
  String? city;

  Location({
    this.address,
    this.country,
    this.state,
    this.city,
  });

  Location copyWith({
    Address? address,
    String? country,
    String? state,
    String? city,
  }) =>
      Location(
        address: address ?? this.address,
        country: country ?? this.country,
        state: state ?? this.state,
        city: city ?? this.city,
      );

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        address:
            json["address"] == null ? null : Address.fromMap(json["address"]),
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

  Address({
    this.line1,
    this.line2,
  });

  Address copyWith({
    String? line1,
    String? line2,
  }) =>
      Address(
        line1: line1 ?? this.line1,
        line2: line2 ?? this.line2,
      );

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

class Media {
  String? title;
  String? url;
  String? type;
  String? thumbnail;
  String? id;

  Media({
    this.title,
    this.url,
    this.type,
    this.thumbnail,
    this.id,
  });

  Media copyWith({
    String? title,
    String? url,
    String? type,
    String? thumbnail,
    String? id,
  }) =>
      Media(
        title: title ?? this.title,
        url: url ?? this.url,
        type: type ?? this.type,
        thumbnail: thumbnail ?? this.thumbnail,
        id: id ?? this.id,
      );

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

class Title {
  TitleData? data;
  String? name;

  Title({
    this.data,
    this.name,
  });

  Title copyWith({
    TitleData? data,
    String? name,
  }) =>
      Title(
        data: data ?? this.data,
        name: name ?? this.name,
      );

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
  String? id;
  String? description;
  String? industry;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;

  TitleData({
    this.id,
    this.description,
    this.industry,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  TitleData copyWith({
    String? id,
    String? description,
    String? industry,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
  }) =>
      TitleData(
        id: id ?? this.id,
        description: description ?? this.description,
        industry: industry ?? this.industry,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        name: name ?? this.name,
      );

  factory TitleData.fromJson(String str) => TitleData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TitleData.fromMap(Map<String, dynamic> json) => TitleData(
        id: json["_id"],
        description: json["description"],
        industry: json["industry"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
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

class ProfileView {
  String? id;
  String? recruiterId;
  DateTime? viewedAt;

  ProfileView({
    this.id,
    this.recruiterId,
    this.viewedAt,
  });

  ProfileView copyWith({
    String? id,
    String? recruiterId,
    DateTime? viewedAt,
  }) =>
      ProfileView(
        id: id ?? this.id,
        recruiterId: recruiterId ?? this.recruiterId,
        viewedAt: viewedAt ?? this.viewedAt,
      );

  factory ProfileView.fromJson(String str) =>
      ProfileView.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileView.fromMap(Map<String, dynamic> json) => ProfileView(
        id: json["_id"],
        recruiterId: json["recruiterId"],
        viewedAt:
            json["viewedAt"] == null ? null : DateTime.parse(json["viewedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "recruiterId": recruiterId,
        "viewedAt": viewedAt?.toIso8601String(),
      };
}

class SkillElement {
  SkillSkill? skill;
  int? rating;
  DateTime? lastUpdated;
  String? id;

  SkillElement({
    this.skill,
    this.rating,
    this.lastUpdated,
    this.id,
  });

  SkillElement copyWith({
    SkillSkill? skill,
    int? rating,
    DateTime? lastUpdated,
    String? id,
  }) =>
      SkillElement(
        skill: skill ?? this.skill,
        rating: rating ?? this.rating,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        id: id ?? this.id,
      );

  factory SkillElement.fromJson(String str) =>
      SkillElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SkillElement.fromMap(Map<String, dynamic> json) => SkillElement(
        skill: json["skill"] == null ? null : SkillSkill.fromMap(json["skill"]),
        rating: json["rating"],
        lastUpdated: json["lastUpdated"] == null
            ? null
            : DateTime.parse(json["lastUpdated"]),
        id: json["_id"],
      );

  Map<String, dynamic> toMap() => {
        "skill": skill?.toMap(),
        "rating": rating,
        "lastUpdated": lastUpdated?.toIso8601String(),
        "_id": id,
      };
}

class SkillSkill {
  String? id;
  String? name;
  String? category;
  String? subcategory;
  DateTime? createdAt;
  DateTime? updatedAt;

  SkillSkill({
    this.id,
    this.name,
    this.category,
    this.subcategory,
    this.createdAt,
    this.updatedAt,
  });

  SkillSkill copyWith({
    String? id,
    String? name,
    String? category,
    String? subcategory,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      SkillSkill(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        subcategory: subcategory ?? this.subcategory,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory SkillSkill.fromJson(String str) =>
      SkillSkill.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SkillSkill.fromMap(Map<String, dynamic> json) => SkillSkill(
        id: json["_id"],
        name: json["name"],
        category: json["category"],
        subcategory: json["subcategory"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "category": category,
        "subcategory": subcategory,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

// class SocialUrl {
//   String? id;
//   String? platform;
//   String? url;

//   SocialUrl({
//     this.id,
//     this.platform,
//     this.url,
//   });

//   SocialUrl copyWith({
//     String? id,
//     String? platform,
//     String? url,
//   }) =>
//       SocialUrl(
//         id: id ?? this.id,
//         platform: platform ?? this.platform,
//         url: url ?? this.url,
//       );

//   factory SocialUrl.fromJson(String str) => SocialUrl.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory SocialUrl.fromMap(Map<String, dynamic> json) => SocialUrl(
//         id: json["_id"],
//         platform: json["platform"],
//         url: json["url"],
//       );

//   Map<String, dynamic> toMap() => {
//         "_id": id,
//         "platform": platform,
//         "url": url,
//       };
// }
