// To parse this JSON data, do
//
//     final packageModel = packageModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PackageModel packageModelFromJson(String str) => PackageModel.fromJson(json.decode(str));

String packageModelToJson(PackageModel data) => json.encode(data.toJson());

class PackageModel {
    PackageModel({
        @required this.currentPage,
        @required this.data,
        @required this.firstPageUrl,
        @required this.from,
        @required this.lastPage,
        @required this.lastPageUrl,
        @required this.links,
        @required this.nextPageUrl,
        @required this.path,
        @required this.perPage,
        @required this.prevPageUrl,
        @required this.to,
        @required this.total,
    });

    int? currentPage;
    List<Datum>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    dynamic? nextPageUrl;
    String? path;
    int? perPage;
    dynamic? prevPageUrl;
    int? to;
    int? total;

    factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Datum {
    Datum({
        @required this.id,
        @required this.name,
        @required this.detail,
        @required this.image,
        @required this.price,
        @required this.createdAt,
        @required this.updatedAt,
    });

    int? id;
    String? name;
    String? detail;
    String? image;
    int? price;
    dynamic? createdAt;
    dynamic? updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        detail: json["detail"],
        image: json["image"],
        price: json["price"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "detail": detail,
        "image": image,
        "price": price,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class Link {
    Link({
        @required this.url,
        @required this.label,
        @required this.active,
    });

    String? url;
    String? label;
    bool? active;

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
    };
}
