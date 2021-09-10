import 'package:finance_app/constants/color_theme.dart';
import 'package:finance_app/feaure/model/pie_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: PieData.data.map((data) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: buildIndicator(
            color: data.color, text: data.name, percent: data.percent),
      );
    }).toList());
  }
}

Widget buildIndicator(
        {required Color color,
        required String text,
        required double percent,
        bool isSquare = false,
        double size = 16}) =>
    Container(
        width: 80,
        margin: EdgeInsets.all(3),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Color(0xFF5F646F),
          border: Border.all(
            color: Color(0xFF211E21),
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "%${percent.toInt()}",
                  style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColor.secondaryColor),
                ),
              ],
            ),
            Text(
              text,
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColor.secondaryColor.withOpacity(.7)),
            ),
          ],
        ));
