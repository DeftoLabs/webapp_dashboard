import 'dart:convert';

import 'package:web_dashboard/models/profile.dart';

class ProfileResponse {
    int total;
    List<Profile> profile;

    ProfileResponse({
        required this.total,
        required this.profile,
    });

    factory ProfileResponse.fromJson(String str) => ProfileResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProfileResponse.fromMap(Map<String, dynamic> json) => ProfileResponse(
        total: json["total"],
        profile: List<Profile>.from(json["perfiles"].map((x) => Profile.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "total": total,
        "perfiles": List<dynamic>.from(profile.map((x) => x.toMap())),
    };
}
