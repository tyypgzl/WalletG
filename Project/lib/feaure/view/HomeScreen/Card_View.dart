import 'package:finance_app/constants/color_theme.dart';
import 'package:finance_app/feaure/view/CustomWidget/CustomAppBar.dart';
import 'package:finance_app/feaure/view/CustomWidget/CustomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  bool cardRotate = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: CustomAppBar(
          appBar: AppBar(),
          title: Text(
            "WalletG",
            style: GoogleFonts.nunito(
              color: AppColor.splashTitleColor,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          widgets: [IconButton(onPressed: () {}, icon: Icon(Icons.person))],
        ),
        body: Container(
          width: size.width,
          height: size.height,
          color: AppColor.homeBG,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(220, 45),
                      fixedSize: Size(250, 50),
                      primary: Colors.black45,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    label: Text("Add New Card"),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(65, 45),
                        fixedSize: Size(70, 50),
                        primary: Colors.black45,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {},
                      child: Icon(Icons.qr_code_scanner))
                ],
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return getCardWidget(cardRotate, size);
                  },
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: CustomNavBar(
          pageIndex: 1,
        ));
  }
}

CreditCardWidget getCardWidget(bool cardRotate, Size size) => CreditCardWidget(
      cardBgColor: AppColor.creditCardBG,
      obscureCardCvv: false,
      obscureCardNumber: false,
      width: size.width * .9,
      height: size.height * .27,
      textStyle: GoogleFonts.nunito(
          color: AppColor.creditCardText,
          fontSize: 21,
          fontWeight: FontWeight.w800),
      cardType: CardType.mastercard,
      cardNumber: "1234 5678 9012 3456",
      expiryDate: "10/24",
      cardHolderName: "TAYYIP GÜZEL",
      cvvCode: "999",
      showBackView: cardRotate,
    );
