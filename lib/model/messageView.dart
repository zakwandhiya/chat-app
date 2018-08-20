import 'package:flutter/material.dart';
import './message.dart';
import './user.dart';
import '../shared widget/box_decoration.dart';
import 'dart:async';

class MessageView extends StatelessWidget {
  
  MessageView(Map<String , dynamic> messageView){
    this.user = messageView['user'];
    this.message = messageView['message'];
    this.isCurentUser = messageView['isCurrentUser'];
    this.time = messageView['time'];
    print('======================='+message.text);
  }
      
  bool isCurentUser;
  Message message;
  User user;
  
  String time;

  // Function setTime;
  
  Row _buildComposer() {

    Color color = isCurentUser ? Colors.white : Colors.grey[600];
    bool sending =time == ' . . . ';

    RoundedRectangleBorder roundedRectangleBorder = new RoundedRectangleBorder(
      borderRadius: new BorderRadius.only(
          topLeft: !isCurentUser? Radius.circular(0.0) : Radius.circular(12.0),
          topRight: isCurentUser? Radius.circular(0.0) : Radius.circular(12.0),
          bottomLeft: Radius.circular(12.0),
          bottomRight: Radius.circular(12.0)),
      side: BorderSide.none,
    );

    EdgeInsets paddingForCreatedTime = 
    EdgeInsets.only(
          right: !isCurentUser ? 20.0 : 0.0, 
          left: isCurentUser ? 40.0 : 0.0, 
          bottom: 6.0
    );

    ConstrainedBox sendingTimeText = ConstrainedBox(
      constraints: new BoxConstraints(maxWidth: 80.0, minWidth: 24.0),
      child: Container(
        padding: paddingForCreatedTime,
        child: Text(time,
          maxLines: 1,
          style:TextStyle(color: Colors.grey, fontSize: sending ? 20.0 : 12.5)),
      ),
    );

    return Row(
      mainAxisAlignment: isCurentUser? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        isCurentUser ? sendingTimeText : Container(),
        Flexible(
          child: Card(
            color: Colors.white,
            elevation: 12.0,
            shape: roundedRectangleBorder,
            child: Container(
              decoration: isCurentUser ? boxDecoration : BoxDecoration(),
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: Text(message.text,
                  style: TextStyle(color: color, fontSize: 17.0)),
            ),
          ),
        ),
        !isCurentUser ? sendingTimeText : Container(),
      ],
    );
  }

//==================================view current user message=======================================
//--------------------------------------------------------------------------------------------------

  Expanded currentUserMessage() {


    return Expanded(
      child: _buildComposer()
    );
  }

