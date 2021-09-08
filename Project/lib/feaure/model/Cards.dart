class Cards {
  String? number;
  String? name;
  String? cvv;
  String? date;

  Cards({this.number, this.name, this.cvv, this.date});

  Cards.fromJson(Map<String, dynamic> json) {
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
