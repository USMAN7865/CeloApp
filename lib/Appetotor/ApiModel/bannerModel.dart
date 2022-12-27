// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<BannerModel> bannerModelFromJson(String str) => List<BannerModel>.from(json.decode(str).map((x) => BannerModel.fromJson(x)));

String bannerModelToJson(List<BannerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannerModel {
    BannerModel({
        @required this.id,
        @required this.url,
        @required this.name,
        @required this.description,
        @required this.type,
        @required this.discount,
    });

    int? id;
    String? url;
    String? name;
    String? description;
    String? type;
    String? discount;

    factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"],
        url: json["url"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        discount: json["discount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "name": name,
        "description": description,
        "type": type,
        "discount": discount,
    };
}
