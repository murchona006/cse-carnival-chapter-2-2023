import 'package:auth_test/Screens/AdminPanelScreen.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../Constants/Constants.dart';
import '../Screens/DSA.dart';
import '../Screens/HomeScreen.dart';
import '../Screens/Messenger.dart';
import '../Screens/SearchScreen.dart';
import '../Screens/ProfileScreen.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  final String currentUserId;
  const FeedScreen({Key? key, required this.currentUserId}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedTab = 0;

  void initState() {
    super.initState();
  }

  Widget getSelectedScreen() {
    if (widget.currentUserId == "CwXqp7gKtPWUmi9VNJXO0GX7S0G2") {
      // If the user ID matches the admin, return the AdminPanel screen.
      return AdminPanel();
    } else {
      // For other users, return the Messenger screen.
      return Messenger(currentUserId: widget.currentUserId,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomeScreen(
          currentUserId: widget.currentUserId,
        ),
        DSA(),
        getSelectedScreen(), // Use the function to get the selected screen.
        SearchScreen(
          currentUserId: widget.currentUserId,
        ),
        ProfileScreen(
          currentUserId: widget.currentUserId,
          visitedUserId: widget.currentUserId,
        ),
      ].elementAt(_selectedTab),
      bottomNavigationBar: GNav(
        backgroundColor: AppColor_Blue,
        color: AppColor_White,
        tabBackgroundColor: Colors.blue,
        gap: 8,
        padding: EdgeInsets.all(16),
        onTabChange: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.code,
            text: 'DSA',
          ),
          GButton(
            icon: Icons.message_outlined,
            text: 'Message',
            onPressed: () {
              // if (widget.currentUserId == "CwXqp7gKtPWUmi9VNJXO0GX7S0G2") {
              //   // Admin user, navigate to AdminPanel screen.
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => AdminPanel()),
              //   );
              // } else {
              //   // Regular user, open another app.
              //   LaunchApp.openApp(
              //     androidPackageName: 'com.coderscombo.chatapp',
              //   );
              // }
              Messenger(currentUserId: widget.currentUserId);
            },
          ),
          GButton(
            icon: Icons.search,
            text: 'Search',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          ),
        ],
      ),
    );
  }
}
