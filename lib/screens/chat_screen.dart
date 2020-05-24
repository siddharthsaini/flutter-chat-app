import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Vartalapp/constants.dart';

FirebaseUser currentUser;
final _firestore = Firestore.instance;

class ChatScreen extends StatefulWidget {
  static const id = 'chatscreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  String message;
  final _auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    createNewUser();
  }

  createNewUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        currentUser = user;
        print(currentUser.uid);
      }
    } catch (e) {
      print(e);
    }
  }

  // void messageStream() async {
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapshot.documents) {
  //       print(message.data);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "LOGOUT",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              _auth.signOut();
              Navigator.pop(context);
              // messageStream();
            },
          ),
        ],
        title: Text('Chat Screen'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'text': message,
                        'sender': currentUser.email,
                        'time': DateTime.now(), //added this
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .orderBy('time', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = snapshot.data.documents
            .reversed; //async snapshot // contains a query snapshot from firebase which contains a list of document snapshots
        List<MessageBubble> messageWidgets = [];

        for (var message in messages) {
          final messageText = message.data['text']; // document snapshot
          final senderText = message.data['sender'];
          final messageTime = message.data['time'];

          messageWidgets.add(
            MessageBubble(
              sender: senderText,
              text: messageText,
              isMe: senderText == currentUser.email,
              time: messageTime,
            ),
          );
        }
        return Expanded(
          child: ListView(
            reverse: true,
            children:
                messageWidgets, // []removed since messageWidgets are a list of childer :/
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe, this.time});
  final String sender, text;
  final bool isMe;
  final Timestamp time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(fontSize: 10),
          ),
          SizedBox(
            height: 5,
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
            elevation: 5,
            color: isMe ? Colors.blueAccent[400] : Colors.blueAccent[100],
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: 5,
          // ),
          // Text(
          //   '$sender ${DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000)}',
          //   style: TextStyle(fontSize: 10),
          // ),
        ],
      ),
    );
  }
}
