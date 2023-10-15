import 'package:auth_test/Screens/FeedScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Screens/WelcomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDdyuGYOEMstw0SaIviaNew4NZKYbn3DWk",
        authDomain: "auth-v2-27a5a.firebaseapp.com",
        projectId: "auth-v2-27a5a",
        storageBucket: "auth-v2-27a5a.appspot.com",
        messagingSenderId: "1:343955373431:android:262f48e602a818be5f3572",
        appId: "1:343955373431:android:262f48e602a818be5f3572",
      )
    );
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  // runApp(MyApp(isFirebaseInitialized: await Firebase.appNamed('[DEFAULT]') != null));
  runApp(MyApp(isFirebaseInitialized: await checkFirebaseInitialization()));

}

Future<bool> checkFirebaseInitialization() async {
  // Use Firebase.apps to check if Firebase is initialized.
  return Firebase.apps.isNotEmpty;
}


class MyApp extends StatelessWidget {

  final bool isFirebaseInitialized;

  MyApp({required this.isFirebaseInitialized}) : super(key: Key("MyAppKey"));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (isFirebaseInitialized) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
          home:InitialApp()

      );

    } else {
      return CircularProgressIndicator(
        strokeWidth: 2,
      ); // Or any other widget
    }

  }
}


class InitialApp extends StatelessWidget {
  const InitialApp({Key? key}) : super(key: key);

  Widget getScreenId(){
    return StreamBuilder<dynamic>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot){
          if(snapshot.hasData){
            return FeedScreen(currentUserId: snapshot.data.uid);
          }
          else{
            return WelcomeScreen();
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: getScreenId(),
      //home: WelcomeScreen(),
      //home: RegistrationScreen(),
      //home: LoginScreen(),
      //home: FeedScreen(currentUserId: '',),
    );
  }
}






// import 'package:auth_test/UI/navigationbar.dart';
// import 'package:auth_test/UI/singin.dart';
// import 'package:auth_test/UI/singup.dart';
// import 'package:auth_test/UI/wellcomepage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// // void main() async {
// //    //WidgetsFlutterBinding.ensureInitialized();
// //    await Firebase.initializeApp();
// //   runApp(MyApp());
// // }
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   try {
//     await Firebase.initializeApp(
//       options: FirebaseOptions(
//         apiKey: "AIzaSyDdyuGYOEMstw0SaIviaNew4NZKYbn3DWk",
//         authDomain: "auth-v2-27a5a.firebaseapp.com",
//         projectId: "auth-v2-27a5a",
//         storageBucket: "auth-v2-27a5a.appspot.com",
//         messagingSenderId: "1:343955373431:android:262f48e602a818be5f3572",
//         appId: "1:343955373431:android:262f48e602a818be5f3572",
//       )
//     );
//   } catch (e) {
//     print('Error initializing Firebase: $e');
//   }
//
//   // runApp(MyApp(isFirebaseInitialized: await Firebase.appNamed('[DEFAULT]') != null));
//   runApp(MyApp(isFirebaseInitialized: await checkFirebaseInitialization()));
//
// }
//
// Future<bool> checkFirebaseInitialization() async {
//   // Use Firebase.apps to check if Firebase is initialized.
//   return Firebase.apps.isNotEmpty;
// }
//
//
// class MyApp extends StatelessWidget {
//
//   final bool isFirebaseInitialized;
//
//   MyApp({required this.isFirebaseInitialized}) : super(key: Key("MyAppKey"));
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     if (isFirebaseInitialized) {
//       return MaterialApp(
//
//           home:initial()
//
//       );
//
//     } else {
//       return CircularProgressIndicator(
//         strokeWidth: 2,
//       ); // Or any other widget
//     }
//
//   }
// }
//
// class initial extends StatefulWidget {
//   const initial({Key? key}) : super(key: key);
//
//   @override
//   State<initial> createState() => _initialState();
// }
//
// class _initialState extends State<initial> {
//
//   Widget getScreenId(){
//     return StreamBuilder<dynamic>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (BuildContext context, snapshot){
//           if(snapshot.hasData){
//             return NavigationScreen(currentUserId: snapshot.data.uid);
//           }
//           else{
//             // return SigninPage();
//             return WelcomePage();
//           }
//         }
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: getScreenId(),
//     );
//   }
// }
//
//
