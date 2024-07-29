class Requisition {
  String? id;
  RequestedBy? requestedBy;
  String? title;
  String? department;
  String? project;
  List<String>? jobMode;
  String? description;
  List<RequiredSkill>? requiredSkills;
  int? budgetAllocation;
  int? openingsCount;
  String? status;
  List<String>? assignedRecruiters;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? version;

  Requisition({
    this.id,
    this.requestedBy,
    this.title,
    this.department,
    this.project,
    this.jobMode,
    this.description,
    this.requiredSkills,
    this.budgetAllocation,
    this.openingsCount,
    this.status,
    this.assignedRecruiters,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory Requisition.fromJson(Map<String, dynamic> json) {
    return Requisition(
      id: json['_id'],
      requestedBy: RequestedBy.fromMap(json['requestedBy']),
      title: json['title'],
      department: json['department'],
      project: json['project'],
      jobMode: json['jobMode'] != null
          ? List<String>.from(json['jobMode'])
          : [],
      description: json['description'],
      requiredSkills: json['requiredSkills'] != null
          ? List<RequiredSkill>.from(json['requiredSkills'].map((x) => RequiredSkill.fromMap(x)))
          : [],
      budgetAllocation: json['budgetAllocation'],
      openingsCount: json['openingsCount'],
      status: json['status'],
      assignedRecruiters: json['assignedRecruiters'] != null
          ? List<String>.from(json['assignedRecruiters'])
          : [],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'requestedBy': requestedBy?.toJson(),
      'title': title,
      'department': department,
      'project': project,
      'jobMode': jobMode,
      'description': description,
      'requiredSkills': List<Map<String, dynamic>>.from(requiredSkills?.map((x) => x.toJson()) ?? []),
      'budgetAllocation': budgetAllocation,
      'openingsCount': openingsCount,
      'status': status,
      'assignedRecruiters': List<String>.from(assignedRecruiters?.map((x) => x) ?? []),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': version,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  factory Requisition.fromMap(Map<String, dynamic> map) {
    return Requisition.fromJson(map);
  }

  static List<Map<String, dynamic>> toJsonList(List<Requisition> requisitions) {
    return requisitions.map((requisition) => requisition.toJson()).toList();
  }

  static List<Requisition> fromJsonList(jsonList) {
    List<Requisition> tempList = [];
    for (var list in jsonList) {
      tempList.add(Requisition.fromMap(list));
    }
    return tempList;
  }
}

class RequestedBy {
  String? id;
  Company? company;
  String? email;
  // String? password;
  // String? role;
  // DateTime? createdAt;
  // DateTime? updatedAt;
  // int? version;

  RequestedBy({
    this.id,
    this.company,
    this.email,
    // this.password,
    // this.role,
    // this.createdAt,
    // this.updatedAt,
    // this.version,
  });

  factory RequestedBy.fromJson(Map<String, dynamic> json) {
    return RequestedBy(
      id: json['_id'],
      company: Company.fromMap(json['company']),
      email: json['email'],
      // password: json['password'],
      // role: json['role'],
      // createdAt: DateTime.parse(json['createdAt']),
      // updatedAt: DateTime.parse(json['updatedAt']),
      // version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'company': company?.toJson(),
      'email': email,
      // 'password': password,
      // 'role': role,
      // 'createdAt': createdAt?.toIso8601String(),
      // 'updatedAt': updatedAt?.toIso8601String(),
      // '__v': version,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  factory RequestedBy.fromMap(Map<String, dynamic> map) {
    return RequestedBy.fromJson(map);
  }
}

class SocialUrl {
  String? id;
  String? platform;
  String? url;

  SocialUrl({this.id, this.platform, this.url});

  factory SocialUrl.fromJson(Map<String, dynamic> json) {
    return SocialUrl(
      id: json['_id'],
      platform: json['platform'],
      url: json['url'],
    );
  }

  factory SocialUrl.fromMap(Map<String, dynamic> map) {
    return SocialUrl(
      id: map['_id'],
      platform: map['platform'],
      url: map['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'platform': platform,
      'url': url,
    };
  }
}

class Company {
  String? id;
  String? name;
  String? description;
  String? officialEmail;
  List<SocialUrl>? socialUrls;
  String? industry;

  Company({
    this.id,
    this.name,
    this.description,
    this.officialEmail,
    this.socialUrls,
    this.industry,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      officialEmail: json['officialEmail'],
      socialUrls: json['socialUrls'] != null
          ? List<SocialUrl>.from(
          json['socialUrls'].map((x) => SocialUrl.fromJson(x)))
          : null,
      industry: json['industry'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'officialEmail': officialEmail,
      'socialUrls': socialUrls,
      'industry': industry,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company.fromJson(map);
  }
}

class RequiredSkill {
  Skill? skill;
  int? rating;
  DateTime? lastUpdated;
  String? id;

  RequiredSkill({
    this.skill,
    this.rating,
    this.lastUpdated,
    this.id,
  });

  factory RequiredSkill.fromJson(Map<String, dynamic> json) {
    return RequiredSkill(
      skill: Skill.fromMap(json['skill']),
      rating: json['rating'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'skill': skill?.toJson(),
      'rating': rating,
      'lastUpdated': lastUpdated?.toIso8601String(),
      '_id': id,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  factory RequiredSkill.fromMap(Map<String, dynamic> map) {
    return RequiredSkill.fromJson(map);
  }
}

class Skill {
  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  Skill({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['_id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill.fromJson(map);
  }
}
