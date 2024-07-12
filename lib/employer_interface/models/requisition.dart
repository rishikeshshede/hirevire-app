

class Requisition {
  String? id;
  RequestedBy? requestedBy;
  String? title;
  String? department;
  String? jobMode;
  String? description;
  List<Skill>? skills;
  int? budgetAllocation;
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
    this.jobMode,
    this.description,
    this.skills,
    this.budgetAllocation,
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
      jobMode: json['jobMode'],
      description: json['description'],
      skills: json['skills'] != null
          ? List<Skill>.from(json['skills'].map((x) => Skill.fromMap(x)))
          : [],
      budgetAllocation: json['budgetAllocation'],
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
      'jobMode': jobMode,
      'description': description,
      'skills': List<String>.from(skills?.map((x) => x.toJson()) ?? []),
      'budgetAllocation': budgetAllocation,
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
  String? password;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? version;

  RequestedBy({
    this.id,
    this.company,
    this.email,
    this.password,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory RequestedBy.fromJson(Map<String, dynamic> json) {
    return RequestedBy(
      id: json['_id'],
      company: Company.fromMap(json['company']),
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
      'company': company?.toJson(),
      'email': email,
      'password': password,
      'role': role,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': version,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  factory RequestedBy.fromMap(Map<String, dynamic> map) {
    return RequestedBy.fromJson(map);
  }
}

class Company {
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
  List<String>? jobPosts;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? version;

  Company({
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
      specialties: json['specialties'] != null
          ? List<String>.from(json['specialties'])
          : [],
      locations: json['locations'] != null
          ? List<Location>.from(json['locations'].map((x) => Location.fromJson(x)))
          : [],
      jobPosts: json['jobPosts'] != null
          ? List<String>.from(json['jobPosts'])
          : [],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'size': size?.toJson(),
      'headquarters': headquarters?.toJson(),
      'peopleNCulture': peopleNCulture?.toJson(),
      '_id': id,
      'name': name,
      'description': description,
      'officialEmail': officialEmail,
      'profilePicUrl': profilePicUrl,
      'industry': industry,
      'websiteUrl': websiteUrl,
      'foundedYear': foundedYear,
      'specialties': List<String>.from(specialties?.map((x) => x) ?? []),
      'locations': List<String>.from(locations?.map((x) => x.toJson()) ?? []),
      'jobPosts': List<String>.from(jobPosts?.map((x) => x) ?? []),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': version,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company.fromJson(map);
  }
}

class Size {
  int? min;
  int? max;

  Size({
    this.min,
    this.max,
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

  Map<String, dynamic> toMap() {
    return toJson();
  }

  factory Size.fromMap(Map<String, dynamic> map) {
    return Size.fromJson(map);
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
      'address': address?.toJson(),
      'country': country,
      'state': state,
      'city': city,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  factory Headquarters.fromMap(Map<String, dynamic> map) {
    return Headquarters.fromJson(map);
  }
}

class Address {
  String? line1;
  String? line2;

  Address({
    this.line1,
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

  Map<String, dynamic> toMap() {
    return toJson();
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address.fromJson(map);
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
      'videos': List<String>.from(videos?.map((x) => x) ?? []),
      'images': List<String>.from(images?.map((x) => x) ?? []),
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  factory PeopleNCulture.fromMap(Map<String, dynamic> map) {
    return PeopleNCulture.fromJson(map);
  }
}

class Location {
  Address? address;
  String? country;
  String? state;
  String? city;
  String? id;

  Location({
    this.address,
    this.country,
    this.state,
    this.city,
    this.id,
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
      'address': address?.toJson(),
      'country': country,
      'tate': state,
      'city': city,
      '_id': id,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location.fromJson(map);
  }
}

class Skill {
  String? id;
  String? name;
  String? category;
  String? subcategory;
  DateTime? createdAt;
  DateTime? updatedAt;

  Skill({
    this.id,
    this.name,
    this.category,
    this.subcategory,
    this.createdAt,
    this.updatedAt,
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