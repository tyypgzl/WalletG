import 'package:finance_app/constants/color_theme.dart';
import 'package:finance_app/feaure/view/CustomWidget/AppBar.dart';
import 'package:finance_app/feaure/view/CustomWidget/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionsScreen extends StatefulWidget {
  TransactionsScreen({Key? key}) : super(key: key);

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    CollectionReference transactionsRef = _firestore.collection("Transactions");

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
        title: Text("WalletG"),
        widgets: [],
      ),
      bottomNavigationBar: CurvedNavBar(2),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(16),
              width: size.width,
              height: size.height * .7,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 1.5, spreadRadius: 3),
                ],
                color: AppColor.cardBG,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "JANUARY 2021",
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColor.creditCardText),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: AppColor.creditCardText,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: transactionsRef.snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          List<DocumentSnapshot<Map>> docList =
                              snapshot.data.docs;
                          return SizedBox(
                            width: size.width,
                            height: size.height * .3,
                            child: ListView.builder(
                              itemCount: docList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  trailing: Text(
                                    docList[index].data()!['price'].toString() +
                                        " \$",
                                    style: getStyle,
                                  ),
                                  title: Text(
                                    docList[index].data()!['name'],
                                    style: getStyle,
                                  ),
                                  subtitle: Text(
                                    docList[index].data()!['date'],
                                    style: getStyle,
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      }
                    },
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.download),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getTransactions(
        {required String companyName,
        required String date,
        required String price}) =>
    Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue.shade50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                companyName,
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColor.creditCardText),
              ),
              Text(
                date,
                style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColor.creditCardText),
              ),
            ],
          ),
          Text(
            price,
            style: GoogleFonts.nunito(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColor.creditCardText),
          ),
        ],
      ),
    );

TextStyle get getStyle => GoogleFonts.nunito(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );
