import 'dart:convert';

class EmployerModel {
  String? id;
  String? email;
  String? password;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  Company? company;

  EmployerModel({
    this.id,
    this.email,
    this.password,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.company,
  });

  EmployerModel copyWith({
    String? id,
    String? email,
    String? password,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    Company? company,
  }) =>
      EmployerModel(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
        role: role ?? this.role,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        company: company ?? this.company,
      );

  EmployerModel fromJson(String str) => EmployerModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmployerModel.fromMap(Map<String, dynamic> json) => EmployerModel(
        id: json["_id"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        company:
            json["company"] == null ? null : Company.fromMap(json["company"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "email": email,
        "password": password,
        "role": role,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "company": company?.toMap(),
      };
}

class Company {
  String? id;
  String? name;
  String? address;
  String? website;
  String? industry;
  String? logoUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  Company({
    this.id,
    this.name,
    this.address,
    this.website,
    this.industry,
    this.logoUrl,
    this.createdAt,
    this.updatedAt,
  });

  Company copyWith({
    String? id,
    String? name,
    String? address,
    String? website,
    String? industry,
    String? logoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Company(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        website: website ?? this.website,
        industry: industry ?? this.industry,
        logoUrl: logoUrl ?? this.logoUrl,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Company.fromJson(String str) => Company.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Company.fromMap(Map<String, dynamic> json) => Company(
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
