import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_postman/app/app.dart';
import 'package:flutter_postman/app/utils/utils.dart';
import 'package:flutter_postman/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firebaseAuth = FirebaseAuth.instance; 

  runApp(MyApp(userSignedIn: firebaseAuth.currentUser.isNotNull));
}
