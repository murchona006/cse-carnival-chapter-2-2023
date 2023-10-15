import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Resource extends StatefulWidget {
  @override
  _ResourceState createState() => _ResourceState();
}

class _ResourceState extends State<Resource> {
  TextEditingController messageController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  // Reference to the Firestore collection
  CollectionReference messages = FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resource Platform'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5, // Add elevation to the Card
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Resource Platform',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Select a Date',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
                subtitle: TextField(
                  controller: dateController,
                  decoration: InputDecoration(hintText: 'Enter a date'),
                ),
              ),
              ListTile(
                title: Text(
                  'Message',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
                subtitle: TextField(
                  controller: messageController,
                  decoration: InputDecoration(hintText: 'Enter a message'),
                ),
              ),
              ElevatedButton(
                onPressed: _sendMessage,
                child: Text('Send Message'),
              ),
              SizedBox(height: 20),
              Expanded(
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
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(message),
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ],
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
