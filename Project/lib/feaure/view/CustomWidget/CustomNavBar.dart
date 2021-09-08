import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finance_app/constants/color_theme.dart';
import 'package:finance_app/feaure/view/HomeScreen/Card_View.dart';
import 'package:finance_app/feaure/view/HomeScreen/Home_View.dart';
import 'package:finance_app/feaure/view/HomeScreen/Transactions_View.dart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomNavBar extends StatelessWidget {
  int pageIndex;
  CustomNavBar({required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CurvedNavigationBar(
      height: size.height * .08,
      color: AppColor.homeAppBar,
      animationDuration: Duration(milliseconds: 500),
      backgroundColor: AppColor.homeBG,
      index: pageIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            break;
          case 1:
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => CardScreen()));

            break;
          case 2:
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => TransactionsScreen()));

            break;
          default:
        }
      },
      items: [
        Icon(
          Icons.home,
          size: 32,
          semanticLabel: "Home",
          color: Colors.white,
        ),
        Icon(
          Icons.credit_card,
          size: 32,
          semanticLabel: "Card",
          color: Colors.white,
        ),
        Icon(
          Icons.receipt_long,
          size: 32,
          semanticLabel: "Transactions",
          color: Colors.white,
        ),
      ],
    );
  }
}