//==================================view current user message=======================================
//--------------------------------------------------------------------------------------------------

  Expanded notCurrentUserMessasge(BuildContext ctx) {

    return new Expanded(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(user.user_name,
              style: TextStyle(color: Colors.blueGrey, fontSize: 13.5)),

          _buildComposer(),
        ],
      ),
    );
  }

  Widget build(BuildContext ctx) {
    print('==============================='+time);
    return new Container(
      child: new Container(
        padding: EdgeInsets.only(right: 16.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

//==================================== circle avatar========================================================
//----------------------------------------------------------------------------------------------------------

            !isCurentUser
                ? Container(
                    padding: new EdgeInsets.only(left: 6.0, right: 4.0),
                    child: new CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/chat-app4.appspot.com/o/profile_photo%2Ftzuyu.PNG?alt=media&token=f01af3b6-0e79-44a1-b2f2-d1874e16cd45"),
                      radius: 20.0,
                    ),
                  )
                : Container(),

//===================================message content========================================================
//----------------------------------------------------------------------------------------------------------

            !isCurentUser ? notCurrentUserMessasge(ctx) : currentUserMessage()
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import './message.dart';
// import './user.dart';
// import '../shared widget/box_decoration.dart';
// import 'dart:async';

// class MessageView extends StatefulWidget {
  
//   MessageView( this.message, this.user, this.isCurentUser , this.time ,{Key key})
//       : super(key: key);
      
//   final bool isCurentUser;
//   final Message message;
//   final User user;
  
//   String time;

//   Function setTime;

//   static bool setTimeCreated(MessageView messageView , time){
//     messageView.setTime(time);
//     return true;
//   }

//   @override
//   State<StatefulWidget> createState() {
//     return _MessageViewState(time);
//   }
  
// }

// class _MessageViewState extends State<MessageView> {

//   _MessageViewState(this.time);
//   String time;

//   initState() {
//     widget.setTime = updateMessageTime;
  
//     super.initState();
//   }

//   updateMessageTime(String newTime){
//     setState(() {
//       time = newTime;
//     });
//   }
  
//   Row _buildComposer() {

//     Color color = widget.isCurentUser ? Colors.white : Colors.grey[600];
//     bool sending = widget.time == ' . . . ';

//     RoundedRectangleBorder roundedRectangleBorder = new RoundedRectangleBorder(
//       borderRadius: new BorderRadius.only(
//           topLeft: !widget.isCurentUser? Radius.circular(0.0) : Radius.circular(12.0),
//           topRight: widget.isCurentUser? Radius.circular(0.0) : Radius.circular(12.0),
//           bottomLeft: Radius.circular(12.0),
//           bottomRight: Radius.circular(12.0)),
//       side: BorderSide.none,
//     );

//     EdgeInsets paddingForCreatedTime = 
//     EdgeInsets.only(
//           right: !widget.isCurentUser ? 20.0 : 0.0, 
//           left: widget.isCurentUser ? 40.0 : 0.0, 
//           bottom: 6.0
//     );

//     ConstrainedBox sendingTimeText = ConstrainedBox(
//       constraints: new BoxConstraints(maxWidth: 80.0, minWidth: 24.0),
//       child: Container(
//         padding: paddingForCreatedTime,
//         child: Text(widget.time,
//           maxLines: 1,
//           style:TextStyle(color: Colors.grey, fontSize: sending ? 20.0 : 12.5)),
//       ),
//     );

//     return Row(
//       mainAxisAlignment: widget.isCurentUser? MainAxisAlignment.end : MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: <Widget>[
//         widget.isCurentUser ? sendingTimeText : Container(),
//         Flexible(
//           child: Card(
//             color: Colors.white,
//             elevation: 12.0,
//             shape: roundedRectangleBorder,
//             child: Container(
//               decoration: widget.isCurentUser ? boxDecoration : BoxDecoration(),
//               padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
//               child: Text(widget.message.text,
//                   style: TextStyle(color: color, fontSize: 17.0)),
//             ),
//           ),
//         ),
//         !widget.isCurentUser ? sendingTimeText : Container(),
//       ],
//     );
//   }

// //==================================view current user message=======================================
// //--------------------------------------------------------------------------------------------------

//   Expanded currentUserMessage() {


//     return Expanded(
//       child: _buildComposer()
//     );
//   }

// //==================================view current user message=======================================
// //--------------------------------------------------------------------------------------------------

//   Expanded notCurrentUserMessasge(BuildContext ctx) {

//     return new Expanded(
//       child: new Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(widget.user.user_name,
//               style: TextStyle(color: Colors.blueGrey, fontSize: 13.5)),

//           _buildComposer(),
//         ],
//       ),
//     );
//   }

//   Widget build(BuildContext ctx) {
//     print('==============================='+time);
//     return new Container(
//       child: new Container(
//         padding: EdgeInsets.only(right: 16.0),
//         margin: const EdgeInsets.symmetric(vertical: 10.0),
//         child: new Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[

// //==================================== circle avatar========================================================
// //----------------------------------------------------------------------------------------------------------

//             !widget.isCurentUser
//                 ? Container(
//                     padding: new EdgeInsets.only(left: 6.0, right: 4.0),
//                     child: new CircleAvatar(
//                       backgroundImage: NetworkImage(
//                           "https://firebasestorage.googleapis.com/v0/b/chat-app4.appspot.com/o/profile_photo%2Ftzuyu.PNG?alt=media&token=f01af3b6-0e79-44a1-b2f2-d1874e16cd45"),
//                       radius: 20.0,
//                     ),
//                   )
//                 : Container(),

// //===================================message content========================================================
// //----------------------------------------------------------------------------------------------------------

//             !widget.isCurentUser ? notCurrentUserMessasge(ctx) : currentUserMessage()
//           ],
//         ),
//       ),
//     );
//   }
// }
