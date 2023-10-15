// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class Messenger extends StatefulWidget {
//   final String currentUserId;
//   final String chatUserId = "CwXqp7gKtPWUmi9VNJXO0GX7S0G2";
//
//   Messenger({required this.currentUserId});
//
//   @override
//   _MessengerState createState() => _MessengerState();
// }
//
// class _MessengerState extends State<Messenger> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   CollectionReference? _chatCollection;
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   List<Map<String, dynamic>> messages = [];
//   TextEditingController messageController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     // Store all chat data in a single "chats" collection
//     _chatCollection = _firestore.collection('chats');
//     _subscribeToChatMessages();
//   }
//
//   void _subscribeToChatMessages() {
//     // Query the "chats" collection for messages from the admin (currentUserId) and the specific user
//     Query chatQuery = _chatCollection!
//         .where('senderId', whereIn: [widget.currentUserId, widget.chatUserId])
//         .orderBy('timestamp');
//
//     chatQuery.snapshots().listen((snapshot) {
//       setState(() {
//         messages = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//       });
//     });
//   }
//
//   void _sendMessage() {
//     String message = messageController.text;
//     if (message.isNotEmpty) {
//       _chatCollection!.add({
//         'senderId': widget.currentUserId,
//         'receiverId': widget.chatUserId,
//         'text': message,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//       messageController.clear();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat with User'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[index];
//                 return ListTile(
//                   title: Text(message['text'] as String),
//                   subtitle: Text(message['senderId'] == widget.currentUserId
//                       ? 'You'
//                       : message['senderId'] as String),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message...',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//


