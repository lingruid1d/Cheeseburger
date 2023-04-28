import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static Future login(
    String email,
    String password,
  ) async {
    QuerySnapshot res = await FirebaseFirestore.instance
        .collection('film_user')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();
    if (res.docs.isNotEmpty) {
      Map<String, dynamic> data = res.docs[0].data() as Map<String, dynamic>;
      return data;
    }
    return null;
  }

  static Future query() async {
    QuerySnapshot res =
        await FirebaseFirestore.instance.collection('film_item').get();
    if (res.docs.isNotEmpty) {
      List list = res.docs.map((e) => e.data()).toList();
      return list;
    }
    return [];
  }

  static Future register(
    String username,
    String email,
    String password,
  ) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('film_user');
    var res = await users.add({
      'username': username, // John Doe
      'password': password, // Stokes and Sons
      'email': email // 42
    });
    return res;
  }
}
