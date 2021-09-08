import 'package:finance_app/constants/color_theme.dart';
import 'package:finance_app/feaure/view/OnboardingScreen/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 3500), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnboardView()));
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
              AppColor.gradient4,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/wallet.svg",
                fit: BoxFit.cover,
                width: 150,
                color: Colors.white,
              ),
              SizedBox(
                height: 70,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    "WalletG",
                    speed: Duration(milliseconds: 500),
                    textStyle: GoogleFonts.nunito(
                      color: Colors.white,
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
 /* Text(
                "WalletG",
                style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ), */