class Transaction {
  String? companyName;
  String? date;
  double? price;

  Transaction({this.companyName, this.date, this.price});

  Transaction.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    date = json['date'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyName'] = this.companyName;
    data['date'] = this.date;
    data['price'] = this.price;
    return data;
  }
}
