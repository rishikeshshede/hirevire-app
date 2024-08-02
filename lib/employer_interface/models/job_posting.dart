class JobPosting {
  Location? location;
  String? status;
  String? id;
  PostedBy? postedBy;
  String? requestedBy;
  String? jobRequisition;
  String? title;
  String? department;
  String? project;
  List<String>? jobMode;
  String? description;
  CTC? ctc;
  String? perks;
  List<Question>? questions;
  List<RequiredSkill>? requiredSkills;
  List<Media>? media;
  List<GrowthPlan>? growthPlan;
  DateTime? endsOn;
  List<String>? savedApplications;
  List<LeftSwipe>? leftSwipes;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? version;
  int? openingsCount;

  JobPosting({
    this.location,
    this.status,
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
    this.perks,
    this.questions,
    this.requiredSkills,
    this.media,
    this.growthPlan,
    this.endsOn,
    this.savedApplications,
    this.leftSwipes,
    this.createdAt,
    this.updatedAt,
    this.version,
    this.openingsCount,
  });

  factory JobPosting.fromMap(Map<String, dynamic> map) {
    return JobPosting(
      location: map['location'] != null ? Location.fromMap(map['location']) : null,
      status: map['status'],
      id: map['_id'],
      postedBy: map['postedBy'] != null ? PostedBy.fromMap(map['postedBy']) : null,
      requestedBy: map['requestedBy'],
      jobRequisition: map['jobRequisition'],
      title: map['title'],
      department: map['department'],
      project: map['project'],
      jobMode: map['jobMode'] != null ? List<String>.from(map['jobMode']) : null,
      description: map['description'],
      ctc: map['ctc'] != null
          ? (map['ctc'] is String
          ? CTC(min: map['ctc'], max: map['ctc'])
          : CTC.fromMap(map['ctc'] as Map<String, dynamic>?))
          : null,
      perks: map['perks'],
      questions: map['questions'] != null ? List<Question>.from(map['questions'].map((x) => Question.fromMap(x))) : null,
      requiredSkills: map['requiredSkills'] != null ? List<RequiredSkill>.from(map['requiredSkills'].map((x) => RequiredSkill.fromMap(x))) : null,
      media: map['media'] != null ? List<Media>.from(map['media'].map((x) => Media.fromMap(x))) : null,
      growthPlan: map['growth_plan'] != null ? List<GrowthPlan>.from(map['growth_plan'].map((x) => GrowthPlan.fromMap(x))) : null,
      endsOn: map['endsOn'] != null ? DateTime.parse(map['endsOn']) : null,
      savedApplications: map['savedApplications'] != null ? List<String>.from(map['savedApplications']) : null,
      leftSwipes: map['leftSwipes'] != null ? List<LeftSwipe>.from(map['leftSwipes'].map((x) => LeftSwipe.fromMap(x))) : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      version: map['__v'],
      openingsCount: map['openingsCount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location?.toMap(),
      'status': status,
      '_id': id,
      'postedBy': postedBy?.toMap(),
      'requestedBy': requestedBy,
      'jobRequisition': jobRequisition,
      'title': title,
      'department': department,
      'project': project,
      'jobMode': jobMode != null ? List<dynamic>.from(jobMode!.map((x) => x)) : null,
      'description': description,
      'ctc': ctc?.toMap(),
      'perks': perks,
      'questions': questions != null ? List<dynamic>.from(questions!.map((x) => x.toMap())) : null,
      'requiredSkills': requiredSkills != null ? List<dynamic>.from(requiredSkills!.map((x) => x.toMap())) : null,
      'media': media != null ? List<dynamic>.from(media!.map((x) => x.toMap())) : null,
      'growthPlan': growthPlan != null ? List<dynamic>.from(growthPlan!.map((x) => x.toMap())) : null,
      'endsOn': endsOn?.toIso8601String(),
      'savedApplications': savedApplications != null ? List<dynamic>.from(savedApplications!.map((x) => x)) : null,
      'leftSwipes': leftSwipes != null ? List<dynamic>.from(leftSwipes!.map((x) => x.toMap())) : null,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': version,
      'openingsCount': openingsCount,
    };
  }

  static List<JobPosting> fromJsonList(jsonList) {
    List<JobPosting> tempList = [];
    for (var list in jsonList) {
      tempList.add(JobPosting.fromMap(list));
    }
    return tempList;
  }
}

class Location {
  String? country;
  String? city;

  Location({this.country, this.city});

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
  List<Location>? locations;
  List<dynamic>? jobPosts;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? version;

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
    this.version,
  });

  factory PostedBy.fromMap(Map<String, dynamic> map) {
    return PostedBy(
      size: map['size'] != null ? Size.fromMap(map['size']) : null,
      headquarters: map['headquarters'] != null ? Headquarters.fromMap(map['headquarters']) : null,
      peopleNCulture: map['peopleNCulture'] != null ? PeopleNCulture.fromMap(map['peopleNCulture']) : null,
      id: map['_id'],
      name: map['name'],
      description: map['description'],
      officialEmail: map['officialEmail'],
      profilePicUrl: map['profilePicUrl'],
      industry: map['industry'],
      websiteUrl: map['websiteUrl'],
      foundedYear: map['foundedYear'],
      specialties: map['specialties'] != null ? List<String>.from(map['specialties']) : null,
      locations: map['locations'] != null ? List<Location>.from(map['locations'].map((x) => Location.fromMap(x))) : null,
      jobPosts: map['jobPosts'] != null ? List<dynamic>.from(map['jobPosts']) : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      version: map['__v'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'size': size?.toMap(),
      'headquarters': headquarters?.toMap(),
      'peopleNCulture': peopleNCulture?.toMap(),
      '_id': id,
      'name': name,
      'description': description,
      'officialEmail': officialEmail,
      'profilePicUrl': profilePicUrl,
      'industry': industry,
      'websiteUrl': websiteUrl,
      'foundedYear': foundedYear,
      'specialties': specialties != null ? List<dynamic>.from(specialties!.map((x) => x)) : null,
      'locations': locations != null ? List<dynamic>.from(locations!.map((x) => x.toMap())) : null,
      'jobPosts': jobPosts != null ? List<dynamic>.from(jobPosts!.map((x) => x)) : null,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': version,
    };
  }
}

