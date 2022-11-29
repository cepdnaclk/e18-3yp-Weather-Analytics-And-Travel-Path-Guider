import 'package:flutter/material.dart';
import 'package:WhetherTravel/api/routes.dart';
import 'package:WhetherTravel/screens/signUpScreen.dart';
import '../globals.dart' as globals;
import 'homeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var errorMsg = "";
  void loginButtonPress(String username, String password) async {
    final response = await login(username, password);

    if (response.status == "success") {
      print("login successful");

      globals.jwtToken = response.token;
      globals.username = response.username;

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const HomeScreen();
      }));
    } else {
      setState(() {
        errorMsg = "Username or password is wrong.";
      });
      print("login failed");
    }

    print(await checkToken());
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
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                // height: 20,
                child: Text(
                  errorMsg,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                )),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  onPressed: () {
                    loginButtonPress(nameController.text.toString(),
                        passwordController.text.toString());
                  },
                  child: const Text('Login'),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('New to WhetherTravel?'),
                TextButton(
                  child: const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const SignUpScreen();
                    }));
                  },
                )
              ],
            ),
          ],
        ));
  }
}
