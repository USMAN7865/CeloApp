// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
    ProductsModel({
        @required this.success,
        @required this.data,
        @required this.message,
    });

    bool? success;
    List<Datum>? data;
    String? message;

    factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
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
        @required this.name,
        @required this.type,
        @required this.detail,
        @required this.image,
        @required this.carbs,
        @required this.proteins,
        @required this.fats,
        @required this.cal,
        @required this.day,
        @required this.createdAt,
        @required this.updatedAt,
    });

    int? id;
    String? name;
    String? type;
    String? detail;
    String? image;
    int? carbs;
    int? proteins;
    int? fats;
    int? cal;
    int? day;
    dynamic? createdAt;
    dynamic? updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        detail: json["detail"],
        image: json["image"],
        carbs: json["carbs"],
        proteins: json["proteins"],
        fats: json["fats"],
        cal: json["cal"],
        day: json["day"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "detail": detail,
        "image": image,
        "carbs": carbs,
        "proteins": proteins,
        "fats": fats,
        "cal": cal,
        "day": day,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
