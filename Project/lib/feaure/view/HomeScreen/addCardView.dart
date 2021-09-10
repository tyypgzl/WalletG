import 'package:finance_app/constants/color_theme.dart';
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
      appBar: CustomAppBar(
        appBar: AppBar(),
        widgets: [],
        title: "Add Card",
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          color: AppColor.primaryColor,
          child: Column(
            children: [
              CreditCardWidget(
                  cardType: CardType.mastercard,
                  cardBgColor: AppColor.secondaryColor,
                  textStyle: GoogleFonts.nunito(
                      fontSize: 20,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.w700),
                  width: size.width * .9,
                  height: size.height * .27,
                  cardNumber: cardNumber,
                  expiryDate: cardDate,
                  cardHolderName: cardHolder,
                  cvvCode: cardCvv,
                  showBackView: false),
              CreditCardForm(
                  textColor: AppColor.secondaryColor,
                  cvvValidationMessage: "CVV Error",
                  dateValidationMessage: "Date Error",
                  numberValidationMessage: "Number Error",
                  obscureCvv: false,
                  obscureNumber: false,
                  cardNumberDecoration: InputDecoration(
                    focusedBorder: getBorder(),
                    border: getBorder(),
                    enabledBorder: getBorder(),
                    focusedErrorBorder: getBorder(),
                    labelText: "Number",
                    labelStyle: getLabelStyle(),
                    hintStyle: getHintStyle(),
                    hintText: "XXXX XXXX XXXX XXXX",
                  ),
                  cardHolderDecoration: InputDecoration(
                    border: getBorder(),
                    enabledBorder: getBorder(),
                    disabledBorder: getBorder(),
                    focusedBorder: getBorder(),
                    labelText: "Card Holder",
                    hintText: "XXXXX XXXXX",
                    hintStyle: getHintStyle(),
                    labelStyle: getLabelStyle(),
                  ),
                  cvvCodeDecoration: InputDecoration(
                    border: getBorder(),
                    enabledBorder: getBorder(),
                    disabledBorder: getBorder(),
                    focusedBorder: getBorder(),
                    labelText: 'CVV',
                    hintText: 'XXX',
                    hintStyle: getHintStyle(),
                    labelStyle: getLabelStyle(),
                  ),
                  expiryDateDecoration: InputDecoration(
                    border: getBorder(),
                    enabledBorder: getBorder(),
                    disabledBorder: getBorder(),
                    focusedBorder: getBorder(),
                    labelText: 'Expired Date',
                    hintText: 'XX/XX',
                    hintStyle: getHintStyle(),
                    labelStyle: getLabelStyle(),
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
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    primary: AppColor.primaryColorYellow,
                    onPrimary: AppColor.primaryColor,
                    fixedSize: Size(220, 55),
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: AppColor.primaryColorYellow,
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
                                  "Kart Eklendi",
                                  style: GoogleFonts.nunito(
                                    color: AppColor.primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
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
      ),
      bottomNavigationBar: CustomNavBar(pageIndex: 1),
    );
  }
}

OutlineInputBorder getBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: AppColor.secondaryColor),
    );

TextStyle getLabelStyle() => GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColor.secondaryColor,
    );

TextStyle getHintStyle() => GoogleFonts.nunito(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColor.secondaryColor.withOpacity(.5),
    );
