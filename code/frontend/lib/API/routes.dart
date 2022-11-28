import 'dart:convert';
import 'package:frontend/API/response_models.dart';
import 'package:http/http.dart' as http;
import '../globals.dart' as globals;

String baseURL = "http://127.0.0.1:8080";
Future<LoginResponse> login(String username, String password) async {
  final http.Response response;
  try {
    response = await http.post(
      Uri.parse("$baseURL/login"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    print("response from server " + response.body);

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body.toString()));
    } else if (response.statusCode == 401) {
      return const LoginResponse(token: "", username: "", status: "failed");
    } else {
      throw Exception("Something went wrong.");
    }
  } catch (e) {
    print(e);
  }
  throw Exception("Something went wrong.");
}

Future<bool> checkToken() async {
  final http.Response response;
  try {
    response = await http
        .post(Uri.parse("$baseURL/login/checkToken"), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'token ${globals.jwtToken}',
    });
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      return false;
    } else {
      throw false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}

Future<SignUpResponse> signUp(
    String username, String password, String email) async {
  final http.Response response;
  try {
    response = await http.post(
      Uri.parse("$baseURL/signup"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'email': email,
      }),
    );
    print("response from server " + response.body);

    if (response.statusCode == 200) {
      return SignUpResponse.fromJson(jsonDecode(response.body.toString()));
    } else if (response.statusCode == 409) {
      return const SignUpResponse(token: "", username: "", status: "failed");
    } else {
      throw Exception("Something went wrong.");
    }
  } catch (e) {
    print(e);
  }
  throw Exception("Something went wrong.");
}
