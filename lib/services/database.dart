import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pizzeria_menu/models/modals.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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

  void createRecord() async {
    await handleTaskUpload();
    Map<String, dynamic> data = {
      "title": pizzaDetailsProduct.title,
      'description': pizzaDetailsProduct.description,
      'image': pizzaDetailsProduct.image,
      'modifier': pizzaDetailsProduct.modifiers
          .map((e) => {
                'name': e.name,
                'required': e.required,
                'oneMany': e.oneMany,
                'opinion': e.options
                    .map((e) => {'name': e.name, 'price': e.price})
                    .toList()
              })
          .toList()
    };
    await _cloudfirestore.collection('foodMenu').add(data);
    clearRecord();
  }

  Future<void> handleTaskUpload() async {
    File largeFile = File(pizzaDetailsProduct.image);
    if (!await largeFile.exists()) {
      return;
    }
    firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
        .ref('uploads/${largeFile.path.split("/").last}')
        .putFile(largeFile);

    task.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
      print('Task state: ${snapshot.state}');
      print(
          'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
    }, onError: (e) {
      // The final snapshot is also available on the task via `.snapshot`,
      // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
      print(task.snapshot);

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    });

    // We can still optionally use the Future alongside the stream.
    try {
      await task;
      pizzaDetailsProduct.image = await firebase_storage
          .FirebaseStorage.instance
          .ref('uploads/${largeFile.path.split("/").last}')
          .getDownloadURL();
      print('Upload complete.');
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    }
  }

  void clearRecord() async {
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

  Future<String> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await _firebaseAuth.signInWithCredential(credential);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    // Once signed in, return the UserCredential
    //return await _firebaseAuth.signInWithCredential(credential);
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
