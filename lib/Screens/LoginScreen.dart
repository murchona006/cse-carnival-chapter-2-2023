// import 'package:auth_test/Services/auth_service.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import '../utils/utils.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   late String _email;
//   late String _password;
//
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery
//         .of(context)
//         .size
//         .height;
//     final screenWidth = MediaQuery
//         .of(context)
//         .size
//         .width;
//
//     return Scaffold(
//       backgroundColor: Color(0xFF041B46), // Background color
//       body: SingleChildScrollView(
//         child: Container(
//           height: screenHeight,
//           width: screenWidth,
//           child: Stack(
//             children: [
//               Positioned(
//                 top: -screenHeight * 0.15,
//                 left: -screenWidth * 0.15,
//                 right: 150,
//                 child: Container(
//                   height: screenHeight * 0.4,
//                   width: screenWidth,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color(
//                         0xFFBAE4FA), // Background color to hide the upper half
//                   ),
//                   child: Center(
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 68.0),
//                       child: Text(
//                         "",
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xFF041B46),
//                           fontSize: 30,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Center(
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 230),
//                   child: Container(
//                     width: screenWidth * 0.73,
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 260,
//                           height: 60,
//                           decoration: BoxDecoration(
//                             //color: Colors.black,
//                             color: Colors.transparent,
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(12),
//                             ),
//                           ),
//                           // child: Center(
//                           //   child: Text(
//                           //     "Coderscombo",
//                           //     style: TextStyle(
//                           //       fontWeight: FontWeight.w500,
//                           //       //color: Color(0xFFFFF58D),
//                           //       color: Colors.black,
//                           //
//                           //       fontSize: 30,
//                           //     ),
//                           //   ),
//                           // ),
//                           // child: Center(
//                           //   child: Container(
//                           //     width: 700, // Adjust the width as needed
//                           //     height: 700, // Adjust the height as needed
//                           //     child: Image.asset(
//                           //       'assets/Logo_TBW1.png', // Replace 'your_image.png' with your actual image path
//                           //       width: 500, // Adjust the width as needed
//                           //       height: 500, // Adjust the height as needed
//                           //     ),
//                           //   ),
//                           // ),
//
//
//                           child: Center(
//                             child: Transform.scale(
//                               scale: 1.05,
//                               // You can adjust the scale factor as needed
//                               child: Image.asset(
//                                 'assets/Logo_TW1.png', // Replace with your image path
//                               ),
//                             ),
//                           ),
//
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 10.0),
//                           child: Card(
//                             color: Color(0xFFBAE4FA),
//                             //Color(0xFFFFFF176), FFFCCCFF, E0DDDDFF
//                             elevation: 17,
//                             shadowColor: Colors.white70,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(20.0),
//                               child: Form(
//                                 key: _formKey,
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     SizedBox(height: 20),
//                                     Text(
//                                       'Log In',
//                                       style: TextStyle(
//                                         fontSize: 24,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                      SizedBox(height: 20),
//                                     TextFormField(
//                                     //  controller: _emailController,
//                                       decoration: InputDecoration(
//                                         labelText: 'Email',
//     hintStyle: TextStyle(
//     color: Colors.black26,
//     )),
//     onChanged: (value) {
//     _email = value;
//     },
//     ),
//
//                                       //   prefixIcon: Icon(
//                                       //     Icons.email,
//                                       //     color: Colors.black,
//                                       //   ),
//                                       // ),
//                                     //   validator: (value) {
//                                     //     if (value!.isEmpty) {
//                                     //       return 'Please enter your email';
//                                     //     }
//                                     //     return null;
//                                     //   },
//                                     // ),
//                                     SizedBox(height: 10),
//                                     TextFormField(
//                                       controller: _passwordController,
//                                       obscureText: true,
//                                       decoration: InputDecoration(
//                                         labelText: 'Password',
//                                         prefixIcon: Icon(
//                                           Icons.lock,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                       hintStyle: TextStyle(
//                                         color: Colors.black26,
//                                       ),
//                                     ),
//                                 onChanged: (value) {
//                                   _password = value;
//                                 },
//                                       validator: (value) {
//                                         if (value!.isEmpty) {
//                                           return 'Please enter your password';
//                                         }
//                                         return null;
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () async {
//                     bool isValid = await AuthService.login(_email, _password);
//
//                     if (isValid) {
//                       Navigator.pop(context);
//                     } else {
//                       Utils().toastMessage("Invalid email/password.");
//                       //print('LogIn Problem');
//                     }
//                     // if (_email == "ac799394@gmail.com" && _password == "admin1") {
//                     //   Navigator.push(
//                     //     context, MaterialPageRoute(builder: (context) => AdminPanel()),
//                     //   ); // Navigate to the admin panel
//                     // } else {
//                     // bool isValid = await AuthService.login(_email, _password);
//                     //
//                     // if (isValid) {
//                     //     Navigator.pop(context);
//                     // } else {
//                     //     Utils().toastMessage("Invalid email/password.");
//                     // //print('LogIn Problem');
//                     //   }
//                     // }
//                   },
// //                   minWidth: 320,
// //                   height: 60,
// //                 ),,
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Padding(
//                     padding: const EdgeInsets.only(bottom: 58.0),
//                     child: Container(
//                       width: screenWidth / 3,
//                       height: screenHeight * 0.09,
//                       decoration: BoxDecoration(
//                         color: Colors.white70,
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Log In",
//                           style: TextStyle(
//                             color: Color(0xFF041B46),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:auth_test/Screens/AdminChatScreen.dart';
import 'package:auth_test/Screens/Forgot_PassScreen.dart';
import 'package:auth_test/Screens/RegistrationScreen.dart';
import 'package:flutter/material.dart';

import '../Constants/Constants.dart';
import '../Services/auth_service.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Color(0xFF041B46), // Background color
      body: SingleChildScrollView(
      child: Container(
      height: screenHeight,
      width: screenWidth,
      child: Stack(
        children: [
        Positioned(
        top: -screenHeight * 0.15,
        left: -screenWidth * 0.15,
        right: 150,
        child: Container(
          height: screenHeight * 0.4,
          width: screenWidth,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(
                0xFFBAE4FA), // Background color to hide the upper half
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 68.0),
              child: Text(
                "",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF041B46),
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 230),
          child: Container(
            width: screenWidth * 0.73,
            child: Column(
              children: [
                Container(
                  width: 260,
                  height: 60,
                  decoration: BoxDecoration(
                    //color: Colors.black,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  // child: Center(
                  //   child: Text(
                  //     "Coderscombo",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w500,
                  //       //color: Color(0xFFFFF58D),
                  //       color: Colors.black,
                  //
                  //       fontSize: 30,
                  //     ),
                  //   ),
                  // ),
                  // child: Center(
                  //   child: Container(
                  //     width: 700, // Adjust the width as needed
                  //     height: 700, // Adjust the height as needed
                  //     child: Image.asset(
                  //       'assets/Logo_TBW1.png', // Replace 'your_image.png' with your actual image path
                  //       width: 500, // Adjust the width as needed
                  //       height: 500, // Adjust the height as needed
                  //     ),
                  //   ),
                  // ),


                  child: Center(
                    child: Transform.scale(
                      scale: 1.25,
                      // You can adjust the scale factor as needed
                      child: Image.asset(
                        'assets/Logo_TW1.png', // Replace with your image path
                      ),
                    ),
                  ),

                ),

                // Text Field-------
                // SizedBox(height: 25),
                //
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25),
                //   child: TextField(
                //     decoration: InputDecoration(
                //         enabledBorder: const OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.white),
                //         ),
                //         focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.grey.shade400),
                //         ),
                //         fillColor: Colors.grey.shade200,
                //         filled: true,
                //         hintText: 'Email',
                //         hintStyle: TextStyle(
                //           color: Colors.black26,
                //         )
                //
                //     ),
                //   ),
                // ),

                SizedBox(height: 35),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Colors.black26,
                        )),
                    onChanged: (value) {
                      _email = value;
                    },
                  ),
                ),

                SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      ),
                    ),
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                ),

                SizedBox(
                  height: 50,
                ),
                MaterialButton(
                  elevation: 10,
                  color: Colors.white70,
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Color(0xFF041B46), fontSize: 20),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () async {
                    bool isValid = await AuthService.login(_email, _password);

                    if (isValid) {
                      Navigator.pop(context);
                    } else {
                      Utils().toastMessage("Invalid email/password.");
                      //print('LogIn Problem');
                    }
                    // if (_email == "ac799394@gmail.com" && _password == "admin1") {
                    //   Navigator.push(
                    //     context, MaterialPageRoute(builder: (context) => AdminPanel()),
                    //   ); // Navigate to the admin panel
                    // } else {
                    // bool isValid = await AuthService.login(_email, _password);
                    //
                    // if (isValid) {
                    //     Navigator.pop(context);
                    // } else {
                    //     Utils().toastMessage("Invalid email/password.");
                    // //print('LogIn Problem');
                    //   }
                    // }
                  },
                  minWidth: 320,
                  height: 60,
                ),

                // MOVE LOGIN PAGE

                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 55.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen()),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Do not have an account?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()),
                            );
                          },
                          child: Text(
                            ' Sign Up',
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
      ),
    ),
      ),
    );
  }
}
