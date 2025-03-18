import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/room_model.dart';
import 'package:flutter_chat_app/model/user_model.dart';

import 'individualsChat.dart';
class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {

  User? user=  FirebaseAuth.instance.currentUser;
  UserModel? userModel;

  Future<String> createRoomId(UserModel toChatUserModel) async {
    ///room id formate: smallId_largeId
    String roomId="";
    if(user!.uid.hashCode > toChatUserModel.uid.hashCode){
      roomId=toChatUserModel.uid!+"_"+user!.uid;
    }else if(user!.uid.hashCode < toChatUserModel.uid.hashCode){
      roomId=user!.uid +"_"+toChatUserModel.uid!;
    } else{
      roomId=user!.uid +"_"+toChatUserModel.uid!;
    }
    return roomId;
  }

  RoomModel roomModel=RoomModel();
  checkAndCreateNewRoom( UserModel toChatUserModel) async {
    String roomId= await createRoomId(toChatUserModel);
    CollectionReference roomCollectionReference=FirebaseFirestore.instance.collection("rooms");
    DocumentSnapshot documentSnapshot=await roomCollectionReference.doc(roomId).get();
    if(documentSnapshot.exists){
      roomModel=RoomModel.fromMap(documentSnapshot.data() as Map<String,dynamic>);
    } else {
      roomModel.peerId=toChatUserModel.uid;
      roomModel.participantsList=[];
      roomModel.participantsList.add(toChatUserModel.uid);
      roomModel.participantsList.add(user!.uid);
      await roomCollectionReference.doc(roomId).set(roomModel.toMap());
      if(roomModel!=null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>IndividualChat(userName:userModel!.name!)));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chats'),backgroundColor: Colors.blue,),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').get().asStream(),
          builder: (context,snapshot){
            if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }
            if(snapshot.hasData){
              if(snapshot.data?.docs.length==0){
                return Text('No user found');
              }
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context,index){
                    userModel=UserModel.fromMap(snapshot.data?.docs[index].data() as Map<String,dynamic>);
                    if(userModel!.uid==FirebaseAuth.instance.currentUser?.uid){
                      return Container();
                    }
                    return InkWell(
                      onTap: (){
                        checkAndCreateNewRoom(userModel!);
                        },
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(radius: 32,backgroundColor: Colors.blue.shade300,),
                          title: Text(userModel!.name!),
                          subtitle: Text(userModel!.email!),
                          trailing:Icon(
                                Icons.chat_bubble,
                                color: Colors.blue.shade100,
                            ),
                        ),
                      ),
                    );
                  }
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }
      ),
    );
  }
}
