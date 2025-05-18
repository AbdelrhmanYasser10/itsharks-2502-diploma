import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel{
  late String senderId;
  late String recieverId;
  late String content;
  String? media;
  late Timestamp date;

  MessageModel({
    required this.content,
    required this.date,
    required this.senderId,
     this.media,
    required this.recieverId,
});
  MessageModel.fromJson(Map<String,dynamic> json){
    senderId = json["senderId"];
    recieverId = json["recieverId"];
    content = json["content"];
    media = json["media"];
    date = json["date"];
  }

  Map<String ,dynamic> toJson()=>{
    "senderId":senderId,
    "recieverId":recieverId,
    "content":content,
    "media":media,
    "date":date
  };


}