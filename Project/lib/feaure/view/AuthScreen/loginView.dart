import 'package:finance_app/constants/color_theme.dart';
import 'package:finance_app/feaure/services/firebase_auth_services.dart';
import 'package:finance_app/feaure/view/AuthScreen/signUpView.dart';
import 'package:finance_app/feaure/view/HomeScreen/homeView.dart';
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
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
                getWalletSvg(),
                getSizedBoxHeight(60),
                getTitle(),
                SizedBoxHeight(20.0),
                getUserNameFormField(tfUsername),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscureText,
                    style: GoogleFonts.nunito(
                      color: AppColor.secondaryColor,
                    ),
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
                            ? Icon(
                                Icons.visibility,
                                color: AppColor.secondaryColor,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: AppColor.secondaryColor,
                              ),
                      ),
                      labelText: "Password",
                      labelStyle:
                          GoogleFonts.nunito(color: AppColor.secondaryColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.secondaryColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: AppColor.secondaryColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              BorderSide(color: AppColor.secondaryColor)),
                    ),
                    controller: tfPassword,
                  ),
                ),
                SizedBoxHeight(20.0),
                getSignInLoginButton(
                    formKey: _formKey,
                    authenticationService: authenticationService,
                    tfUsername: tfUsername,
                    tfPassword: tfPassword),
                SizedBoxHeight(20.0),
                getGoSignUpLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class getSignInLoginButton extends StatelessWidget {
  const getSignInLoginButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.authenticationService,
    required this.tfUsername,
    required this.tfPassword,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final AuthenticationService authenticationService;
  final TextEditingController tfUsername;
  final TextEditingController tfPassword;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          try {
            var control = await authenticationService.signIn(
                email: tfUsername.text, password: tfPassword.text);
            if (control) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomeView()));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                        color: AppColor.primaryColor,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Login failed. Please register.",
                        style: GoogleFonts.nunito(
                            color: AppColor.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  backgroundColor: AppColor.primaryColorYellow,
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
          onPrimary: AppColor.primaryColor,
          primary: AppColor.primaryColorYellow,
          fixedSize: Size(240, 60),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Text(
        "Login",
        style: GoogleFonts.nunito(fontSize: 24, fontWeight: FontWeight.w600),
      ),
    );
  }
}

Widget SizedBoxHeight(double height) => SizedBox(
      height: height,
    );

Widget getWalletSvg() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/images/wallet.svg",
          fit: BoxFit.cover,
          height: 80,
          color: AppColor.primaryColorYellow,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          "WalletG",
          style: GoogleFonts.nunito(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: AppColor.primaryColorYellow,
          ),
        )
      ],
    );

Widget getTitle() => Text(
      "Sign In",
      style: GoogleFonts.nunito(
        fontSize: 40,
        fontWeight: FontWeight.w800,
        color: AppColor.secondaryColor,
      ),
    );

Widget getUserNameFormField(TextEditingController tfUsername) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        style: GoogleFonts.nunito(
          color: AppColor.secondaryColor,
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
          suffixIcon: Icon(
            Icons.mail,
            color: AppColor.secondaryColor,
          ),
          labelText: "Username",
          labelStyle: GoogleFonts.nunito(color: AppColor.secondaryColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.secondaryColor),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColor.secondaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColor.secondaryColor)),
        ),
        controller: tfUsername,
      ),
    );

Widget getGoSignUpLink(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColor.secondaryColor),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignUpView()));
          },
          child: Text(
            "Sign Up",
            style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColor.primaryColorYellow),
          ),
        ),
      ],
    );

//Context???????????????????????????????