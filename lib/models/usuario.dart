import 'dart:convert';

class Usuario {
    String name;
    String email;
    bool online;
    String uid;

    Usuario({
        required this.name,
        required this.email,
        required this.online,
        required this.uid,
    });

    factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        name: json["name"],
        email: json["email"],
        online: json["online"],
        uid: json["uid"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "online": online,
        "uid": uid,
    };
}

