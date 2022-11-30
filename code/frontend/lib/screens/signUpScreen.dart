import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:WhetherTravel/API/routes.dart';
import '../globals.dart' as globals;
import 'homeScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  String errMsg = "";

  void signUpButtonPress(
      String email, String username, String password1, String password2) async {
    if (password1 != password2) {
      setState(() {
        errMsg = "Passwords do not match";
      });
      return;
    } else {
      final response = await signUp(username, password1, email);
      if (response.status == "success") {
        print("sign up successful");

        globals.username = response.username;
        globals.jwtToken = response.token;

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const HomeScreen();
        }));
      } else {
        setState(() {
          errMsg = "Username or email already exists";
        });
        print("sign up failed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(50),
                child: const Text(
                  'WhetherTravels',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                obscureText: true,
                controller: passwordController1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                obscureText: true,
                controller: passwordController2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter password again',
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                // height: 20,
                child: Text(
                  errMsg,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                )),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  onPressed: () {
                    signUpButtonPress(
                        emailController.text.toString(),
                        usernameController.text.toString(),
                        passwordController1.text.toString(),
                        passwordController2.text.toString());
                  },
                  child: const Text('Create new account'),
                )),
          ],
        ));
  }
}
