import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:rasa_chatbot/models/message_model.dart';
import 'package:rasa_chatbot/models/reply_model.dart';
import 'package:rasa_chatbot/models/sent_model.dart';


class ChatPage extends StatefulWidget {
  final Locale locale;

  ChatPage({@required this.locale});
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  List<Message> messages ;
  String url;

  @override
  void initState() { 
    url = widget.locale.languageCode.toString()=="en"?"https://2fcdf7ceaf31.ngrok.io/webhooks/rest/webhook":"https://b71b8d7c25ee.ngrok.io/webhooks/rest/webhook";
    var mess = widget.locale.languageCode.toString()=="en"?"Hey! How may I assist you?":"नमस्ते! मैं आपकी कैसे सहायता कर सकता हूँ?";
    messages =[ Message(text: mess, time: "123", isMe: false)] ;
    super.initState();
    
    
  }

  final controller = TextEditingController();

  _networkReply(String message,String sender,String time) async{
      Sent sentMessage = Sent(sender,message);
      var _jsonMessage = jsonEncode(sentMessage);
      print(_jsonMessage);
      var jsonResponse;
      var response =await http.post(url,body: _jsonMessage);
      var statusCode = response.statusCode;
      print(statusCode);
      if(statusCode==200){
        jsonResponse = json.decode(response.body);
        var parsedResponse = ReplyArray.fromJson(jsonResponse);
        var list = parsedResponse.replies;
        setState(() {
          messages.removeLast();
          messages.add(Message(text: list[0].text, time: time,isMe: false));
        });
      }
  }


  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
            right: 8.0,
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : EdgeInsets.only(
            left: 8.0,
              top: 8.0,
              bottom: 8.0,
              right: 80.0
            ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.70,
      decoration: BoxDecoration(
        color: isMe ? Color(0xff1e5f74) : Color(0xFF133b5c),
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.text,
            style: TextStyle(
              color: Color(0xffF5F7DC),
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    
    return msg;
  }
  
  @override
  Widget build(BuildContext context) {

    

      return Scaffold(
      backgroundColor: Color(0xff1d2d50),
      appBar: AppBar(
        backgroundColor: Color(0xff1d2d50),
        title: Text(
          "BITS-Queries",
          style: TextStyle(
            color: Color(0xffF5F7DC),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff0F0326),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: ListView.builder(
                    reverse: false,
                    padding: EdgeInsets.only(top: 15.0),
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      Message message = messages[index];
                      bool isMe = message.isMe;
                      if(message.text=="loading") return  SpinKitWave(color: Color(0xffF5F7DC), type: SpinKitWaveType.start,size: 25.0,);
                        
                      else
                      return _buildMessage(message, isMe);
                    },
                  ),
                ),
              ),
            ),
            // _buildMessageComposer()
            Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 90.0,
      color: Color(0xff1d2d50),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
                style: TextStyle(color: Color(0xffF5F7DC),),
              controller: controller,
              onSubmitted: (text) {
              messages.add(Message(text: text, time: "123", isMe: true));
              messages.add(Message(text: "loading", time: "123", isMe: true));
              controller.clear();
              _networkReply(text, "", "Time");
              setState(() {});
            },
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
                hintStyle: TextStyle(color: Color(0xff1e5f74),)
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color:Color(0xffF5F7DC) ,
            onPressed: () {
              messages.add(Message(
                text: controller.text,
                time: "Time",
                isMe: true
                ));
                messages.add(Message(text: "loading", time: "123", isMe: true));
                _networkReply(controller.text, "", "Time");
                controller.clear();
              setState(() {
                
              });
            
            }
          ),
        ],
      ),
    ),
          ],
        ),
      ),
    );
  }
    @override void dispose() {
    super.dispose();
    controller.dispose();
  }
}