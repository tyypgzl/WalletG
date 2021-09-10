import 'dart:ui';

import 'package:finance_app/constants/color_theme.dart';
import 'package:finance_app/feaure/model/pie_data.dart';
import 'package:finance_app/feaure/view/CustomWidget/CustomAppBar.dart';
import 'package:finance_app/feaure/view/CustomWidget/CustomNavBar.dart';
import 'package:finance_app/feaure/view/CustomWidget/Indicator_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isSquare = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(),
        widgets: [],
        title: "Home",
      ),
      bottomNavigationBar: CustomNavBar(pageIndex: 0),
      body: Container(
        color: AppColor.primaryColor,
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            getSizedBoxHeight(10),
            Text(
              "Total Balance",
              style: GoogleFonts.nunito(
                color: AppColor.secondaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              width: size.width * .7,
              height: size.height * .09,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.secondaryColor),
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "\$ 9.684",
                    style: gettextStyle(
                        fontsize: 36,
                        fontWeight: FontWeight.w800,
                        color: AppColor.secondaryColor),
                  ),
                  Text(
                    ",37",
                    style: gettextStyle(
                        fontsize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColor.secondaryColor),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              height: size.height * .38,
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 3,
                  centerSpaceRadius: 70,
                  sections: getSections(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: IndicatorWidget(),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: AppColor.secondaryColor),
                      ),
                      primary: AppColor.primaryColor,
                      elevation: 0,
                      fixedSize: Size(200, 60),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Coin List",
                      style: GoogleFonts.nunito(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: AppColor.secondaryColor),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shop,
                      color: AppColor.secondaryColor,
                    ),
                    label: Text(
                      "Shop",
                      style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColor.secondaryColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: AppColor.secondaryColor),
                      ),
                      primary: AppColor.primaryColor,
                      elevation: 0,
                      fixedSize: Size(110, 60),
                    ),
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

Widget getSizedBoxHeight(double height) => SizedBox(
      height: height,
    );
Widget getSizedBoxWidth(double width) => SizedBox(
      height: width,
    );

TextStyle gettextStyle(
        {required double fontsize,
        required FontWeight fontWeight,
        required Color color}) =>
    GoogleFonts.nunito(
        fontSize: fontsize, fontWeight: fontWeight, color: color);

List<PieChartSectionData> getSections() => PieData.data
    .asMap()
    .map<int, PieChartSectionData>((index, data) {
      final value = PieChartSectionData(
        color: data.color,
        value: data.percent,
        title: "${data.percent}",
        titleStyle: GoogleFonts.nunito(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColor.primaryColor,
        ),
      );
      return MapEntry(index, value);
    })
    .values
    .toList();
