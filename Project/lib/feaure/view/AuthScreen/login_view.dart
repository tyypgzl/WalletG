import 'package:finance_app/feaure/services/firebase_auth_services.dart';
import 'package:finance_app/feaure/view/AuthScreen/sign_up_view.dart';
import 'package:finance_app/feaure/view/HomeScreen/Home_View.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final tfUsername = TextEditingController();
  final tfPassword = TextEditingController();
  bool obscureText = true;

  AuthenticationService authenticationService =
      AuthenticationService(FirebaseAuth.instance);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBoxHeight(140.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/wallet.svg",
                    fit: BoxFit.cover,
                    height: 80,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "WalletG",
                    style: GoogleFonts.nunito(
                        fontSize: 32, fontWeight: FontWeight.w800),
                  )
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                "Sign in to continue",
                style: GoogleFonts.nunito(
                    fontSize: 28, fontWeight: FontWeight.w700),
              ),
              SizedBoxHeight(20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (val) {
                    if (val!.isNotEmpty &&
                        val.characters.length > 6 &&
                        val.contains('@')) {
                      return null;
                    }
                    return "Have a error Username";
                  },
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.mail),
                    labelText: "Username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  controller: tfUsername,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: obscureText,
                  validator: (val) {
                    if (val!.isNotEmpty && val.characters.length >= 6) {
                      return null;
                    }
                    return "Have a Error Password";
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: obscureText
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: tfPassword,
                ),
              ),
              SizedBoxHeight(20.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      var control = await authenticationService.signIn(
                          email: tfUsername.text, password: tfPassword.text);
                      if (control) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeView()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text("Giriş yapılamadı.Lütfen kayıt olunuz.")));
                      }
                    } on FirebaseAuthException catch (e) {
                      print(e.message);
                    }
                  } else {
                    print("validate Error");
                  }
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Text(
                  "Login",
                  style: GoogleFonts.nunito(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBoxHeight(20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.nunito(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpView()));
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.nunito(
                          fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget SizedBoxHeight(double height) => SizedBox(
      height: height,
    );
