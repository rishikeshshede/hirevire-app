import 'dart:convert';

import 'package:hirevire_app/utils/log_handler.dart';

class TextModel {
  String? id;
  String? key;
  String? value;
  DateTime? createdAt;
  DateTime? updatedAt;

  TextModel({
    this.id,
    this.key,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  TextModel copyWith({
    String? id,
    String? key,
    String? value,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      TextModel(
        id: id ?? this.id,
        key: key ?? this.key,
        value: value ?? this.value,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  TextModel fromJson(String str) => TextModel.fromMap(json.decode(str));

  List<TextModel> fromJsonList(jsonList) {
    try {
      final List<dynamic> decodedList = json.decode(jsonList);
      return decodedList
          .map((text) => TextModel(key: text['key'], value: text['value']))
          .toList();
    } catch (e) {
      LogHandler.debug('Error decoding JSON: $e');
      return [];
    }
  }

  String toJson() => json.encode(toMap());

  factory TextModel.fromMap(Map<String, dynamic> json) => TextModel(
        id: json["_id"],
        key: json["key"],
        value: json["value"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "key": key,
        "value": value,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
