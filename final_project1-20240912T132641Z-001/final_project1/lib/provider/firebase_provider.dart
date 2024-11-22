import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseProvider with ChangeNotifier {
  final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  final FirebaseAuth _fireAuth = FirebaseAuth.instance;

  User? _user;
  String _temp = "0";
  String _hum = "0";
  bool _led1LivingRoom = false;
  bool _fanLivingRoom = false;
  bool _ledBedRoom = false;
  bool _ledKitchen = false;

  bool get led1LivingRoom => _led1LivingRoom;

  bool get fanLivingRoom => _fanLivingRoom;

  bool get ledBadRoom => _ledBedRoom;

  bool get ledKitchen => _ledKitchen;

  String get temp => _temp;

  User? get user => _user;

  String get hum => _hum;

  Future<void> setLivingRoomLed1(bool value) async {
    DatabaseReference led1LivingRoomRef =
        firebaseDatabase.ref().child("livingRoom").child("led1");
    await led1LivingRoomRef.set(value);
    _led1LivingRoom = value;
    notifyListeners();
  }
  Future<void> setLivingRoomFan(bool value) async {
    DatabaseReference fanLivingRoomRef =
    firebaseDatabase.ref().child("livingRoom").child("fan");
    await fanLivingRoomRef.set(value);
    _fanLivingRoom = value;
    notifyListeners();
  }
  Future<void> setBedRoomLed(bool value) async {
    DatabaseReference ledBedRoomRef =
    firebaseDatabase.ref().child("BedRoom").child("led");
    await ledBedRoomRef.set(value);
    _ledBedRoom = value;
    notifyListeners();
  }
  Future<void> setKitchenLed(bool value) async {
    DatabaseReference ledKitchenRef =
    firebaseDatabase.ref().child("Kitchen").child("led");
    await ledKitchenRef.set(value);
    _ledKitchen = value;
    notifyListeners();
  }

  Future<void> getData() async {
    DatabaseReference tempRef =
        firebaseDatabase.ref().child("home").child("temp");
    DatabaseReference humRef =
        firebaseDatabase.ref().child("home").child("hum");
    tempRef.onValue.listen((event) {
      _temp = event.snapshot.value.toString();
      notifyListeners();
    });

    humRef.onValue.listen((event) {
      _hum = event.snapshot.value.toString();
      notifyListeners();
    });

    var led1LivingRoomRef = await firebaseDatabase.ref().child("livingRoom")
        .child("led1").once();
    _led1LivingRoom = led1LivingRoomRef.snapshot.value as bool;

    var fanLivingRoomRef = await firebaseDatabase.ref().child("livingRoom")
        .child("fan").once();
    _fanLivingRoom = fanLivingRoomRef.snapshot.value as bool;

    var ledBedRoomRef = await firebaseDatabase.ref().child("BedRoom")
        .child("led").once();
    _ledBedRoom = ledBedRoomRef.snapshot.value as bool;

    var ledKitchenRef = await firebaseDatabase.ref().child("Kitchen")
        .child("led").once();
    _ledKitchen = ledKitchenRef.snapshot.value as bool;
    notifyListeners();
  }

  Future<User?> signUpUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential credential = await _fireAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamed(context, "/LoginPage");
      return credential.user;
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message!),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("ok"),
                )
              ],
            );
          });
    }
    return null;
  }

  Future<void> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    if(email.isEmpty||password.isEmpty){
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text("Please fill in all information"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("ok"),
                )
              ],
            );
          });
      return;
    }
    try {
      UserCredential credential = await _fireAuth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = credential.user;
      Navigator.pushNamed(context, "/HomePage");
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message!),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("ok"),
                )
              ],
            );
          });
    }
  }

  void logout(BuildContext context) {
    _user = null;
    Navigator.pushNamed(context, "/LoginPage");
    notifyListeners();
  }
}
