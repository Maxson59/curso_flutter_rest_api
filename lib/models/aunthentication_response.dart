import 'dart:convert';

AunthenticationResponse aunthenticationResponseFromJson(String str) => AunthenticationResponse.fromJson(json.decode(str));

String aunthenticationResponseToJson(AunthenticationResponse data) => json.encode(data.toJson());

class AunthenticationResponse {
    final String token;
    final int expiresIn;

    AunthenticationResponse({
        required this.token,
        required this.expiresIn,
    });

    factory AunthenticationResponse.fromJson(Map<String, dynamic> json) => AunthenticationResponse(
        token: json["token"],
        expiresIn: json["expiresIn"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "expiresIn": expiresIn,
    };
}
