import 'package:flutter/material.dart';
import 'package:flutter_tasks/sqflite/db_helper.dart';

class Home_sqflite extends StatefulWidget{
  @override
  State<Home_sqflite> createState() => _Home_sqfliteState();
}

class _Home_sqfliteState extends State<Home_sqflite> {

  ///Controllers
  TextEditingController userTitle=TextEditingController();
  TextEditingController userDesc=TextEditingController();

  List<Map<String,dynamic>> allNotes=[];

  String errorMsg="";

  DBHelper? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef=DBHelper.getInstance;
    getNotes();
  }
  Future<void> getNotes() async {
    allNotes= await dbRef!.getAllDetails();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home SQFLite'),
        backgroundColor: Colors.blue,
      ),
      body: allNotes.isNotEmpty ? ListView.builder(
          itemCount: allNotes.length,
          itemBuilder: (_,index){
              return ListTile(
                leading: Text('${index+1}'),
                title: Text(allNotes[index][DBHelper.COLUMN_NOTE_TITLE]),
                subtitle: Text(allNotes[index][DBHelper.COLUMN_NOTE_DESC]),
                trailing: SizedBox(
                  height: 50,
                  width: 100,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      IconButton(
                        onPressed: () {
                          userTitle.text=allNotes[index][DBHelper.COLUMN_NOTE_TITLE];
                          userDesc.text=allNotes[index][DBHelper.COLUMN_NOTE_DESC];
                          showModalBottomSheet(
                              context: context,
                              builder: (context){
                                return getBottomSheetWidget(isUpdate: true,sno:allNotes[index][DBHelper.COLUMN_NOTE_SNO]);
                              }
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () async {
                          bool check= await dbRef!.deleteNote(sno: allNotes[index][DBHelper.COLUMN_NOTE_SNO]);
                          if(check){
                            getNotes();
                          }
                        },
                        icon: Icon(Icons.delete,color: Colors.red.shade300,),
                      )
                    ],
                  ),
                ),
              );
      }): Center(
        child: Text('No Notes yet!'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            userDesc.clear();
            userTitle.clear();
            showModalBottomSheet(
                context: context,
                builder: (context){
                  return getBottomSheetWidget();
                }
            );

          },
          child: Icon(Icons.add),
      ),
    );
  }

  Widget getBottomSheetWidget({isUpdate= false,sno=0}) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        children: [
          Text( isUpdate ? 'Update Note' : 'Add Note' , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
          ),
          SizedBox(height: 21,),
          TextField(
            controller: userTitle,
            decoration: InputDecoration(
              // hintText: "Enter the Note title",
              label: Text('Title *'),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
              ),
            ),
          ),
          SizedBox(height: 21,),
          TextField(
            maxLines: 4,
            controller: userDesc,
            decoration: InputDecoration(
              hintText: "Enter the Description",
              label: Text('Description *'),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11)
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11)
              ),
            ),
          ),
          SizedBox(height: 10,),
          if(errorMsg.isNotEmpty)
            Text(errorMsg),
          SizedBox(height: 10,),
          SizedBox(height: 21,),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11)
                        )
                    ),
                    onPressed: () async {
                      var title = userTitle.text;
                      var desc = userDesc.text;

                      if (title.isNotEmpty && desc.isNotEmpty) {
                        bool check = isUpdate ?  await dbRef!.updateNote(mTitle: title, mDesc: desc, sno: sno)
                                              : await dbRef!.addNote(mTitle: title, mDesc: desc);
                        if (check) {
                          await getNotes();
                          userDesc.clear();
                          userTitle.clear();
                          errorMsg="";
                        }
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          errorMsg = "*Please fill all the required Fields";
                        });
                      }
                    },
                    child: Text(isUpdate ? 'Update Note':'Add Note')
                ),
              ),
              SizedBox(width: 11,),
              Expanded(
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11)
                        ),
                        side: BorderSide(
                            width: 1
                        )
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
