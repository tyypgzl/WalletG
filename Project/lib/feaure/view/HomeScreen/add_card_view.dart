import 'package:finance_app/feaure/services/firebase_firestore_services.dart';
import 'package:finance_app/feaure/view/CustomWidget/CustomAppBar.dart';
import 'package:finance_app/feaure/view/CustomWidget/CustomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCardView extends StatefulWidget {
  AddCardView({Key? key}) : super(key: key);

  @override
  _AddCardViewState createState() => _AddCardViewState();
}

class _AddCardViewState extends State<AddCardView> {
  FirebaseFirestoreServices services = FirebaseFirestoreServices();
  final formKey = GlobalKey<FormState>();
  String cardNumber = "";
  String cardDate = "";
  String cardHolder = "";
  String cardCvv = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), widgets: []),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CreditCardWidget(
                width: size.width * .9,
                height: size.height * .27,
                cardType: CardType.mastercard,
                cardNumber: cardNumber,
                expiryDate: cardDate,
                cardHolderName: cardHolder,
                cvvCode: cardCvv,
                showBackView: false),
            CreditCardForm(
                cvvValidationMessage: "CVV Error",
                dateValidationMessage: "Date Error",
                numberValidationMessage: "Number Error",
                obscureCvv: false,
                obscureNumber: false,
                cardNumberDecoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Number",
                    hintText: "XXXX XXXX XXXX XXXX"),
                cardHolderDecoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Card Holder"),
                cvvCodeDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CVV',
                  hintText: 'XXX',
                ),
                expiryDateDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Expired Date',
                  hintText: 'XX/XX',
                ),
                cardNumber: "",
                expiryDate: "",
                cardHolderName: "",
                cvvCode: "",
                onCreditCardModelChange: (data) {
                  setState(() {
                    cardHolder = data.cardHolderName.toUpperCase();
                    cardDate = data.expiryDate;
                    cardNumber = data.cardNumber;
                    cardCvv = data.cvvCode;
                  });
                },
                themeColor: Colors.red,
                formKey: formKey),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent,
                  fixedSize: Size(190, 45),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Map<String, dynamic> data = Map<String, dynamic>();
                    data["cardHolder"] = cardHolder;
                    data["cardCvv"] = cardCvv;
                    data["cardDate"] = cardDate;
                    data["cardNumber"] = cardNumber;
                    try {
                      services.addCard(data);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.info),
                              SizedBox(
                                width: 20,
                              ),
                              Text("Kart Eklendi"),
                            ],
                          ),
                        ),
                      );
                    } catch (e) {}
                  }
                },
                icon: Icon(Icons.add),
                label: Text(
                  "Add",
                  style: GoogleFonts.nunito(
                      fontSize: 20, fontWeight: FontWeight.w600),
                )),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(pageIndex: 1),
    );
  }
}