class Size {
  int? min;
  int? max;

  Size({
    this.min,
    this.max,
  });

  factory Size.fromMap(Map<String, dynamic> map) {
    return Size(
      min: map['min'],
      max: map['max'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'min': min,
      'max': max,
    };
  }
}

class Headquarters {
  Address? address;
  String? country;
  String? state;
  String? city;

  Headquarters({
    this.address,
    this.country,
    this.state,
    this.city,
  });

  factory Headquarters.fromMap(Map<String, dynamic> map) {
    return Headquarters(
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
      country: map['country'],
      state: map['state'],
      city: map['city'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address?.toMap(),
      'country': country,
      'state': state,
      'city': city,
    };
  }
}

class Address {
  String? line1;
  String? line2;

  Address({
    this.line1,
    this.line2,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      line1: map['line1'],
      line2: map['line2'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'line1': line1,
      'line2': line2,
    };
  }
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

  factory PeopleNCulture.fromMap(Map<String, dynamic> map) {
    return PeopleNCulture(
      description: map['description'],
      videos: map['videos'] != null ? List<String>.from(map['videos']) : null,
      images: map['images'] != null ? List<String>.from(map['images']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'videos': videos != null ? List<dynamic>.from(videos!.map((x) => x)) : null,
      'images': images != null ? List<dynamic>.from(images!.map((x) => x)) : null,
    };
  }
}

class Question {
  String? type;
  List<String>? options;
  String? id;
  String? content;

  Question({
    this.type,
    this.options,
    this.id,
    this.content,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      type: map['type'],
      options: map['options'] != null ? List<String>.from(map['options']) : null,
      id: map['_id'],
      content: map['content'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'options': options != null ? List<dynamic>.from(options!.map((x) => x)) : null,
      '_id': id,
      'content': content,
    };
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

  factory RequiredSkill.fromMap(Map<String, dynamic> map) {
    return RequiredSkill(
      skill: map['skill'],
      rating: map['rating'],
      lastUpdated: map['lastUpdated'] != null ? DateTime.parse(map['lastUpdated']) : null,
      id: map['_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'skill': skill,
      'rating': rating,
      'lastUpdated': lastUpdated?.toIso8601String(),
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

class CTC {
  String? min;
  String? max;

  CTC({
    this.min,
    this.max,
  });

  factory CTC.fromMap(Map<String, dynamic>? map) {
    if (map == null) return CTC();
    if (map['min'] != null && map['max'] != null) {
      return CTC(
        min: map['min'] as String?,
        max: map['max'] as String?,
      );
    } else {
      String singleValue = map['min'] ?? map['max'] ?? '';
      return CTC(
        min: singleValue,
        max: singleValue,
      );
    }
  }


  Map<String, dynamic> toMap() {
    return {
      'min': min,
      'max': max,
    };
  }
}

class LeftSwipe {
  String? jobSeekerId;
  DateTime? timestamp;
  String? id;

  LeftSwipe({
    this.jobSeekerId,
    this.timestamp,
    this.id,
  });

  factory LeftSwipe.fromMap(Map<String, dynamic> map) {
    return LeftSwipe(
      jobSeekerId: map['jobSeekerId'] as String?,
      timestamp: map['timestamp'] != null ? DateTime.parse(map['timestamp']) : null,
      id: map['id'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jobSeekerId': jobSeekerId,
      'timestamp': timestamp?.toIso8601String(),
      'id': id,
    };
  }
}