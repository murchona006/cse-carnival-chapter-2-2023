import 'package:auth_test/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserResource extends StatefulWidget {
  @override
  _UserResourceState createState() => _UserResourceState();
}

class _UserResourceState extends State<UserResource> {
  TextEditingController messageController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  // Reference to the Firestore collection
  CollectionReference messages = FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(255,1,37,66),//Colors.white,
        backgroundColor: Colors.grey[300],
        elevation: 10,
        centerTitle: true,
        leading: Container(
          height: 40,
          child: Image.asset('assets/Logo_TBW1.png'),
        ),
        title: Text(
          'CodersCombo',
          style: TextStyle(
            color: Colors.black,//AppColor,
          ),


        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5, // Add elevation to the Card

              // SizedBox(height: 20),
              child: Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: messages.orderBy('date').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var document = snapshot.data!.docs[index];
                          String date = document['date'];
                          String message = document['message'];
                          return ListTile(
                            title: Text(
                              date,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColor_Blue,

                              ),
                            ),

                            subtitle: Text(
                                message,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 32,
                                color: Colors.black
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
          ),
        ),

    );
  }

  Future<void> _sendMessage() async {
    String message = messageController.text;
    String date = dateController.text;

    if (message.isNotEmpty && date.isNotEmpty) {
      await messages.add({
        'message': message,
        'date': date,
      });

      messageController.clear();
      dateController.clear();
    }
  }
}
