import 'package:flutter/material.dart';

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({required this.name, required this.percent, required this.color});
}

class PieData {
  static List<Data> data = [
    Data(name: 'Bitcoin', percent: 40, color: const Color(0xff9B5DE5)),
    Data(name: 'USD', percent: 30, color: const Color(0xffF15BB5)),
    Data(name: 'XRP', percent: 15, color: Color(0xFFFEE440)),
    Data(name: 'Etherium', percent: 15, color: const Color(0xff00BBF9)),
  ];
}
