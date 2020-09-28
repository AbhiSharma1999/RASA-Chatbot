class Sent{
  final String sender, message;

  Sent(this.sender, this.message);

  Map<String,dynamic> toJson() =>
  {
    "sender":sender,
    "message":message
  };

}