// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    UserData({
        @required this.success,
        @required this.data,
        @required this.message,
    });

    bool? success;
    List<Datum>? data;
    String? message;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class Datum {
    Datum({
        @required this.id,
        @required this.userId,
        @required this.carbs,
        @required this.fats,
        @required this.proteins,
        @required this.calories,
    });

    int? id;
    int? userId;
    double? carbs;
    double? fats;
    double? proteins;
    double? calories;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        carbs: json["carbs"].toDouble(),
        fats: json["fats"].toDouble(),
        proteins: json["proteins"].toDouble(),
        calories: json["calories"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "carbs": carbs,
        "fats": fats,
        "proteins": proteins,
        "calories": calories,
    };
}
