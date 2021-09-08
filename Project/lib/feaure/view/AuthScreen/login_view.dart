import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var tfUsername = TextEditingController();
  var tfPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          children: [
            Text("Login"),
            TextFormField(
              decoration: InputDecoration(labelText: "Username"),
              controller: tfUsername,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Password"),
              controller: tfPassword,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Login"),
            ),
            Row(
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {},
                  child: Text("Sign Up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
