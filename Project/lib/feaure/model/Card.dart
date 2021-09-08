class Card {
  String? number;
  String? name;
  String? cvv;
  String? date;

  Card({this.number, this.name, this.cvv, this.date});

  Card.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    cvv = json['cvv'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['name'] = this.name;
    data['cvv'] = this.cvv;
    data['date'] = this.date;
    return data;
  }
}
