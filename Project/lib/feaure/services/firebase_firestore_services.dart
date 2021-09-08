import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreServices {
  CollectionReference reference =
      FirebaseFirestore.instance.collection("Cards");
  Future addCard(Map card) async {
    await reference.doc().set(card);
  }
}
