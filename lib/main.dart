import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_night/firebase_options.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/screens/root_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  await dotenv.load(fileName: ".env");
  runApp(
      ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void subscribeToAuthStateChanges(BuildContext context) {
    FirebaseAuth
      .instance
      .authStateChanges()
      .listen((User? user) {
        Provider.of<AuthProvider>(context, listen: false).setUser(user);
      });
  }

  @override
  Widget build(BuildContext context) {
    subscribeToAuthStateChanges(context);
    return MaterialApp(
      title: 'MovieWatch',
      theme: ThemeData.dark().copyWith(
        primaryColorLight: Colors.amber,
        textTheme: const TextTheme(
          labelLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17
          ),
          headlineSmall: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          )
        )
      ),
      home: RootScreen(),
    );
  }
}