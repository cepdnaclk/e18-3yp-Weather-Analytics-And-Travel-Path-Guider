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