import 'package:auth_test/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messenger extends StatefulWidget {
  final String currentUserId;
  final String chatUserId;
  final String adminUserId; // Add this field

  Messenger({
    required this.currentUserId,
    required this.chatUserId,
    required this.adminUserId, // Initialize this field
  });

  @override
  _MessengerState createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      body: Column(

        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('convo')
                  .doc(widget.currentUserId)
                  .collection(widget.chatUserId)
                  .orderBy('timestamp', descending: true) // Reverse order to show the latest message at the bottom
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final messages = snapshot.data!.docs;
                List<Widget> messageWidgets = [];
                for (var message in messages) {
                  final messageText = message['text'];
                  final messageSender = message['senderId'];
                  final isMe = messageSender == widget.currentUserId;
                  final messageWidget = MessageWidget(
                    text: messageText,
                    isMe: isMe,
                  );
                  messageWidgets.add(messageWidget);
                }
                return ListView(
                  reverse: true,
                  children: messageWidgets,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: 'Enter your message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    String messageText = _messageController.text.trim();
                    if (messageText.isNotEmpty) {
                      await _firestore
                          .collection('convo')
                          .doc(widget.currentUserId)
                          .collection(widget.chatUserId)
                          .add({
                        'text': messageText,
                        'timestamp': FieldValue.serverTimestamp(),
                        'senderId': widget.currentUserId,
                        'userId': widget.chatUserId, // Include user's ID
                        'adminUserId': widget.adminUserId, // Include admin's ID
                      });
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class Messenger extends StatefulWidget {
//   final String currentUserId;
//   final String chatUserId;
//
//   Messenger({required this.currentUserId, required this.chatUserId});
//
//   @override
//   _MessengerState createState() => _MessengerState();
// }
//
// class _MessengerState extends State<Messenger> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat with Admin'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _firestore
//                   .collection('messages')
//                   .doc(widget.currentUserId)
//                   .collection(widget.chatUserId)
//                   .orderBy('timestamp', descending: true) // Reverse order to show the latest message at the bottom
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return CircularProgressIndicator();
//                 }
//                 final messages = snapshot.data!.docs;
//                 List<Widget> messageWidgets = [];
//                 for (var message in messages) {
//                   final messageText = message['text'];
//                   final messageSender = message['senderId'];
//                   final isMe = messageSender == widget.currentUserId;
//                   final messageWidget = MessageWidget(
//                     text: messageText,
//                     isMe: isMe,
//                   );
//                   messageWidgets.add(messageWidget);
//                 }
//                 return ListView(
//                   reverse: true,
//                   children: messageWidgets,
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(hintText: 'Enter your message'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () async {
//                     String messageText = _messageController.text.trim();
//                     if (messageText.isNotEmpty) {
//                       await _firestore
//                           .collection('messages')
//                           .doc(widget.currentUserId)
//                           .collection(widget.chatUserId)
//                           .add({
//                         'text': messageText,
//                         'timestamp': FieldValue.serverTimestamp(),
//                         'senderId': widget.currentUserId,
//                       });
//                       _messageController.clear();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// class Messenger extends StatefulWidget {
//   final String currentUserId;
//   final String chatUserId;
//
//   Messenger({required this.currentUserId, required this.chatUserId});
//
//   @override
//   _MessengerState createState() => _MessengerState();
// }
//
// class _MessengerState extends State<Messenger> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat with Admin'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _firestore
//                   .collection('messages')
//                   .doc(widget.currentUserId)
//                   .collection(widget.chatUserId)
//                   .orderBy('timestamp')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return CircularProgressIndicator();
//                 }
//                 final messages = snapshot.data!.docs;
//                 List<Widget> messageWidgets = [];
//                 for (var message in messages) {
//                   final messageText = message['text'];
//                   final messageSender = message['senderId'];
//                   final messageWidget = MessageWidget(
//                     text: messageText,
//                     isMe: messageSender == widget.currentUserId,
//                   );
//                   messageWidgets.add(messageWidget);
//                 }
//                 return ListView(
//                   children: messageWidgets,
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(hintText: 'Enter your message'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () async {
//                     String messageText = _messageController.text.trim();
//                     if (messageText.isNotEmpty) {
//                       await _firestore
//                           .collection('messages')
//                           .doc(widget.currentUserId)
//                           .collection(widget.chatUserId)
//                           .add({
//                         'text': messageText,
//                         'timestamp': FieldValue.serverTimestamp(),
//                         'senderId': widget.currentUserId,
//                       });
//                       _messageController.clear();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class MessageWidget extends StatelessWidget {
  final String text;
  final bool isMe;

  MessageWidget({required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}


// class ChatScreen extends StatefulWidget {
//   final String currentUserId;
//   ChatScreen({required this.currentUserId});
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   // final String currentUserId = 'your_current_user_id';
//   final String adminUserId = 'CwXqp7gKtPWUmi9VNJXO0GX7S0G2';
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat with Admin'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _firestore
//                   .collection('chats')
//                   .doc(currentUserId)
//                   .collection(adminUserId)
//                   .orderBy('timestamp')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return CircularProgressIndicator();
//                 }
//                 final messages = snapshot.data!.docs;
//                 List<Widget> messageWidgets = [];
//                 for (var message in messages) {
//                   final messageText = message['text'];
//                   final messageSender = message['senderId'];
//                   final messageWidget = MessageWidget(
//                     text: messageText,
//                     isMe: messageSender == currentUserId,
//                   );
//                   messageWidgets.add(messageWidget);
//                 }
//                 return ListView(
//                   children: messageWidgets,
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(hintText: 'Enter your message'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () async {
//                     String messageText = _messageController.text.trim();
//                     if (messageText.isNotEmpty) {
//                       await _firestore
//                           .collection('chats')
//                           .doc(currentUserId)
//                           .collection(adminUserId)
//                           .add({
//                         'text': messageText,
//                         'timestamp': FieldValue.serverTimestamp(),
//                         'senderId': currentUserId,
//                       });
//                       _messageController.clear();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class MessageWidget extends StatelessWidget {
//   final String text;
//   final bool isMe;
//
//   MessageWidget({required this.text, required this.isMe});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Align(
//         alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//         child: Container(
//           decoration: BoxDecoration(
//             color: isMe ? Colors.blue : Colors.grey,
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           padding: EdgeInsets.all(8.0),
//           child: Text(
//             text,
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Messenger extends StatefulWidget {
//   final String currentUserId;
//   final String chatUserId = "CwXqp7gKtPWUmi9VNJXO0GX7S0G2";
//
//   // ChatScreen({required this.currentUserId, required this.chatUserId});
//   Messenger({required this.currentUserId, required chatUserId});
//
//   @override
//   _MessengerState createState() => _MessengerState();
// }
//
// class _MessengerState extends State<Messenger> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   CollectionReference? _chatCollection;
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   List<Map<String, dynamic>> messages = [];
//   TextEditingController messageController = TextEditingController();
//
//   @override
//   // void initState() {
//   //   super.initState();
//   //   _chatCollection = _firestore.collection('chats_${widget.currentUserId}_${widget.chatUserId}');
//   //   _subscribeToChatMessages();
//   // }
//   // void initState() {
//   //   super.initState();
//   //   // Store all chat data in a collection named "chats"
//   //   _chatCollection = _firestore.collection('chats').doc(widget.currentUserId).collection('chats_${widget.chatUserId}');
//   //
//   //   _subscribeToChatMessages();
//   // }
//   void initState() {
//     super.initState();
//
//     // Create a collection reference for the chat room based on currentUserId
//     _chatCollection = _firestore.collection('chats').doc(widget.currentUserId).collection('messages');
//
//     _subscribeToChatMessages();
//   }
//
//
//   void _subscribeToChatMessages() {
//     _chatCollection!.orderBy('timestamp').snapshots().listen((snapshot) {
//       setState(() {
//         messages = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//       });
//     });
//   }
//
//   void _sendMessage() {
//     String message = messageController.text;
//     if (message.isNotEmpty) {
//       _chatCollection!.add({
//         'senderId': widget.currentUserId,
//         'text': message,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//       messageController.clear();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat with User'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[index];
//                 return ListTile(
//                   title: Text(message['text'] as String),
//                   subtitle: Text(message['senderId'] as String),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message...',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
