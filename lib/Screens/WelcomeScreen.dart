import 'package:auth_test/Screens/LoginScreen.dart';
import 'package:auth_test/Screens/RegistrationScreen.dart';
import 'package:flutter/material.dart';

import '../Constants/Constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF041B46), // Background color
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              Positioned(
                top: -screenHeight * 0.10,
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
                  padding: const EdgeInsets.only(top: 300),
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
                              scale:
                              2.05, // You can adjust the scale factor as needed
                              child: Image.asset(
                                'assets/Logo_TW1.png', // Replace with your image path
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 148.0),
                          child: Column(
                            children: [
                              MaterialButton(
                                elevation: 20,
                                //color: AppColor_White,
                                color: Color(0xFFBAE4FA),
                                child: Text(
                                  'LOG IN',
                                  style: TextStyle(
                                      color: Color(0xFF041B46),fontSize: 20),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ),
                                  );
                                },
                                minWidth: 320,
                                height: 60,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              MaterialButton(
                                elevation: 20,
                                color: AppColor_White,
                                child: Text(
                                  'CREATE ACCOUNT',
                                  style: TextStyle(
                                      color: Color(0xFF041B46), fontSize: 20),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegistrationScreen()),
                                  );
                                },
                                minWidth: 320,
                                height: 60,
                              ),
                            ],
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