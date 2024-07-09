import 'dart:convert';

class JobPosting {
  Location location;
  String id;
  PostedBy postedBy;
  String requestedBy;
  String jobRequisition;
  String title;
  List<String> jobMode;
  String description;
  List<Question> questions;
  List<Skill> requiredSkills;
  List<Media> media;
  DateTime endsOn;
  List<dynamic> savedApplications;
  DateTime createdAt;
  DateTime updatedAt;
  int version;

  JobPosting({
    required this.location,
    required this.id,
    required this.postedBy,
    required this.requestedBy,
    required this.jobRequisition,
    required this.title,
    required this.jobMode,
    required this.description,
    required this.questions,
    required this.requiredSkills,
    required this.media,
    required this.endsOn,
    required this.savedApplications,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory JobPosting.fromJson(Map<String, dynamic> json) {
    return JobPosting(
      location: Location.fromJson(json['location']),
      id: json['_id'],
      postedBy: PostedBy.fromJson(json['postedBy']),
      requestedBy: json['requestedBy'],
      jobRequisition: json['jobRequisition'],
      title: json['title'],
      jobMode: List<String>.from(json['jobMode']),
      description: json['description'],
      questions: List<Question>.from(json['questions'].map((x) => Question.fromJson(x))),
      requiredSkills: List<Skill>.from(json['requiredSkills'].map((x) => Skill.fromJson(x))),
      media: List<Media>.from(json['media'].map((x) => Media.fromJson(x))),
      endsOn: DateTime.parse(json['endsOn']),
      savedApplications: List<dynamic>.from(json['savedApplications']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      '_id': id,
      'postedBy': postedBy.toJson(),
      'requestedBy': requestedBy,
      'jobRequisition': jobRequisition,
      'title': title,
      'jobMode': List<dynamic>.from(jobMode.map((x) => x)),
      'description': description,
      'questions': List<dynamic>.from(questions.map((x) => x.toJson())),
      'requiredSkills': List<dynamic>.from(requiredSkills.map((x) => x.toJson())),
      'media': List<dynamic>.from(media.map((x) => x.toJson())),
      'endsOn': endsOn.toIso8601String(),
      'savedApplications': List<dynamic>.from(savedApplications.map((x) => x)),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }

  static List<JobPosting> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => JobPosting.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<JobPosting> jobPostings) {
    return jobPostings.map((jobPosting) => jobPosting.toJson()).toList();
  }
}

class Location {
  String country;
  String city;

  Location({
    required this.country,
    required this.city,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      country: json['country'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'city': city,
    };
  }
}

class PostedBy {
  Size size;
  Headquarters headquarters;
  PeopleNCulture peopleNCulture;
  String id;
  String name;
  String description;
  String officialEmail;
  String profilePicUrl;
  String industry;
  String websiteUrl;
  int foundedYear;
  List<String> specialties;
  List<Location> locations;
  List<dynamic> jobPosts;
  DateTime createdAt;
  DateTime updatedAt;
  int version;

  PostedBy({
    required this.size,
    required this.headquarters,
    required this.peopleNCulture,
    required this.id,
    required this.name,
    required this.description,
    required this.officialEmail,
    required this.profilePicUrl,
    required this.industry,
    required this.websiteUrl,
    required this.foundedYear,
    required this.specialties,
    required this.locations,
    required this.jobPosts,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory PostedBy.fromJson(Map<String, dynamic> json) {
    return PostedBy(
      size: Size.fromJson(json['size']),
      headquarters: Headquarters.fromJson(json['headquarters']),
      peopleNCulture: PeopleNCulture.fromJson(json['peopleNCulture']),
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      officialEmail: json['officialEmail'],
      profilePicUrl: json['profilePicUrl'],
      industry: json['industry'],
      websiteUrl: json['websiteUrl'],
      foundedYear: json['foundedYear'],
      specialties: List<String>.from(json['specialties']),
      locations: List<Location>.from(json['locations'].map((x) => Location.fromJson(x))),
      jobPosts: List<dynamic>.from(json['jobPosts']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'size': size.toJson(),
      'headquarters': headquarters.toJson(),
      'peopleNCulture': peopleNCulture.toJson(),
      '_id': id,
      'name': name,
      'description': description,
      'officialEmail': officialEmail,
      'profilePicUrl': profilePicUrl,
      'industry': industry,
      'websiteUrl': websiteUrl,
      'foundedYear': foundedYear,
      'specialties': List<dynamic>.from(specialties.map((x) => x)),
      'locations': List<dynamic>.from(locations.map((x) => x.toJson())),
      'jobPosts': List<dynamic>.from(jobPosts.map((x) => x)),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}

class Size {
  int min;
  int max;

  Size({
    required this.min,
    required this.max,
  });

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      min: json['min'],
      max: json['max'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'min': min,
      'max': max,
    };
  }
}

class Headquarters {
  Address address;
  String country;
  String state;
  String city;

  Headquarters({
    required this.address,
    required this.country,
    required this.state,
    required this.city,
  });

  factory Headquarters.fromJson(Map<String, dynamic> json) {
    return Headquarters(
      address: Address.fromJson(json['address']),
      country: json['country'],
      state: json['state'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address.toJson(),
      'country': country,
      'state': state,
      'city': city,
    };
  }
}

class Address {
  String line1;
  String? line2;

  Address({
    required this.line1,
    this.line2,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      line1: json['line1'],
      line2: json['line2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'line1': line1,
      'line2': line2,
    };
  }
}

class PeopleNCulture {
  String description;
  List<String> videos;
  List<String> images;

  PeopleNCulture({
    required this.description,
    required this.videos,
    required this.images,
  });

  factory PeopleNCulture.fromJson(Map<String, dynamic> json) {
    return PeopleNCulture(
      description: json['description'],
      videos: List<String>.from(json['videos']),
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'videos': List<dynamic>.from(videos.map((x) => x)),
      'images': List<dynamic>.from(images.map((x) => x)),
    };
  }
}

class Question {
  String type;
  List<String> options;
  String? content;
  String id;

  Question({
    required this.type,
    required this.options,
    this.content,
    required this.id,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      type: json['type'],
      options: List<String>.from(json['options']),
      content: json['content'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'options': List<dynamic>.from(options.map((x) => x)),
      'content': content,
      '_id': id,
    };
  }
}

class Skill {
  String id;
  String name;
  String category;
  String subcategory;
  DateTime createdAt;
  DateTime updatedAt;

  Skill({
    required this.id,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['_id'],
      name: json['name'],
      category: json['category'],
      subcategory: json['subcategory'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'category': category,
      'subcategory': subcategory,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Media {
  String url;
  String type;
  String thumbnail;
  String id;

  Media({
    required this.url,
    required this.type,
    required this.thumbnail,
    required this.id,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      url: json['url'],
      type: json['type'],
      thumbnail: json['thumbnail'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'type': type,
      'thumbnail': thumbnail,
      '_id': id,
    };
  }
}
