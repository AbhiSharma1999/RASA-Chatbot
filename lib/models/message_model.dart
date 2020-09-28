import 'package:flutter/material.dart';

class Message{
  final String text;
  final String time;
  final bool isMe;

  Message({@required this.text,@required this.time,@required this.isMe});
}