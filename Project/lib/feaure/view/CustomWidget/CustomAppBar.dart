import 'package:finance_app/constants/color_theme.dart';
import 'package:finance_app/feaure/services/firebase_auth_services.dart';
import 'package:finance_app/feaure/view/AuthScreen/loginView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final List<Widget> widgets;
  final String title;

  const CustomAppBar(
      {required this.appBar, required this.widgets, required this.title});

  @override
  Widget build(BuildContext context) {
    AuthenticationService authServices =
        AuthenticationService(FirebaseAuth.instance);
    return AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColor.secondaryColor, size: 40),
      elevation: 0,
      title: Text(
        title,
        style: GoogleFonts.nunito(
          color: AppColor.secondaryColor,
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: AppColor.primaryColor,
      actions: [
        IconButton(
          onPressed: () async {
            try {
              var control = await authServices.signOut();
              if (control) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                    (route) => false);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Oturum Kapatırken sorun yaşandı.")));
              }
            } on FirebaseAuthException catch (e) {
              print(e.message);
            }
          },
          icon: Icon(
            Icons.power_settings_new,
            color: AppColor.secondaryColor,
            size: 32,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
