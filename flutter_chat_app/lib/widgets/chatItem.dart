import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  int chatSendReceive;
  ChatItem({super.key,required this.chatSendReceive});

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding:const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: chatSendReceive%2==0 ?  BorderRadius.only(topLeft: Radius.circular(21),bottomLeft: Radius.circular(21) ,topRight: Radius.circular(21))
                :BorderRadius.only(topLeft: Radius.circular(21),bottomRight: Radius.circular(21) ,topRight: Radius.circular(21)),
            color: Colors.grey,
          ),
          alignment: chatSendReceive%2==0 ?  Alignment.centerRight : Alignment.centerLeft,
          width:100,
          constraints: BoxConstraints(
            minHeight: 55,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Hello World!'),
                Text('5:27 pm'),
              ],
            ),
          ),
        ),
      );
  }
}
