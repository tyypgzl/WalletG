import 'package:finance_app/constants/color_theme.dart';
import 'package:finance_app/feaure/services/firebase_auth_services.dart';
import 'package:finance_app/feaure/view/AuthScreen/loginView.dart';
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
                getWalletSvg(),
                SizedBoxHeight(60.0),
                getTitle(),
                SizedBoxHeight(20),
                getUsernameFormfield(tfUsername),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: GoogleFonts.nunito(
                      color: AppColor.secondaryColor,
                    ),
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
                                color: AppColor.secondaryColor)
                            : Icon(
                                Icons.visibility_off,
                                color: AppColor.secondaryColor,
                              ),
                      ),
                      hintStyle: TextStyle(color: Colors.white),
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
                SizedBoxHeight(40.0),
                getSignUpButton(
                    formKey: _formKey,
                    authenticationService: authenticationService,
                    tfUsername: tfUsername,
                    tfPassword: tfPassword),
                SizedBoxHeight(20.0),
                getSocialButton(),
                SizedBoxHeight(20.0),
                getGoSignInPageButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class getSignUpButton extends StatelessWidget {
  const getSignUpButton({
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
            var control = await authenticationService.signUp(
                email: tfUsername.text, password: tfPassword.text);
            if (control) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info,
                        color: AppColor.primaryColor,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Registration Succesful",
                        style: GoogleFonts.nunito(
                            color: AppColor.primaryColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  backgroundColor: AppColor.primaryColorYellow,
                ),
              );
              Future.delayed(Duration(seconds: 2), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginView()));
              });
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
                        "Registration Failed",
                        style: GoogleFonts.nunito(
                            color: AppColor.primaryColor,
                            fontSize: 17,
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
        "Sign Up",
        style: GoogleFonts.nunito(fontSize: 28, fontWeight: FontWeight.w600),
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
      color: AppColor.secondaryColor,
      thickness: 1,
      indent: 30,
      endIndent: 30,
    );

Widget getWalletSvg() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/images/wallet.svg",
            fit: BoxFit.cover, height: 80, color: AppColor.primaryColorYellow),
        SizedBox(
          width: 20,
        ),
        Text(
          "WalletG",
          style: GoogleFonts.nunito(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: AppColor.primaryColorYellow),
        )
      ],
    );

Widget getUsernameFormfield(TextEditingController tfUsername) => Padding(
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
            borderSide: BorderSide(color: AppColor.secondaryColor),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColor.secondaryColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: AppColor.secondaryColor)),
          suffixIcon: Icon(
            Icons.mail,
            color: AppColor.secondaryColor,
          ),
          labelText: "Username",
          labelStyle: GoogleFonts.nunito(color: AppColor.secondaryColor),
        ),
        controller: tfUsername,
      ),
    );

Widget getSocialButton() => Row(
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
    );

Widget getGoSignInPageButton(BuildContext context) => Row(
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
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginView()));
          },
          child: Text("Sign In",
              style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColor.primaryColorYellow)),
        ),
      ],
    );

Widget getTitle() => Text(
      "Sign Up",
      style: GoogleFonts.nunito(
        fontSize: 40,
        fontWeight: FontWeight.w800,
        color: AppColor.secondaryColor,
      ),
    );
