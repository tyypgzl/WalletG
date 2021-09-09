import 'package:finance_app/constants/color_theme.dart';
import 'package:finance_app/feaure/view/AuthScreen/login_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardView extends StatefulWidget {
  OnboardView({Key? key}) : super(key: key);

  @override
  _OnboardViewState createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        showSkipButton: true,
        showDoneButton: true,
        showNextButton: true,
        done: Text(
          "Done",
          style: getButtonStyle(),
        ),
        next: Text(
          "Next",
          style: getButtonStyle(),
        ),
        skip: Text(
          "Skip",
          style: getButtonStyle(),
        ),
        onDone: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginView()));
        },
        pages: [
          PageViewModel(
            decoration: buildPageDecorations(),
            title: "Free",
            body: "The application is completely free",
            image: buildImage("assets/images/free.svg"),
          ),
          PageViewModel(
            decoration: buildPageDecorations(),
            title: "Actual",
            body: "Always contains up-to-date information",
            image: buildImage("assets/images/actual.svg"),
          ),
          PageViewModel(
            decoration: buildPageDecorations(),
            title: "Easy",
            body: "Designed for easy use",
            image: buildImage("assets/images/easy.svg"),
          ),
          PageViewModel(
            decoration: buildPageDecorations(),
            title: "Safe",
            body: "App is very security",
            image: buildImage("assets/images/safe.svg"),
          ),
        ],
        dotsDecorator: DotsDecorator(
          activeColor: AppColor.dotActive,
          color: AppColor.dotPAssive,
          activeSize: Size(24, 10),
          size: Size(10, 10),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        dotsContainerDecorator: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.gradient3,
              AppColor.gradient2,
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildImage(String imgURL) => SvgPicture.asset(
      imgURL,
      fit: BoxFit.cover,
      width: 300,
    );

PageDecoration buildPageDecorations() => PageDecoration(
      bodyAlignment: Alignment.center,
      titleTextStyle: GoogleFonts.nunito(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColor.primaryColorWhite),
      bodyTextStyle: GoogleFonts.nunito(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: AppColor.primaryColorWhite),
      descriptionPadding: EdgeInsets.all(8),
      imageFlex: 1,
      footerPadding: EdgeInsets.all(1),
      boxDecoration: BoxDecoration(
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
    );

TextStyle getButtonStyle() => GoogleFonts.nunito(
    color: AppColor.primaryColorYellow,
    fontSize: 24,
    fontWeight: FontWeight.w800);
