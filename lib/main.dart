import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:not/firebase_options.dart';
import 'package:not/routes.dart';
import 'package:not/screen/home_screen.dart';
import 'package:not/screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFirestore.instance.settings=const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  // await FirebaseFirestore.instance.disableNetwork();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder:(_)=>const Center(
        child: SpinKitFadingCircle(
          color: Colors.red,
          size: 150.0,
        ),
      ),
      overlayColor: Colors.black,
      // overlayOpacity: 0.8,
      duration: const Duration(seconds: 2),
      child: MaterialApp(
    theme: ThemeData(
    appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white), // set backbutton color here which will reflect in all screens.
    ),),
        debugShowCheckedModeBanner: false,
        // initialRoute: (FirebaseAuth.instance.currentUser != null &&  FirebaseAuth.instance.currentUser!.emailVerified)
        initialRoute: (FirebaseAuth.instance.currentUser != null)
            ? HomeScreen.routeName
            : LoginScreen.routeName,
        // initialRoute: HomeScreen.routeName,
        routes:RouteMain.route,
      ),
    );
  }
}
