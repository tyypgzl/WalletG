import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finance_app/constants/color_theme.dart';
import 'package:finance_app/feaure/view/HomeScreen/bodyScreens/card_body.dart';
import 'package:finance_app/feaure/view/HomeScreen/bodyScreens/home_body.dart';
import 'package:finance_app/feaure/view/HomeScreen/bodyScreens/transactions_body.dart';
import 'package:flutter/material.dart';

class curvedNavBar extends StatefulWidget {
  int pageIndex;
  curvedNavBar(this.pageIndex);

  @override
  _curvedNavBarState createState() => _curvedNavBarState();
}

class _curvedNavBarState extends State<curvedNavBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: AppColor.homeAppBar,
      animationDuration: Duration(milliseconds: 500),
      backgroundColor: AppColor.homeBG,
      index: widget.pageIndex,
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
