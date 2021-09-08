import 'dart:ui';

import 'package:finance_app/constants/color_theme.dart';
import 'package:finance_app/feaure/view/CustomWidget/CustomAppBar.dart';
import 'package:finance_app/feaure/view/CustomWidget/CustomNavBar.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSelectedButton = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), widgets: []),
      bottomNavigationBar: CustomNavBar(pageIndex: 0),
      body: Container(
        height: size.height,
        width: size.width,
        color: AppColor.homeBG,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColor.cardBG,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(14),
              padding: EdgeInsets.all(10),
              height: size.height * .35,
              child: LineChart(
                LineChartData(
                  lineTouchData: lineTouchData1,
                  gridData: gridData,
                  titlesData: titlesData1,
                  borderData: borderData,
                  lineBarsData: lineBarsData1,
                  minX: 0,
                  maxX: 14,
                  maxY: 4,
                  minY: 0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(14),
              padding: EdgeInsets.all(10),
              width: size.width,
              height: size.height * .38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.cardBG,
              ),
              child: Column(
                children: [
                  Text(
                    "Exchange",
                    style: GoogleFonts.nunito(
                      color: AppColor.homeScreenTitle,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: size.width * .9,
                    height: size.height * .09,
                    decoration: BoxDecoration(
                      color: AppColor.ButtonContainerBG,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                            fixedSize: Size(150, 45),
                            onPrimary: Colors.black.withOpacity(.7),
                            primary: _isSelectedButton
                                ? AppColor.SelectedButton
                                : AppColor.UnselectedButton,
                          ),
                          onPressed: () {
                            setState(() {
                              _isSelectedButton = true;
                            });
                          },
                          child: Text(
                            "Buy",
                            style: GoogleFonts.nunito(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                            fixedSize:
                                Size(size.width * .38, size.height * .025),
                            onPrimary: Colors.black.withOpacity(.7),
                            primary: _isSelectedButton
                                ? AppColor.UnselectedButton
                                : AppColor.SelectedButton,
                          ),
                          onPressed: () {
                            setState(() {
                              _isSelectedButton = false;
                            });
                          },
                          child: Text(
                            "Sell",
                            style: GoogleFonts.nunito(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "1 \$",
                              style: textStyle,
                            ),
                            Spacer(),
                            Text(
                              "8.32 ₺",
                              style: textStyle,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "1 BTC",
                              style: textStyle,
                            ),
                            Spacer(),
                            Text(
                              "49.685 \$",
                              style: textStyle,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "1 XRP",
                              style: textStyle,
                            ),
                            Spacer(),
                            Text(
                              "0.759 \$",
                              style: textStyle,
                            )
                          ],
                        ),
                      ],
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

TextStyle get textStyle =>
    GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w700);

LineTouchData get lineTouchData1 => LineTouchData(
      handleBuiltInTouches: true,
      touchTooltipData:
          LineTouchTooltipData(tooltipBgColor: Colors.blue.shade100),
    );

FlTitlesData get titlesData1 => FlTitlesData(
      bottomTitles: bottomTitles,
      rightTitles: SideTitles(showTitles: false),
      topTitles: SideTitles(showTitles: false),
      leftTitles: leftTitles(
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '1.000';
            case 2:
              return '2.000';
            case 3:
              return '3.000';
            case 4:
              return '5.000';
          }
          return '';
        },
      ),
    );

List<LineChartBarData> get lineBarsData1 => [
      lineChartBarData1_1,
      lineChartBarData1_2,
      lineChartBarData1_3,
    ];

SideTitles leftTitles({required GetTitleFunction getTitles}) => SideTitles(
      getTitles: getTitles,
      showTitles: true,
      margin: 8,
      interval: 1,
      reservedSize: 40,
      getTextStyles: (context, value) => const TextStyle(
        color: AppColor.homeScreenTitle,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

SideTitles get bottomTitles => SideTitles(
      showTitles: true,
      reservedSize: 22,
      margin: 10,
      interval: 1,
      getTextStyles: (context, value) => const TextStyle(
        color: AppColor.homeScreenTitle,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      getTitles: (value) {
        switch (value.toInt()) {
          case 2:
            return 'SEPT';
          case 7:
            return 'OCT';
          case 12:
            return 'DEC';
        }
        return '';
      },
    );

FlGridData get gridData => FlGridData(show: false);

FlBorderData get borderData => FlBorderData(
      show: true,
      border: const Border(
        bottom: BorderSide(color: AppColor.homeScreenTitle, width: 4),
        left: BorderSide(color: Colors.transparent),
        right: BorderSide(color: Colors.transparent),
        top: BorderSide(color: Colors.transparent),
      ),
    );

LineChartBarData get lineChartBarData1_1 => LineChartBarData(
      isCurved: true,
      colors: [AppColor.Chart1],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
    );

LineChartBarData get lineChartBarData1_2 => LineChartBarData(
      isCurved: true,
      colors: [AppColor.Chart2],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false, colors: [
        const Color(0x00aa4cfc),
      ]),
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 2.8),
        FlSpot(7, 1.2),
        FlSpot(10, 2.8),
        FlSpot(12, 2.6),
        FlSpot(13, 3.9),
      ],
    );

LineChartBarData get lineChartBarData1_3 => LineChartBarData(
      isCurved: true,
      colors: const [AppColor.Chart3],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: [
        FlSpot(1, 2.8),
        FlSpot(3, 1.9),
        FlSpot(6, 3),
        FlSpot(10, 1.3),
        FlSpot(13, 2.5),
      ],
    );
