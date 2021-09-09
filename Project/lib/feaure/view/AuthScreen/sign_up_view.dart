import 'package:finance_app/constants/color_theme.dart';
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColor.gradient1,
                AppColor.gradient2,
                AppColor.gradient3,
              ],
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBoxHeight(140.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/wallet.svg",
                        fit: BoxFit.cover,
                        height: 80,
                        color: AppColor.primaryColorWhite),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "WalletG",
                      style: GoogleFonts.nunito(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: AppColor.primaryColorWhite),
                    )
                  ],
                ),
                SizedBoxHeight(60.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                    ),
                    validator: (val) {
                      if (val!.isNotEmpty &&
                          val.characters.length > 6 &&
                          val.contains('@')) {
                        return null;
                      }
                      return "Have a error Username";
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.primaryColorWhite),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: AppColor.primaryColorWhite)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: AppColor.primaryColorWhite)),
                      suffixIcon: Icon(
                        Icons.mail,
                        color: AppColor.primaryColorWhite,
                      ),
                      labelText: "Username",
                      labelStyle:
                          GoogleFonts.nunito(color: AppColor.primaryColorWhite),
                    ),
                    controller: tfUsername,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
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
                            ? Icon(Icons.visibility,
                                color: AppColor.primaryColorWhite)
                            : Icon(
                                Icons.visibility_off,
                                color: AppColor.primaryColorWhite,
                              ),
                      ),
                      labelText: "Password",
                      labelStyle:
                          GoogleFonts.nunito(color: AppColor.primaryColorWhite),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.primaryColorWhite),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: AppColor.primaryColorWhite)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: AppColor.primaryColorWhite)),
                    ),
                    controller: tfPassword,
                  ),
                ),
                SizedBoxHeight(20.0),
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
                      elevation: 0,
                      onPrimary: AppColor.primaryColorBlack,
                      primary: AppColor.primaryColorYellow,
                      fixedSize: Size(240, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.nunito(
                        fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBoxHeight(20.0),
                getDivider(),
                SizedBoxHeight(20.0),
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
                SizedBoxHeight(20.0),
                getDivider(),
                SizedBoxHeight(20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do you have an account?",
                      style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColor.primaryColorGray),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginView()));
                      },
                      child: Text("Sign In",
                          style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColor.primaryColorYellow)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget SizedBoxHeight(double height) => SizedBox(
      height: height,
    );

Widget getIconButton({required String assetURL, required VoidCallback press}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: press,
        child: SvgPicture.asset(
          assetURL,
          fit: BoxFit.cover,
          height: 34,
        ),
      ),
    );

Widget getDivider() => Divider(
      color: AppColor.primaryColorWhite,
      thickness: 1,
      indent: 30,
      endIndent: 30,
    );
