import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageModel{
  String? message;
  var timestamp;
  String? senderId;
  MessageModel ({this.message,this.timestamp,this.senderId});

  factory MessageModel.fromMap(Map map){
    return MessageModel(
      message: map['message'],
      timestamp: map['timestamp'],
      senderId: map['senderId'],
    );
  }
  Map<String,dynamic> toMap(){
    return {
      'message':message,
      'timestamp':FieldValue.serverTimestamp(),
      'message':FirebaseAuth.instance.currentUser?.uid,

    };
  }
}