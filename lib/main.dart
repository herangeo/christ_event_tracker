// main.dart

import 'package:christ_event_tracker/HostEventsScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loading_screen.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions
    (apiKey:"AIzaSyDOkRNZis3Av4Y_TnpCtmS7Hfw0D1PyXxY" , 
    appId: "1:1059839224528:android:0d4d38366e5ff1ec828cd5", 
    messagingSenderId: "1059839224528",
    projectId: "fomonomo-2024")
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: GoogleFonts.aDLaMDisplayTextTheme()
      ),
      home: LoadingScreen(),
    );
  }
}


