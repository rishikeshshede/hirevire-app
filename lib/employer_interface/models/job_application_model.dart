class JobApplication {
  String? id;
  JobPostId? jobPostId;
  AppliedBy? appliedBy;
  List<Media>? media;
  List<Answer>? answers;
  String? status;
  List<RequiredSkill>? requiredSkills;
  DateTime? updatedTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  JobApplication({
    this.id,
    this.jobPostId,
    this.appliedBy,
    this.media,
    this.answers,
    this.status,
    this.requiredSkills,
    this.updatedTime,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory JobApplication.fromJson(Map<String, dynamic> json) {
    return JobApplication(
      id: json['_id'],
      jobPostId: json['jobPostId'] != null
          ? JobPostId.fromJson(json['jobPostId'])
          : null,
      appliedBy: json['appliedBy'] != null
          ? AppliedBy.fromJson(json['appliedBy'])
          : null,
      media: json['media'] != null
          ? List<Media>.from(json['media'].map((x) => Media.fromJson(x)))
          : null,
      answers: json['answers'] != null
          ? List<Answer>.from(json['answers'].map((x) => Answer.fromJson(x)))
          : null,
      status: json['status'],
      requiredSkills: json['requiredSkills'] != null
          ? List<RequiredSkill>.from(
              json['requiredSkills'].map((x) => RequiredSkill.fromJson(x)))
          : null,
      updatedTime: json['updatedTime'] != null
          ? DateTime.parse(json['updatedTime'])
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'jobPostId': jobPostId?.toMap(),
      'appliedBy': appliedBy?.toMap(),
      'media': media != null
          ? List<dynamic>.from(media!.map((x) => x.toMap()))
          : null,
      'answers': answers != null
          ? List<dynamic>.from(answers!.map((x) => x.toMap()))
          : null,
      'status': status,
      'requiredSkills': requiredSkills != null
          ? List<dynamic>.from(requiredSkills!.map((x) => x.toMap()))
          : null,
      'updatedTime': updatedTime?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }

  factory JobApplication.fromMap(Map<String, dynamic> map) {
    return JobApplication(
      id: map['_id'],
      jobPostId:
          map['jobPostId'] != null ? JobPostId.fromMap(map['jobPostId']) : null,
      appliedBy:
          map['appliedBy'] != null ? AppliedBy.fromMap(map['appliedBy']) : null,
      media: map['media'] != null
          ? List<Media>.from(map['media'].map((x) => Media.fromMap(x)))
          : null,
      answers: map['answers'] != null
          ? List<Answer>.from(map['answers'].map((x) => Answer.fromMap(x)))
          : null,
      status: map['status'],
      requiredSkills: map['requiredSkills'] != null
          ? List<RequiredSkill>.from(
              map['requiredSkills'].map((x) => RequiredSkill.fromMap(x)))
          : null,
      updatedTime: map['updatedTime'] != null
          ? DateTime.parse(map['updatedTime'])
          : null,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      v: map['__v'],
    );
  }

  static List<JobApplication> fromJsonList(jsonList) {
    List<JobApplication> tempList = [];
    for (var list in jsonList) {
      tempList.add(JobApplication.fromMap(list));
    }
    return tempList;
  }
}

class JobPostId {
  Location? location;
  String? id;
  PostedBy? postedBy;
  RequestedBy? requestedBy;
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
  List<dynamic>? leftSwipes;

  JobPostId({
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

  factory JobPostId.fromMap(Map<String, dynamic> map) {
    return JobPostId(
      location:
          map['location'] != null ? Location.fromMap(map['location']) : null,
      id: map['_id'],
      postedBy:
          map['postedBy'] != null ? PostedBy.fromMap(map['postedBy']) : null,
      requestedBy: map['requestedBy'] != null
          ? RequestedBy.fromMap(map['requestedBy'])
          : null,
      jobRequisition: map['jobRequisition'] != null
          ? JobRequisition.fromMap(map['jobRequisition'])
          : null,
      title: map['title'],
      department: map['department'],
      project: map['project'],
      jobMode:
          map['jobMode'] != null ? List<String>.from(map['jobMode']) : null,
      description: map['description'],
      ctc: map['ctc'],
      status: map['status'],
      questions: map['questions'] != null
          ? List<Question>.from(
              map['questions'].map((x) => Question.fromMap(x)))
          : null,
      growthPlan: map['growth_plan'] != null
          ? List<GrowthPlan>.from(
              map['growth_plan'].map((x) => GrowthPlan.fromMap(x)))
          : null,
      perks: map['perks'],
      requiredSkills: map['requiredSkills'] != null
          ? List<RequiredSkill>.from(
              map['requiredSkills'].map((x) => RequiredSkill.fromMap(x)))
          : null,
      media: map['media'] != null
          ? List<Media>.from(map['media'].map((x) => Media.fromMap(x)))
          : null,
      endsOn: map['endsOn'] != null ? DateTime.parse(map['endsOn']) : null,
      savedApplications: map['savedApplications'] != null
          ? List<String>.from(map['savedApplications'])
          : null,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      v: map['__v'],
      leftSwipes: map['leftSwipes'],
    );
  }

  factory JobPostId.fromJson(Map<String, dynamic> json) {
    return JobPostId(
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      id: json['_id'],
      postedBy:
          json['postedBy'] != null ? PostedBy.fromJson(json['postedBy']) : null,
      requestedBy: json['requestedBy'] != null
          ? RequestedBy.fromJson(json['requestedBy'])
          : null,
      jobRequisition: json['jobRequisition'] != null
          ? JobRequisition.fromJson(json['jobRequisition'])
          : null,
      title: json['title'],
      department: json['department'],
      project: json['project'],
      jobMode:
          json['jobMode'] != null ? List<String>.from(json['jobMode']) : null,
      description: json['description'],
      ctc: json['ctc'],
      status: json['status'],
      questions: json['questions'] != null
          ? List<Question>.from(
              json['questions'].map((x) => Question.fromJson(x)))
          : null,
      growthPlan: json['growth_plan'] != null
          ? List<GrowthPlan>.from(
              json['growth_plan'].map((x) => GrowthPlan.fromJson(x)))
          : null,
      perks: json['perks'],
      requiredSkills: json['requiredSkills'] != null
          ? List<RequiredSkill>.from(
              json['requiredSkills'].map((x) => RequiredSkill.fromJson(x)))
          : null,
      media: json['media'] != null
          ? List<Media>.from(json['media'].map((x) => Media.fromJson(x)))
          : null,
      endsOn: json['endsOn'] != null ? DateTime.parse(json['endsOn']) : null,
      savedApplications: json['savedApplications'] != null
          ? List<String>.from(json['savedApplications'])
          : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
      leftSwipes: json['leftSwipes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location?.toMap(),
      '_id': id,
      'postedBy': postedBy?.toMap(),
      'requestedBy': requestedBy?.toMap(),
      'jobRequisition': jobRequisition?.toMap(),
      'title': title,
      'department': department,
      'project': project,
      'jobMode': jobMode,
      'description': description,
      'ctc': ctc,
      'status': status,
      'questions': questions != null
          ? List<dynamic>.from(questions!.map((x) => x.toMap()))
          : null,
      'growth_plan': growthPlan != null
          ? List<dynamic>.from(growthPlan!.map((x) => x.toMap()))
          : null,
      'perks': perks,
      'requiredSkills': requiredSkills != null
          ? List<dynamic>.from(requiredSkills!.map((x) => x.toMap()))
          : null,
      'media': media != null
          ? List<dynamic>.from(media!.map((x) => x.toMap()))
          : null,
      'endsOn': endsOn?.toIso8601String(),
      'savedApplications': savedApplications,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
      'leftSwipes': leftSwipes,
    };
  }
}

class Location {
  String? country;
  String? city;

  Location({this.country, this.city});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      country: json['country'],
      city: json['city'],
    );
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      country: map['country'],
      city: map['city'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'city': city,
    };
  }
}

class PostedBy {
  String? id;
  String? name;
  String? description;
  String? officialEmail;
  String? industry;
  List<SocialUrl>? socialUrls;

  PostedBy(
      {this.id,
      this.name,
      this.description,
      this.officialEmail,
      this.industry,
      this.socialUrls});

  factory PostedBy.fromJson(Map<String, dynamic> json) {
    return PostedBy(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      officialEmail: json['officialEmail'],
      industry: json['industry'],
      socialUrls: json['socialUrls'] != null
          ? List<SocialUrl>.from(
              json['socialUrls'].map((x) => SocialUrl.fromJson(x)))
          : null,
    );
  }

  factory PostedBy.fromMap(Map<String, dynamic> map) {
    return PostedBy(
      id: map['_id'],
      name: map['name'],
      description: map['description'],
      officialEmail: map['officialEmail'],
      industry: map['industry'],
      socialUrls: map['socialUrls'] != null
          ? List<SocialUrl>.from(
              map['socialUrls'].map((x) => SocialUrl.fromMap(x)))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'officialEmail': officialEmail,
      'industry': industry,
      'socialUrls': socialUrls != null
          ? List<dynamic>.from(socialUrls!.map((x) => x.toMap()))
          : null,
    };
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

class RequestedBy {
  String? id;
  String? email;
  String? name;

  RequestedBy({this.id, this.email, this.name});

  factory RequestedBy.fromJson(Map<String, dynamic> json) {
    return RequestedBy(
      id: json['_id'],
      email: json['email'],
      name: json['name'],
    );
  }

  factory RequestedBy.fromMap(Map<String, dynamic> map) {
    return RequestedBy(
      id: map['_id'],
      email: map['email'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'email': email,
      'name': name,
    };
  }
}

class JobRequisition {
  String? id;
  String? title;

  JobRequisition({this.id, this.title});

  factory JobRequisition.fromJson(Map<String, dynamic> json) {
    return JobRequisition(
      id: json['_id'],
      title: json['title'],
    );
  }

  factory JobRequisition.fromMap(Map<String, dynamic> map) {
    return JobRequisition(
      id: map['_id'],
      title: map['title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
    };
  }
}

class Question {
  String? type;
  List<String>? options;
  String? id;
  String? content;

  Question({this.type, this.options, this.id, this.content});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      type: json['type'],
      options:
          json['options'] != null ? List<String>.from(json['options']) : null,
      id: json['_id'],
      content: json['content'],
    );
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      type: map['type'],
      options:
          map['options'] != null ? List<String>.from(map['options']) : null,
      id: map['_id'],
      content: map['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'options': options,
      '_id': id,
      'content': content,
    };
  }
}

class GrowthPlan {
  String? title;
  String? description;
  String? id;

  GrowthPlan({this.title, this.description, this.id});

  factory GrowthPlan.fromJson(Map<String, dynamic> json) {
    return GrowthPlan(
      title: json['title'],
      description: json['description'],
      id: json['_id'],
    );
  }

  factory GrowthPlan.fromMap(Map<String, dynamic> map) {
    return GrowthPlan(
      title: map['title'],
      description: map['description'],
      id: map['_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      '_id': id,
    };
  }
}

class RequiredSkill {
  Skill? skill;
  int? rating;
  DateTime? lastUpdated;
  String? id;

  RequiredSkill({this.skill, this.rating, this.lastUpdated, this.id});

  factory RequiredSkill.fromJson(Map<String, dynamic> json) {
    return RequiredSkill(
      skill: json['skill'] != null ? Skill.fromJson(json['skill']) : null,
      rating: json['rating'],
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : null,
      id: json['_id'],
    );
  }

  factory RequiredSkill.fromMap(Map<String, dynamic> map) {
    return RequiredSkill(
      skill: map['skill'] != null ? Skill.fromMap(map['skill']) : null,
      rating: map['rating'],
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.parse(map['lastUpdated'])
          : null,
      id: map['_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'skill': skill?.toMap(),
      'rating': rating,
      'lastUpdated': lastUpdated?.toIso8601String(),
      '_id': id,
    };
  }
}

class Skill {
  String? id;
  String? name;

  Skill({this.id, this.name});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['_id'],
      name: json['name'],
    );
  }

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      id: map['_id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

class Media {
  String? url;
  String? type;
  String? thumbnail;
  String? id;

  Media({this.url, this.type, this.thumbnail, this.id});

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      url: json['url'],
      type: json['type'],
      thumbnail: json['thumbnail'],
      id: json['_id'],
    );
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      url: map['url'],
      type: map['type'],
      thumbnail: map['thumbnail'],
      id: map['_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'type': type,
      'thumbnail': thumbnail,
      '_id': id,
    };
  }
}

class AppliedBy {
  String? id;
  String? name;
  String? email;
  String? profilePicUrl;
  String? headline;
  String? bio;
  List<SocialUrl>? socialUrls;
  DateTime? updatedTime;
  int? totalProfileViewCount;

  AppliedBy({
    this.id,
    this.name,
    this.email,
    this.profilePicUrl,
    this.headline,
    this.bio,
    this.socialUrls,
    this.updatedTime,
    this.totalProfileViewCount,
  });

  factory AppliedBy.fromJson(Map<String, dynamic> json) {
    return AppliedBy(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      profilePicUrl: json['profilePicUrl'],
      headline: json['headline'],
      bio: json['bio'],
      socialUrls: json['socialUrls'],
      updatedTime: json['updatedTime'],
      totalProfileViewCount: json['totalProfileViewCount'],
    );
  }

  factory AppliedBy.fromMap(Map<String, dynamic> map) {
    return AppliedBy(
      id: map['_id'],
      name: map['name'],
      email: map['email'],
      profilePicUrl: map['profilePicUrl'],
      headline: map['headline'],
      bio: map['bio'],
      socialUrls: map["socialUrls"] == null
          ? []
          : List<SocialUrl>.from(
              map["socialUrls"].map((x) => SocialUrl.fromMap(x))),
      updatedTime: map['updatedTime'] == null
          ? null
          : DateTime.parse(map['updatedTime']),
      totalProfileViewCount: map['totalProfileViewCount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'profilePicUrl': profilePicUrl,
      'headline': headline,
      'bio': bio,
      "socialUrls": socialUrls == null
          ? []
          : List<dynamic>.from(socialUrls!.map((x) => x.toMap())),
      'updatedTime': updatedTime?.toIso8601String(),
      'totalProfileViewCount': totalProfileViewCount,
    };
  }
}

class Answer {
  String? question;
  String? type;
  List<String>? options;
  String? answer;
  String? id;

  Answer({this.question, this.type, this.options, this.answer, this.id});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      question: json['question'],
      type: json['type'],
      options:
          json['options'] != null ? List<String>.from(json['options']) : null,
      answer: json['answer'],
      id: json['_id'],
    );
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      question: map['question'],
      type: map['type'],
      options:
          map['options'] != null ? List<String>.from(map['options']) : null,
      answer: map['answer'],
      id: map['_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'type': type,
      'options': options,
      'answer': answer,
      '_id': id,
    };
  }
}
