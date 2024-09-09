class MyApplication {
  String? id;
  JobPost? jobPostId;
  String? appliedBy;
  List<Media>? media;
  List<Answer>? answers;
  String? status;
  List<RequiredSkill>? requiredSkills;
  DateTime? updatedTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? feedback;

  MyApplication({
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
    this.feedback,
  });

  factory MyApplication.fromMap(Map<String, dynamic> map) {
    return MyApplication(
      id: map['_id'],
      jobPostId:
          map['jobPostId'] != null ? JobPost.fromMap(map['jobPostId']) : null,
      appliedBy: map['appliedBy'],
      media: map['media'] != null
          ? List<Media>.from(map['media']?.map((x) => Media.fromMap(x)))
          : null,
      answers: map['answers'] != null
          ? List<Answer>.from(map['answers']?.map((x) => Answer.fromMap(x)))
          : null,
      status: map['status'],
      requiredSkills: map['requiredSkills'] != null
          ? List<RequiredSkill>.from(
              map['requiredSkills']?.map((x) => RequiredSkill.fromMap(x)))
          : null,
      updatedTime: map['updatedTime'] != null
          ? DateTime.parse(map['updatedTime'])
          : null,
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      v: map['__v'],
      feedback: map['feedback'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'jobPostId': jobPostId?.toMap(),
      'appliedBy': appliedBy,
      'media': media?.map((x) => x.toMap()).toList(),
      'answers': answers?.map((x) => x.toMap()).toList(),
      'status': status,
      'requiredSkills': requiredSkills?.map((x) => x.toMap()).toList(),
      'updatedTime': updatedTime?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
      'feedback': feedback,
    };
  }

  static List<MyApplication> fromJsonList(jsonList) {
    List<MyApplication> tempList = [];
    for (var list in jsonList) {
      tempList.add(MyApplication.fromMap(list));
    }
    return tempList;
  }
}

class JobPost {
  String? ctc;
  Location? location;
  String? id;
  PostedBy? postedBy;
  RequestedBy? requestedBy;
  dynamic jobRequisition;
  String? title;
  String? department;
  String? project;
  List<String>? jobMode;
  String? description;
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
  List<LeftSwipe>? leftSwipes;

  JobPost({
    this.ctc,
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

  factory JobPost.fromMap(Map<String, dynamic> map) {
    return JobPost(
      ctc: map['ctc'],
      location:
          map['location'] != null ? Location.fromMap(map['location']) : null,
      id: map['_id'],
      postedBy:
          map['postedBy'] != null ? PostedBy.fromMap(map['postedBy']) : null,
      requestedBy: map['requestedBy'] != null
          ? RequestedBy.fromMap(map['requestedBy'])
          : null,
      jobRequisition: map['jobRequisition'],
      title: map['title'],
      department: map['department'],
      project: map['project'],
      jobMode:
          map['jobMode'] != null ? List<String>.from(map['jobMode']) : null,
      description: map['description'],
      status: map['status'],
      questions: map['questions'] != null
          ? List<Question>.from(
              map['questions']?.map((x) => Question.fromMap(x)))
          : null,
      growthPlan: map['growth_plan'] != null
          ? List<GrowthPlan>.from(
              map['growth_plan']?.map((x) => GrowthPlan.fromMap(x)))
          : null,
      perks: map['perks'],
      requiredSkills: map['requiredSkills'] != null
          ? List<RequiredSkill>.from(
              map['requiredSkills']?.map((x) => RequiredSkill.fromMap(x)))
          : null,
      media: map['media'] != null
          ? List<Media>.from(map['media']?.map((x) => Media.fromMap(x)))
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
      leftSwipes: map['leftSwipes'] != null
          ? List<LeftSwipe>.from(
              map['leftSwipes']?.map((x) => LeftSwipe.fromMap(x)))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ctc': ctc,
      'location': location?.toMap(),
      '_id': id,
      'postedBy': postedBy?.toMap(),
      'requestedBy': requestedBy?.toMap(),
      'jobRequisition': jobRequisition,
      'title': title,
      'department': department,
      'project': project,
      'jobMode': jobMode,
      'description': description,
      'status': status,
      'questions': questions?.map((x) => x.toMap()).toList(),
      'growth_plan': growthPlan?.map((x) => x.toMap()).toList(),
      'perks': perks,
      'requiredSkills': requiredSkills?.map((x) => x.toMap()).toList(),
      'media': media?.map((x) => x.toMap()).toList(),
      'endsOn': endsOn?.toIso8601String(),
      'savedApplications': savedApplications,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
      'leftSwipes': leftSwipes?.map((x) => x.toMap()).toList(),
    };
  }
}

class Location {
  String? country;
  String? city;

  Location({
    this.country,
    this.city,
  });

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

  PostedBy({
    this.id,
    this.name,
    this.description,
    this.officialEmail,
    this.industry,
    this.socialUrls,
  });

  factory PostedBy.fromMap(Map<String, dynamic> map) {
    return PostedBy(
      id: map['_id'],
      name: map['name'],
      description: map['description'],
      officialEmail: map['officialEmail'],
      industry: map['industry'],
      socialUrls: map['socialUrls'] != null
          ? List<SocialUrl>.from(
              map['socialUrls']?.map((x) => SocialUrl.fromMap(x)))
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
      'socialUrls': socialUrls?.map((x) => x.toMap()).toList(),
    };
  }
}

class LeftSwipe {
  final String jobSeekerId;
  final String timestamp;
  final String id;

  LeftSwipe({
    required this.jobSeekerId,
    required this.timestamp,
    required this.id,
  });

  factory LeftSwipe.fromMap(Map<String, dynamic> map) {
    return LeftSwipe(
      jobSeekerId: map['jobSeekerId'],
      timestamp: map['timestamp'],
      id: map['_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jobSeekerId': jobSeekerId,
      'timestamp': timestamp,
      '_id': id,
    };
  }

  factory LeftSwipe.fromJson(Map<String, dynamic> json) {
    return LeftSwipe(
      jobSeekerId: json['jobSeekerId'],
      timestamp: json['timestamp'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobSeekerId': jobSeekerId,
      'timestamp': timestamp,
      '_id': id,
    };
  }
}

class SocialUrl {
  String? id;
  String? platform;
  String? url;

  SocialUrl({
    this.id,
    this.platform,
    this.url,
  });

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

  RequestedBy({
    this.id,
    this.email,
    this.name,
  });

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

class Question {
  String? content;
  String? type;
  List<String>? options;
  String? id;

  Question({
    this.content,
    this.type,
    this.options,
    this.id,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      content: map['content'],
      type: map['type'],
      options:
          map['options'] != null ? List<String>.from(map['options']) : null,
      id: map['_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'type': type,
      'options': options,
      '_id': id,
    };
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

class Answer {
  String? question;
  String? type;
  List<String>? options;
  String? answer;
  String? id;

  Answer({
    this.question,
    this.type,
    this.options,
    this.answer,
    this.id,
  });

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

class RequiredSkill {
  Skill? skill;
  int? rating;
  String? id;
  DateTime? lastUpdated;

  RequiredSkill({
    this.skill,
    this.rating,
    this.id,
    this.lastUpdated,
  });

  factory RequiredSkill.fromMap(Map<String, dynamic> map) {
    return RequiredSkill(
      skill: map['skill'] != null ? Skill.fromMap(map['skill']) : null,
      rating: map['rating'],
      id: map['_id'],
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.parse(map['lastUpdated'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'skill': skill?.toMap(),
      'rating': rating,
      '_id': id,
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }
}

class Skill {
  String? id;
  String? name;

  Skill({
    this.id,
    this.name,
  });

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
