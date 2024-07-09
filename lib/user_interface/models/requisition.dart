import 'dart:convert';

class Requisition {
  String id;
  RequestedBy requestedBy;
  String title;
  String department;
  String jobMode;
  String description;
  List<Skill> requiredSkills;
  int budgetAllocation;
  String status;
  List<String> assignedRecruiters;
  DateTime createdAt;
  DateTime updatedAt;
  int version;

  Requisition({
    required this.id,
    required this.requestedBy,
    required this.title,
    required this.department,
    required this.jobMode,
    required this.description,
    required this.requiredSkills,
    required this.budgetAllocation,
    required this.status,
    required this.assignedRecruiters,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Requisition.fromJson(Map<String, dynamic> json) {
    return Requisition(
      id: json['_id'],
      requestedBy: RequestedBy.fromJson(json['requestedBy']),
      title: json['title'],
      department: json['department'],
      jobMode: json['jobMode'],
      description: json['description'],
      requiredSkills: List<Skill>.from(json['requiredSkills'].map((x) => Skill.fromJson(x))),
      budgetAllocation: json['budgetAllocation'],
      status: json['status'],
      assignedRecruiters: List<String>.from(json['assignedRecruiters']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'requestedBy': requestedBy.toJson(),
      'title': title,
      'department': department,
      'jobMode': jobMode,
      'description': description,
      'requiredSkills': List<dynamic>.from(requiredSkills.map((x) => x.toJson())),
      'budgetAllocation': budgetAllocation,
      'status': status,
      'assignedRecruiters': List<dynamic>.from(assignedRecruiters.map((x) => x)),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }

  static List<Requisition> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Requisition.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<Requisition> requisitions) {
    return requisitions.map((requisition) => requisition.toJson()).toList();
  }
}

class RequestedBy {
  String id;
  Company company;
  String email;
  String password;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  int version;

  RequestedBy({
    required this.id,
    required this.company,
    required this.email,
    required this.password,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory RequestedBy.fromJson(Map<String, dynamic> json) {
    return RequestedBy(
      id: json['_id'],
      company: Company.fromJson(json['company']),
      email: json['email'],
      password: json['password'],
      role: json['role'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'company': company.toJson(),
      'email': email,
      'password': password,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}

class Company {
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

  Company({
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

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
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

class Location {
  Address address;
  String country;
  String state;
  String city;
  String id;

  Location({
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.id,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      address: Address.fromJson(json['address']),
      country: json['country'],
      state: json['state'],
      city: json['city'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address.toJson(),
      'country': country,
      'state': state,
      'city': city,
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
