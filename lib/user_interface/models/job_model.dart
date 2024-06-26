import 'dart:convert';

import 'package:hirevire_app/utils/log_handler.dart';

class JobModel {
  String? id;
  String? companyLogoUrl;
  String? companyName;
  DateTime? postedOn;
  String? videoUrl;
  String? refId;
  int? applicants;
  String? recruiter;
  String? recruiterDesignation;
  dynamic transactionDate;
  String? jobTitle;
  String? location;
  String? ctc;
  List<String>? skills;
  List<GrowthPlan>? growthPlan;
  String? perks;
  List<SocialHandle>? socialHandles;

  JobModel({
    this.id,
    this.companyLogoUrl,
    this.companyName,
    this.postedOn,
    this.videoUrl,
    this.refId,
    this.applicants,
    this.recruiter,
    this.recruiterDesignation,
    this.transactionDate,
    this.jobTitle,
    this.location,
    this.ctc,
    this.skills,
    this.growthPlan,
    this.perks,
    this.socialHandles,
  });

  JobModel copyWith({
    String? id,
    String? companyLogoUrl,
    String? companyName,
    DateTime? postedOn,
    String? videoUrl,
    String? refId,
    int? applicants,
    String? recruiter,
    String? recruiterDesignation,
    dynamic transactionDate,
    String? jobTitle,
    String? location,
    String? ctc,
    List<String>? skills,
    List<GrowthPlan>? growthPlan,
    String? perks,
    List<SocialHandle>? socialHandles,
  }) =>
      JobModel(
        id: id ?? this.id,
        companyLogoUrl: companyLogoUrl ?? this.companyLogoUrl,
        companyName: companyName ?? this.companyName,
        postedOn: postedOn ?? this.postedOn,
        videoUrl: videoUrl ?? this.videoUrl,
        refId: refId ?? this.refId,
        applicants: applicants ?? this.applicants,
        recruiter: recruiter ?? this.recruiter,
        recruiterDesignation: recruiterDesignation ?? this.recruiterDesignation,
        transactionDate: transactionDate ?? this.transactionDate,
        jobTitle: jobTitle ?? this.jobTitle,
        location: location ?? this.location,
        ctc: ctc ?? this.ctc,
        skills: skills ?? this.skills,
        growthPlan: growthPlan ?? this.growthPlan,
        perks: perks ?? this.perks,
        socialHandles: socialHandles ?? this.socialHandles,
      );

  JobModel fromJson(String str) => JobModel.fromMap(json.decode(str));

  List<JobModel> fromJsonList(jsonList) {
    try {
      final List<dynamic> decodedList = json.decode(jsonList);
      return decodedList.map((job) => JobModel.fromMap(job)).toList();
    } catch (e) {
      LogHandler.debug('Error decoding JSON: $e');
      return [];
    }
  }

  String toJson() => json.encode(toMap());

  factory JobModel.fromMap(Map<String, dynamic> json) => JobModel(
        id: json["id"],
        companyLogoUrl: json["company_logo_url"],
        companyName: json["company_name"],
        postedOn:
            json["postedOn"] == null ? null : DateTime.parse(json["postedOn"]),
        videoUrl: json["video_url"],
        refId: json["ref_id"],
        applicants: json["applicants"],
        recruiter: json["recruiter"],
        recruiterDesignation: json["recruiter_designation"],
        transactionDate: json["transaction_date"],
        jobTitle: json["job_title"],
        location: json["location"],
        ctc: json["ctc"],
        skills: json["skills"] == null
            ? []
            : List<String>.from(json["skills"]!.map((x) => x)),
        growthPlan: json["growth_plan"] == null
            ? []
            : List<GrowthPlan>.from(
                json["growth_plan"]!.map((x) => GrowthPlan.fromMap(x))),
        perks: json["perks"],
        socialHandles: json["social_handles"] == null
            ? []
            : List<SocialHandle>.from(
                json["social_handles"]!.map((x) => SocialHandle.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "company_logo_url": companyLogoUrl,
        "company_name": companyName,
        "postedOn":
            "${postedOn!.year.toString().padLeft(4, '0')}-${postedOn!.month.toString().padLeft(2, '0')}-${postedOn!.day.toString().padLeft(2, '0')}",
        "video_url": videoUrl,
        "ref_id": refId,
        "applicants": applicants,
        "recruiter": recruiter,
        "recruiter_designation": recruiterDesignation,
        "transaction_date": transactionDate,
        "job_title": jobTitle,
        "location": location,
        "ctc": ctc,
        "skills":
            skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "growth_plan": growthPlan == null
            ? []
            : List<dynamic>.from(growthPlan!.map((x) => x.toMap())),
        "perks": perks,
        "social_handles": socialHandles == null
            ? []
            : List<dynamic>.from(socialHandles!.map((x) => x.toMap())),
      };
}

class GrowthPlan {
  String? title;
  String? description;

  GrowthPlan({
    this.title,
    this.description,
  });

  GrowthPlan copyWith({
    String? title,
    String? description,
  }) =>
      GrowthPlan(
        title: title ?? this.title,
        description: description ?? this.description,
      );

  factory GrowthPlan.fromJson(String str) =>
      GrowthPlan.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GrowthPlan.fromMap(Map<String, dynamic> json) => GrowthPlan(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
      };
}

class SocialHandle {
  String? platform;
  String? logoUrl;
  String? url;

  SocialHandle({
    this.platform,
    this.logoUrl,
    this.url,
  });

  SocialHandle copyWith({
    String? platform,
    String? logoUrl,
    String? url,
  }) =>
      SocialHandle(
        platform: platform ?? this.platform,
        logoUrl: logoUrl ?? this.logoUrl,
        url: url ?? this.url,
      );

  factory SocialHandle.fromJson(String str) =>
      SocialHandle.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SocialHandle.fromMap(Map<String, dynamic> json) => SocialHandle(
        platform: json["platform"],
        logoUrl: json["logoUrl"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "platform": platform,
        "logoUrl": logoUrl,
        "url": url,
      };
}
