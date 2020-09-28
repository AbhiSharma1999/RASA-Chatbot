class ReplyArray {
  final List<Reply> replies;

  ReplyArray({
    this.replies,
});

  factory ReplyArray.fromJson(List<dynamic> parsedJson) {

    List<Reply> photos = new List<Reply>();
    photos = parsedJson.map((i)=>Reply.fromJson(i)).toList();

    return new ReplyArray(
      replies: photos
    );
  }
}

class Reply{
  final String recipientId;
  final String text;

  Reply({
    this.recipientId,
    this.text
}) ;

  factory Reply.fromJson(Map<String, dynamic> json){
    return new Reply(
      recipientId: json['recipient_id'],
      text: json['text']
    );
  }

}