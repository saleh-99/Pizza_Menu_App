import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pizzeria_menu/models/modals.dart';

class Database {
  final _cloudfirestore = FirebaseFirestore.instance;
  final PizzaDetails pizzaDetailsProduct = new PizzaDetails(
      title: "",
      description: "",
      image: "",
      modifiers: <Modifier>[
        Modifier(
            oneMany: true,
            required: true,
            options: [Option(name: "", price: "")])
      ]);
  Stream<List<PizzaDetails>> getPizzaDetailsrList() {
    return _cloudfirestore
        .collection('foodMenu')
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => PizzaDetails.fromFirestore(document))
            .toList())
        .handleError((e) {
      print(e);
    });
  }

  void createRecord(PizzaDetails pizzaDetails) async {
    Map<String, dynamic> m;
    await _cloudfirestore.collection('Collage').doc("").set(m);
  }

  void clearRecord() {
    pizzaDetailsProduct
      ..title = ""
      ..description = ""
      ..image = ""
      ..modifiers = [];
  }
}

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
