import 'package:finance_app/feaure/services/firebase_auth_services.dart';
import 'package:finance_app/feaure/view/AuthScreen/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpView extends StatefulWidget {
  SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final tfUsername = TextEditingController();
  final tfPassword = TextEditingController();
  bool obscureText = true;

  AuthenticationService authenticationService =
      AuthenticationService(FirebaseAuth.instance);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 140,
              ),
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
              SizedBoxHeight,
              SizedBoxHeight,
              Text(
                "Sign up to continue",
                style: GoogleFonts.nunito(
                    fontSize: 28, fontWeight: FontWeight.w700),
              ),
              SizedBoxHeight,
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
                    labelStyle: GoogleFonts.nunito(),
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
                    if (val!.isNotEmpty && val.characters.length > 6) {
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
                      labelStyle: GoogleFonts.nunito(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: tfPassword,
                ),
              ),
              SizedBoxHeight,
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      var control = await authenticationService.signUp(
                          email: tfUsername.text, password: tfPassword.text);
                      if (control) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Registration Successful",
                              style: GoogleFonts.nunito(),
                            ),
                          ),
                        );
                        Future.delayed(Duration(seconds: 2), () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginView()));
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Registration failed. Please try again.",
                              style: GoogleFonts.nunito(),
                            ),
                          ),
                        );
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
                  "Sign Up",
                  style: GoogleFonts.nunito(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBoxHeight,
              Divider(
                color: Colors.black,
                height: 4,
                indent: 30,
                endIndent: 30,
              ),
              SizedBoxHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getIconButton(
                    assetURL: "assets/images/google.svg",
                    press: () {},
                  ),
                  getIconButton(
                    assetURL: "assets/images/facebook.svg",
                    press: () {},
                  ),
                  getIconButton(
                    assetURL: "assets/images/twitter.svg",
                    press: () {},
                  ),
                ],
              ),
              SizedBoxHeight,
              Divider(
                color: Colors.black,
                height: 4,
                indent: 30,
                endIndent: 30,
              ),
              SizedBoxHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Do you have an account?",
                    style: GoogleFonts.nunito(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginView()));
                    },
                    child: Text(
                      "Sign In",
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

Widget get SizedBoxHeight => SizedBox(
      height: 21,
    );

Widget getIconButton({required String assetURL, required VoidCallback press}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: press,
        child: SvgPicture.asset(
          assetURL,
          fit: BoxFit.cover,
          height: 32,
        ),
      ),
    );
