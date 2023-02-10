import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_night/firebase_options.dart';
import 'package:movie_night/providers/auth_provider.dart';
import 'package:movie_night/screens/root_screen.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult? _connectionStatus;

  @override
  void initState() {
    final Connectivity connectivity = Connectivity();
    _connectivitySubscription = connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    print("Connection status: $result");
    setState(() {
      _connectionStatus = result;
    });
  }

  void subscribeToAuthStateChanges(BuildContext context) {
    FirebaseAuth
      .instance
      .authStateChanges()
      .listen((User? user) {
        Provider.of<AuthProvider>(context, listen: false).setUser(user);
      });
  }

  Widget getRootScreen(BuildContext context) {
    if(_connectionStatus == null) {
      return const Center(
        child: LoadingSpinner(),
      );
    } else if(_connectionStatus == ConnectivityResult.none) {
      return Scaffold(
        body: Center(
          child: Text(
            "No internet connection!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      );
    } else {
      return const RootScreen();
    }
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
          ),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                // backgroundColor: ,
                foregroundColor: MaterialStateProperty.all<Color>(Colors.amber),
              )
          )
      ),
      home: getRootScreen(context),
    );
  }
}