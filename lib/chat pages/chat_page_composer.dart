import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  ChatInput({Key key, this.callBack}) : super(key: key);
  final Function callBack;

  @override
  _ChatInputState createState() => new _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  
  final TextEditingController _textController = new TextEditingController();

  bool _isWriting = false;

  void _submitMsg(String txt) {
    _textController.clear();
    setState(() {
      _isWriting = false;
    });

    widget.callBack(txt);
  }
  
  
  @override
  Widget build(BuildContext context) {

    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 1.0,
              color: Colors.grey,
            )
          ]
        ),
        child: new Row(
          children: <Widget>[


//=======================================text input field===================================================
//----------------------------------------------------------------------------------------------------------

            new Flexible(
              child: Container(
                padding: new EdgeInsets.only(left: 18.0, top: 16.0, bottom: 16.0),
                child: new ConstrainedBox(
                  constraints: new BoxConstraints(maxHeight: 76.0, minHeight: 24.0),
                  child: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: true,
                      child: new TextField(
                        controller: _textController,
                        onChanged: (String txt) {
                          setState(() {
                            _isWriting = txt.length > 0;
                          });
                        },
                        onSubmitted: _submitMsg,
                        keyboardType: TextInputType.multiline,
                        maxLines: null, 
                        style: TextStyle(color: Colors.grey[600], fontSize: 17.0),
                        decoration: new InputDecoration.collapsed(
                          hintText: 'Enter new message here...',
                          hintStyle: TextStyle(color: Colors.grey[600])
                        ),
                      ),
                    ),
                  ),
                )
              ),
            ),


//===================================button for submit message===============================================
//-----------------------------------------------------------------------------------------------------------

            new Container(
              margin:new EdgeInsets.only(bottom: 3.0, top: 3.0, right: 4.0),
              child: new IconButton(
                color: Colors.blueAccent[100],
                iconSize: 34.0,
                icon: new Icon(
                  Icons.label_outline,
                ),
                onPressed: _isWriting
                        ? () => _submitMsg(_textController.text)
                        : null,
              )
            ),
          ],
        ),
      ),
    );
  }
}
