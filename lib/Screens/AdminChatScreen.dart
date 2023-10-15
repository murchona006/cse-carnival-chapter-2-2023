import 'package:auth_test/Screens/Messenger.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPanel extends StatefulWidget {
  final String adminUserId;

  AdminPanel({required this.adminUserId});

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('chats').snapshots(), // Replace 'users' with the name of your user collection in Firestore
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          final users = snapshot.data!.docs;
          List<Widget> userWidgets = [];

          for (var user in users) {
            final userId = user.id;
           // final username = user.data()['username']; // Replace 'username' with the field that stores the username in your user documents
            final username = (user.data() as Map<String, dynamic>)?['messages'] ?? 'Unknown';

            userWidgets.add(
              ListTile(
                title: Text(username),
                subtitle: Text(userId),
                onTap: () {
                  // Navigate to the chat screen or perform other actions when a user is selected
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Messenger(
                        currentUserId: widget.adminUserId,
                        chatUserId: userId,
                        adminUserId: widget.adminUserId,
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return ListView(
            children: userWidgets,
          );
        },
      ),
    );
  }
}

// class AdminChatScreen extends StatefulWidget {
//   final String adminUserId;
//   final String userToChatWithId;
//
//   AdminChatScreen({required this.adminUserId, required this.userToChatWithId});
//
//   @override
//   _AdminChatScreenState createState() => _AdminChatScreenState();
// }
//
// class _AdminChatScreenState extends State<AdminChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat with User'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _firestore
//                   .collection('messages')
//                   .doc(widget.adminUserId)
//                   .collection(widget.userToChatWithId)
//                   .orderBy('timestamp', descending: true)
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
//                   final isMe = messageSender == widget.adminUserId;
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
//                           .doc(widget.adminUserId)
//                           .collection(widget.userToChatWithId)
//                           .add({
//                         'text': messageText,
//                         'timestamp': FieldValue.serverTimestamp(),
//                         'senderId': widget.adminUserId,
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
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: Align(
//         alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//         child: Container(
//           padding: EdgeInsets.all(12.0),
//           decoration: BoxDecoration(
//             color: isMe ? Colors.blue : Colors.grey,
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Text(
//             text,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AdminChatListScreen extends StatefulWidget {
//   AdminChatListScreen();
//
//   @override
//   _AdminChatListScreenState createState() => _AdminChatListScreenState();
// }
//
// class _AdminChatListScreenState extends State<AdminChatListScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Chat List'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestore.collection('messages').snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }
//
//           final usersWithMessages = snapshot.data!.docs;
//           List<String> userIds = [];
//
//           for (var userMessage in usersWithMessages) {
//             // Get the user ID (document ID) and add it to the list.
//             userIds.add(userMessage.id);
//           }
//
//           return ListView.builder(
//             itemCount: userIds.length,
//             itemBuilder: (context, index) {
//               final userId = userIds[index];
//
//               return ListTile(
//                 title: Text(userId),
//                 onTap: () {
//                   // You can add your navigation logic here when a user is tapped.
//                   // For example, navigate to the user's chat screen.
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class ChatScreen extends StatefulWidget {
//   final String currentUserId;
//   final String chatUserId;
//
//   ChatScreen({required this.currentUserId, required this.chatUserId});
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//   // Chat screen implementation goes here.
// }
//
//



// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ChatList extends StatefulWidget {
//   final String currentUserId;
//
//   ChatList({required this.currentUserId});
//
//   @override
//   _ChatListState createState() => _ChatListState();
// }
//
// class _ChatListState extends State<ChatList> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   late CollectionReference _chatCollection;
//
//   @override
//   void initState() {
//     super.initState();
//     _chatCollection = _firestore.collection('chats').doc(widget.currentUserId).collection('messages');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat List'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _chatCollection.snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }
//
//           final chatRooms = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: chatRooms.length,
//             itemBuilder: (context, index) {
//               final chatRoom = chatRooms[index];
//               final chatData = chatRoom.data() as Map<String, dynamic>;
//               final otherUserId = chatData['otherUserId'];
//
//               return ListTile(
//                 title: Text(otherUserId),
//                 onTap: () {
//                   // Handle tapping on a chat room, e.g., navigate to the chat screen
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class AdminPanelScreen extends StatefulWidget {
//   final String currentUserId;
//
//   AdminPanelScreen({required this.currentUserId});
//
//   @override
//   _AdminPanelScreenState createState() => _AdminPanelScreenState();
// }
//
// class _AdminPanelScreenState extends State<AdminPanelScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   late CollectionReference _chatCollection;
//
//   @override
//   void initState() {
//     super.initState();
//     // _chatCollection = _firestore.collection('chats').doc(widget.currentUserId).collection('messages');
//     _chatCollection = _firestore.collection('chats');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Panel'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _chatCollection.snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }
//
//           final chatRooms = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: chatRooms.length,
//             itemBuilder: (context, index) {
//               final chatRoom = chatRooms[index];
//               final chatData = chatRoom.data() as Map<String, dynamic>;
//               final otherUserId = chatData['otherUserId'];
//
//               return ListTile(
//                 title: Text(otherUserId),
//                 onTap: () {
//                   // Handle tapping on a chat room in the admin panel
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }



//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AdminPanelScreen extends StatefulWidget {
//   final String currentUserId;
//
//   AdminPanelScreen({required this.currentUserId});
//
//   @override
//   _AdminPanelScreenState createState() => _AdminPanelScreenState();
// }
//
// class _AdminPanelScreenState extends State<AdminPanelScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Panel'),
//       ),
//       body:StreamBuilder<QuerySnapshot>(
//         stream: _firestore.collection('chats').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           }
//
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
//
//           if (!snapshot.hasData) {
//             return Text('No chat rooms found.');
//           }
//
//           List<QueryDocumentSnapshot> chatDocs = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: chatDocs.length,
//             itemBuilder: (context, index) {
//               final chat = chatDocs[index];
//               final userId = chat['senderId'];
//
//               return ListTile(
//                 title: Text(userId),
//                 onTap: () {
//                   // Handle tapping on a chat room (e.g., navigate to the chat screen)
//                 },
//               );
//             },
//           );
//         },
//       ),
//
//       // body: StreamBuilder<QuerySnapshot>(
//       //   stream: _firestore.collection('chats').snapshots(),
//       //   builder: (context, snapshot) {
//       //     if (!snapshot.hasData) {
//       //       return CircularProgressIndicator();
//       //     }
//       //
//       //     List<QueryDocumentSnapshot> chatDocs = snapshot.data!.docs;
//       //
//       //     return ListView.builder(
//       //       itemCount: chatDocs.length,
//       //       itemBuilder: (context, index) {
//       //         final chat = chatDocs[index];
//       //         final userId = chat['senderId'];
//       //
//       //         return ListTile(
//       //           title: Text(userId),
//       //           onTap: () {
//       //             // Navigator.push(
//       //             //   context,
//       //             //   MaterialPageRoute(
//       //             //     builder: (context) => UserChatScreen(
//       //             //       currentAdminId: widget.currentAdminId,
//       //             //       chatUserId: userId,
//       //             //     ),
//       //             //   ),
//       //             // );
//       //           },
//       //         );
//       //       },
//       //     );
//       //   },
//       // ),
//     );
//   }
// }












//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AdminMessage extends StatefulWidget {
//   final String currentUserId;
//
//   AdminMessage({required this.currentUserId, required String adminUserId});
//
//   @override
//   _AdminMessageState createState() => _AdminMessageState();
// }
//
// class _AdminMessageState extends State<AdminMessage> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List<Map<String, dynamic>> messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchAdminMessages();
//   }
//
//   void _fetchAdminMessages() {
//     // Query the "chats" collection for messages sent to the admin
//     Query chatQuery = _firestore.collection('chats');
//
//     chatQuery
//         .where('receiverId', isEqualTo: widget.currentUserId)
//         .orderBy('timestamp')
//         .snapshots()
//         .listen((snapshot) {
//       setState(() {
//         messages = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//       });
//     });
//   }
//
//   void _openChatbox(String userId) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => Chatbox(
//           adminUserId: widget.currentUserId,
//           currentUserId: userId,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Messages'),
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
//                   onTap: () => _openChatbox(message['senderId'] as String),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Chatbox extends StatefulWidget {
//   final String adminUserId;
//   final String currentUserId;

//   Chatbox({required this.adminUserId, required this.currentUserId});
//
// @override
// _ChatboxState createState() => _ChatboxState();
// }
//
// class _ChatboxState extends State<Chatbox> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List<Map<String, dynamic>> messages = [];
//   TextEditingController messageController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchChatMessages();
//   }

  // void _fetchChatMessages() {
  //   // Query the "chats" collection for messages from the admin to the user
  //   Query chatQueryAdminToUser = _firestore.collection('chats');
  //   chatQueryAdminToUser
  //       .where('senderId', isEqualTo: widget.adminUserId)
  //       .where('receiverId', isEqualTo: widget.currentUserId)
  //       .orderBy('timestamp')
  //       .snapshots()
  //       .listen((snapshot) {
  //     setState(() {
  //       messages = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  //     });
  //   });

  // Query the "chats" collection for messages from the user to the admin
  //   Query chatQueryUserToAdmin = _firestore.collection('chats');
  //   chatQueryUserToAdmin
  //       .where('senderId', isEqualTo: widget.currentUserId)
  //       .where('receiverId', isEqualTo: widget.adminUserId)
  //       .orderBy('timestamp')
  //       .snapshots()
  //       .listen((snapshot) {
  //     setState(() {
  //       messages.addAll(snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  //       // You can sort the merged messages by timestamp here if needed.
  //     });
  //   });
  // }
  //
  // void _sendMessage() {
  //   String message = messageController.text;
  //   if (message.isNotEmpty) {
  //     _firestore.collection('chats').add({
  //       'senderId': widget.adminUserId,
  //       'receiverId': widget.currentUserId,
  //       'text': message,
  //       'timestamp': FieldValue.serverTimestamp(),
  //     });
  //     messageController.clear();
  //   }
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Chat with User'),
  //     ),
  //     body: Column(
  //       children: [
  //         Expanded(
  //           child: ListView.builder(
  //             itemCount: messages.length,
  //             itemBuilder: (context, index) {
  //               final message = messages[index];
  //               return ListTile(
  //                 title: Text(message['text'] as String),
  //                 subtitle: Text(message['senderId'] == widget.currentUserId ? 'You' : 'Admin'),
  //               );
  //             },
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: TextField(
  //                   controller: messageController,
  //                   decoration: InputDecoration(
  //                     hintText: 'Type a message...',
  //                   ),
  //                 ),
  //               ),
  //               IconButton(
  //                 icon: Icon(Icons.send),
  //                 onPressed: _sendMessage,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
//}



//
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ChatListWidget extends StatefulWidget {
//   final String currentUserId;
//
//   ChatListWidget({required this.currentUserId});
//
//   @override
//   _ChatListWidgetState createState() => _ChatListWidgetState();
// }
//
// class _ChatListWidgetState extends State<ChatListWidget> {
//   late CollectionReference _chatsCollection;
//
//   @override
//   void initState() {
//     super.initState();
//     _chatsCollection = FirebaseFirestore.instance.collection('chats');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _chatsCollection.snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }
//
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator(); // Display a loading indicator while data is fetched
//         }
//
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Text('No chats available.'); // Display a message if no chats are found
//         }
//
//         return ListView(
//           children: snapshot.data!.docs.map((DocumentSnapshot doc) {
//             // Access the user ID from each document in the "chats" collection
//             String userId = doc.id;
//
//             return ListTile(
//               title: Text(userId),
//               onTap: () {
//                 // You can navigate to a chat room or do something else when the user taps on a list item
//               },
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// void main() => runApp(MyApp());
//
// class ChatMessage {
//   final String text;
//   final String sender;
//
//   ChatMessage({
//     required this.text,
//     required this.sender,
//   });
//
//   factory ChatMessage.fromMap(Map<String, dynamic> map) {
//     return ChatMessage(
//       text: map['text'] ?? '',
//       sender: map['sender'] ?? '',
//     );
//   }
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Chat Messages')),
//         body: ChatMessagesScreen(),
//       ),
//     );
//   }
// }
//
// class ChatMessagesScreen extends StatefulWidget {
//   @override
//   _ChatMessagesScreenState createState() => _ChatMessagesScreenState();
// }
//
// class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
//   final _firestore = FirebaseFirestore.instance;
//   final String currentUserId = 'C9N4KJ6uZ7PL07m1VqhGWZpnjm42'; // Replace with the actual user ID
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<ChatMessage>>(
//       future: fetchChatMessages(currentUserId),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(child: Text('No chat messages available.'));
//         } else {
//           final chatMessages = snapshot.data;
//           return ListView.builder(
//             itemCount: chatMessages!.length,
//             itemBuilder: (context, index) {
//               final message = chatMessages[index];
//               return ListTile(
//                 title: Text(message.text),
//                 subtitle: Text(message.sender),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
//
//   Future<List<ChatMessage>> fetchChatMessages(String currentUserId) async {
//     try {
//       final chatCollection = _firestore.collection('chats').doc(currentUserId).collection('messages');
//       final querySnapshot = await chatCollection.get();
//
//       if (querySnapshot.docs.isNotEmpty) {
//         final chatMessages = querySnapshot.docs
//             .map((doc) => ChatMessage.fromMap(doc.data()))
//             .toList();
//         return chatMessages;
//       }
//     } catch (e) {
//       print('Error fetching chat data: $e');
//     }
//     return []; // Return an empty list in case of an error or no data found.
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// class ChatDocumentIdsScreen extends StatelessWidget {
//   final _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<String>>(
//       future: fetchChatDocumentIds(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(child: Text('No chat document IDs available.'));
//         } else {
//           final documentIds = snapshot.data;
//           return ListView.builder(
//             itemCount: documentIds!.length,
//             itemBuilder: (context, index) {
//               final documentId = documentIds[index];
//               return ListTile(
//                 title: Text(documentId),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
//
//   Future<List<String>> fetchChatDocumentIds() async {
//     try {
//       final chatCollection = _firestore.collection('chats');
//       final querySnapshot = await chatCollection.get();
//
//       if (querySnapshot.docs.isNotEmpty) {
//         final documentIds = querySnapshot.docs.map((doc) => doc.id).toList();
//         return documentIds;
//       }
//     } catch (e) {
//       print('Error fetching chat document IDs: $e');
//     }
//     return []; // Return an empty list in case of an error or no data found.
//   }
// }

// import 'package:auth_test/Screens/Messenger.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AdminScreen extends StatefulWidget {
//   final String currentAdminId; // Admin's user ID
//
//   AdminScreen({required this.currentAdminId});
//
//   @override
//   _AdminScreenState createState() => _AdminScreenState();
// }
//
// class _AdminScreenState extends State<AdminScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Chat'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestore.collection('chats').doc(widget.currentAdminId).collection('chats').orderBy('timestamp').snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }
//
//           List<QueryDocumentSnapshot> chatDocs = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: chatDocs.length,
//             itemBuilder: (context, index) {
//               final chat = chatDocs[index];
//               final userId = chat['senderId'];
//
//               return ListTile(
//                 title: Text(userId),
//                 onTap: () {
//                   // When the admin taps on a user ID, open the chat screen
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => Messenger(
//                         currentUserId: widget.currentAdminId,
//                         chatUserId: userId, // Pass the user's ID to the chat screen
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// class ChatMessage {
//   final String text;
//   final String sender;
//
//   ChatMessage({
//     required this.text,
//     required this.sender,
//   });
//
//   factory ChatMessage.fromMap(Map<String, dynamic> map, {required senderUserId}) {
//     return ChatMessage(
//       text: map['text'] ?? '',
//       sender: map['sender'] ?? '',
//     );
//   }
// }
//
//
// class ChatMessagesScreen extends StatefulWidget {
//   @override
//   _ChatMessagesScreenState createState() => _ChatMessagesScreenState();
// }
//
// class _ChatMessagesScreenState extends State<ChatMessagesScreen> {
//   final _firestore = FirebaseFirestore.instance;
//   final String currentUserId = 'C9N4KJ6uZ7PL07m1VqhGWZpnjm42'; // Replace with the actual user ID
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<ChatMessage>>(
//       future: fetchChatMessages(currentUserId),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(child: Text('No chat messages available.'));
//         } else {
//           final chatMessages = snapshot.data;
//           return ListView.builder(
//             itemCount: chatMessages!.length,
//             itemBuilder: (context, index) {
//               final message = chatMessages[index];
//               return ListTile(
//                 title: Text(message.text),
//                 subtitle: Text(message.sender),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
//
//   // Future<List<ChatMessage>> fetchChatMessages(String currentUserId) async {
//   //   try {
//   //     final chatCollection = _firestore.collection('chats').doc(currentUserId).collection('messages');
//   //     final querySnapshot = await chatCollection.get();
//   //
//   //     if (querySnapshot.docs.isNotEmpty) {
//   //       final chatMessages = querySnapshot.docs
//   //           .map((doc) => ChatMessage.fromMap(doc.data()))
//   //           .toList();
//   //       return chatMessages;
//   //     }
//   //   } catch (e) {
//   //     print('Error fetching chat data: $e');
//   //   }
//   //   return []; // Return an empty list in case of an error or no data found.
//   // }
//
//
//   Future<List<ChatMessage>> fetchChatMessages(String currentUserId) async {
//     try {
//       final chatCollection = _firestore.collection('chats').doc(currentUserId).collection('messages');
//       final querySnapshot = await chatCollection.get();
//
//       if (querySnapshot.docs.isNotEmpty) {
//         final chatMessages = querySnapshot.docs.map((doc) {
//           // Extract the sender's user ID from the document data
//           final senderUserId = doc.data()['currentUserId'];
//           // Create a ChatMessage object with the sender user ID
//           return ChatMessage.fromMap(doc.data(), senderUserId: senderUserId);
//         }).toList();
//         return chatMessages;
//       }
//     } catch (e) {
//       print('Error fetching chat data: $e');
//     }
//     return []; // Return an empty list in case of an error or no data found.
//   }
//
// }
