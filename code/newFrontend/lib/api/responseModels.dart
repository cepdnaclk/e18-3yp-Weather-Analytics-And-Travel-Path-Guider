class LoginResponse {
  final String token;
  final String username;
  final String status;

  const LoginResponse({
    required this.token,
    required this.username,
    this.status = "success",
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      username: json['username'],
    );
  }
}

class SignUpResponse {
  final String token;
  final String username;
  final String status;

  const SignUpResponse({
    required this.token,
    required this.username,
    this.status = "success",
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      token: json['token'],
      username: json['username'],
    );
  }
}

class LatestUpdateResponse {
  final String dateTime;
  final String location;
  final String device_id;
  final String topic;
  final String temperature;
  final String humidity;
  final String isRaining;
  final String lightIntensity;
  final String status;

  const LatestUpdateResponse(
      {required this.dateTime,
      required this.location,
      required this.device_id,
      required this.topic,
      required this.temperature,
      required this.humidity,
      required this.isRaining,
      required this.lightIntensity,
      this.status = "Pass"});

  factory LatestUpdateResponse.fromJson(Map<String, dynamic> json) {
    return LatestUpdateResponse(
        dateTime: json['dateTime'],
        location: json['location'],
        device_id: json['device_id'],
        topic: json['topic'],
        temperature: json['temperature'],
        humidity: json['humidity'],
        isRaining: json['isRaining'],
        lightIntensity: json['lightIntensity']);
  }
}
