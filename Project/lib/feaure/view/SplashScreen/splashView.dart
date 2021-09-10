import 'package:finance_app/constants/color_theme.dart';
import 'package:finance_app/feaure/view/HomeScreen/homeView.dart';
import 'package:finance_app/feaure/view/OnboardingScreen/onboardingView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  var authControl = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    firebaseAuth.authStateChanges().listen((event) {
      if (event == null) {
        authControl = false;
      } else {
        authControl = true;
      }
    });
    Future.delayed(Duration(milliseconds: 3790), () {
      if (authControl) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeView()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => OnboardView()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.gradient1,
              AppColor.gradient2,
              AppColor.gradient3,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/wallet.svg",
                  fit: BoxFit.cover, width: 140, color: AppColor.splashColor),
              SizedBox(
                height: 70,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    "WalletG",
                    speed: Duration(milliseconds: 400),
                    textStyle: GoogleFonts.nunito(
                      color: AppColor.splashColor,
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
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
