import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: const Text(
            'Admin Panel',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 70.0,
              ),
              Container(
                width: size.height * 0.4,
                height: size.width * 0.14,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: ElevatedButton(
                    onPressed: () {
                      print('ElevatedButton pressed');
                    },
                    child: Text('Messege'),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: size.height * 0.4,
                height: size.width * 0.14,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: ElevatedButton(
                    onPressed: () {
                      print('ElevatedButton pressed');
                    },
                    child: Text('UserInfo'),
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