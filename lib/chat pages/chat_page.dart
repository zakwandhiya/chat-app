import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_page_composer.dart';
import '../model/messageView.dart';
import '../model/message.dart';
import '../model/user.dart';
import 'dart:async';

class ChatPage extends StatefulWidget {
  ChatPage(this.firebaseUser , this.user);

  FirebaseUser firebaseUser;
  User user;

  @override
  _ChatPageState createState() => new _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  
  List<Map<String, dynamic>> _messagesView = [];
  Map<dynamic, dynamic> _users ;
  
  DatabaseReference messageRef;
  
  // DatabaseReference userRef;


  void initState() {

    super.initState();
    print('============================== starting chat page');
    
    final FirebaseDatabase database = FirebaseDatabase.instance;
    messageRef= database.reference().child('messages');
    
    database.reference().child('user').once().then((onValue){
      _users = onValue.value;
      messageRef.onChildAdded.listen(_addMessageFromFirebase);
    });

  }

  
  _addMessageFromFirebase(Event event){
    Message tmpMessage = Message.fromSnapshot(event.snapshot);
    Map<String, dynamic> tmpMessageView ;
    User tmpUser = User.fromMap(tmpMessage.user_id, _users[tmpMessage.user_id]);
    if(tmpMessage.user_id != widget.user.user_id ){
      tmpMessageView ={
        'message' : tmpMessage,
        'user' : tmpUser,
        'isCurrentUser' : false,
        'time' : tmpMessage.getTimeCreated()
      };
      setState(() {
        _messagesView.insert(0,tmpMessageView);
              
      });
    }else if(!_messageAlreadyAdded(tmpMessage.key)){
      // User tmpUser = User.fromMap(tmpMessage.user_id, _users[tmpMessage.user_id]);
      tmpMessageView = {
        'message' : tmpMessage,
        'user' : tmpUser,
        'isCurrentUser' : true,
        'time' : tmpMessage.getTimeCreated()
      };
      setState(() {
        _messagesView.insert(0,tmpMessageView);
      });
    }
  }

  bool _messageAlreadyAdded(String messageId){
    bool status = false;
    for (var item in _messagesView) {
      if(item['message'].key == messageId || item['message'].key == 'from current user'){
        
        status = true;
        
      }
    }
    return status;
  }

  void _submitNewMessage(String input) {
    Message newMessage = Message('from current user' ,widget.firebaseUser.uid, input);
    Map<String, dynamic> newMessageView  = {
        'message' : newMessage,
        'user' : widget.user,
        'isCurrentUser' : true,
        'time' : ' . . . '
      };

    setState(() {
      _messagesView.insert(0, newMessageView);  
      // _messagesView.add(newMessageView)   ;
    });
    messageRef.push().set(newMessage.toJson()).then((onValue){
      setState(() {
        newMessageView['time'] = newMessage.getTimeCreated();
              
      });
      // MessageView.setTimeCreated(newMessageView , newMessage.getTimeCreated());
    });
  }

  signOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = (widget) => AppBar(
          elevation: 1.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title:
              new Text('HA HA HA', style: TextStyle(color: Colors.black54)),
          actions: <Widget>[
            IconButton(
              iconSize: 30.0,
              tooltip: 'multifunction button',
              color: Colors.black54,
              icon: Icon(Icons.more_vert),
              onPressed: () {
                signOut();
              },
            )
          ],
        );

    return new Scaffold(
      appBar: appBar(widget),
      body: Column(children: <Widget>[


//========================================chat page body=====================================================
//-----------------------------------------------------------------------------------------------------------

        new Flexible(
          child: new ListView.builder(    
            itemBuilder: (contex , index) => MessageView(_messagesView[index]),
            itemCount: _messagesView.length,
            padding: new EdgeInsets.all(6.0),
            reverse: true,
          )
        ),

//=======================================chat page input field================================================
//------------------------------------------------------------------------------------------------------------

        new Container(
          child: ChatInput(callBack: _submitNewMessage,),
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
        ),

      ]
      ),
    );
  }
}
