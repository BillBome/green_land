import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:green_land/pages/home.dart';
import 'package:green_land/pages/landing.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDt2cx4R9-In31mwg0c__Vq8vJgZL3k0TM ",
      appId: "1:597250421615:android:6ec0fedfcc9a837bdc2e9a",
      messagingSenderId: "597250421615",
      projectId: "greenland-ap",
      storageBucket: "gs://greenland-ap.appspot.com",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      title: "Green Land",
      home: LandingPage(),
    );
  }
}
