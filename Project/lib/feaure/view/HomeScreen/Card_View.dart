import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/constants/color_theme.dart';
import 'package:finance_app/feaure/view/CustomWidget/CustomAppBar.dart';
import 'package:finance_app/feaure/view/CustomWidget/CustomNavBar.dart';
import 'package:finance_app/feaure/view/HomeScreen/add_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  CollectionReference _reference =
      FirebaseFirestore.instance.collection("Cards");
  bool cardRotate = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: CustomAppBar(
          appBar: AppBar(),
          widgets: [],
        ),
        body: Container(
          width: size.width,
          height: size.height,
          color: AppColor.primaryColorWhite,
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddCardView(),
                        ),
                      );
                    },
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
                child: StreamBuilder<QuerySnapshot>(
                  stream: _reference.snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Hata oluştu. Error:${snapshot.error}"),
                      );
                    } else {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        List<DocumentSnapshot<Map>> docList =
                            snapshot.data.docs;
                        return SizedBox(
                          child: ListView.builder(
                            itemCount: docList.length,
                            itemBuilder: (context, index) {
                              return CreditCardWidget(
                                cardNumber:
                                    docList[index].data()!['cardNumber'],
                                expiryDate: docList[index].data()!['cardDate'],
                                cardHolderName:
                                    docList[index].data()!['cardHolder'],
                                cvvCode: docList[index].data()!['cardCvv'],
                                showBackView: false,
                              );
                            },
                          ),
                        );
                      }
                    }
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
      cardBgColor: Colors.lightBlueAccent,
      obscureCardCvv: false,
      obscureCardNumber: false,
      width: size.width * .9,
      height: size.height * .27,
      textStyle: GoogleFonts.nunito(
          color: Colors.black, fontSize: 21, fontWeight: FontWeight.w800),
      cardType: CardType.mastercard,
      cardNumber: "1234 5678 9012 3456",
      expiryDate: "10/24",
      cardHolderName: "TAYYIP GÜZEL",
      cvvCode: "999",
      showBackView: cardRotate,
    );
