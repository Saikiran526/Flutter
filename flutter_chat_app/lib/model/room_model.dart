import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RoomModel{
  String? roomId;
  String? senderId;
  String? peerId;
  Timestamp? timestamp;
  String? lastMessage;
  List participantsList;
  Timestamp? groupCreatedAt;

  RoomModel({
    this.roomId,
    this.senderId,
    this.peerId,
    this.timestamp,
    this.lastMessage,
    this.participantsList= const [],
    this.groupCreatedAt,
  });

  factory RoomModel.fromMap(Map map){
    return RoomModel(
      groupCreatedAt: map['groupCreatedAt'],
      roomId: map['roomId'],
      senderId: map['senderId'],
      peerId: map['peerId'],
      timestamp: map['timestamp'],
      lastMessage: map['lastMessage'],
      participantsList: map['participantsList'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'roomId':roomId,
      'participantsList':participantsList,
      'lastMessage':"",
      'timestamp': FieldValue.serverTimestamp(),
      'senderId':FirebaseAuth.instance.currentUser?.uid,
      'peerId':peerId,
    };
  }
}