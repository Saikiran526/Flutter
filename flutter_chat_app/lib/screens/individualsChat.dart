import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/chatItem.dart';

class IndividualChat extends StatefulWidget {

  String userName;

  IndividualChat({super.key,required  this.userName});

  @override
  State<IndividualChat> createState() => _IndividualChatState();
}

class require {
}

class _IndividualChatState extends State<IndividualChat> {

  ///Controller
  TextEditingController textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.userName),backgroundColor: Colors.blue,),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 20,
                itemBuilder: (context,index){
                  return ChatItem(chatSendReceive:index);
                }
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      labelText: "Type Message...",
                      border:OutlineInputBorder()
                    ),
                  ),
                ),
                IconButton(
                    onPressed: (){
                      // FocusScope.of(context).unfocus();
                      setState(() {
                        textController.text="";
                      });
                    }, icon: Icon(Icons.send_rounded)
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
