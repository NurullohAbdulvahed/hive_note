import 'package:flutter/material.dart';
import 'package:hive_moor/models/note_model.dart';
import 'package:hive_moor/services/note_service.dart';

class DetailPage extends StatefulWidget {
  static final String id = "detail_page";
  final String? noteId;
  const DetailPage({Key? key,this.noteId}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void _storeNote(bool isSaveButton) async {
   if(widget.noteId == null){
     String title = titleController.text.toString().trim();
     String content = contentController.text.toString().trim();
     if(content.isNotEmpty){
       Note note = Note(id: title.hashCode, createTime: DateTime.now(), title: title, content: content);
       List<Note> noteList = DBService.loadNote();
       noteList.add(note);
       await DBService.storeNotes(noteList);
       Navigator.pop(context,true);
     }
   }
   else{
     List<Note> noteList = DBService.loadNote();

   }
  }


  void loadNotes(String? noteId){
    if(noteId!= null){
      int id = int.parse(noteId);
      List<Note> noteList = DBService.loadNote();
      Note note = noteList.where((element) => element.id ==id).toList().first;
      setState(() {
        titleController.text = note.title;
        contentController.text = note.content;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNotes(widget.noteId);
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        _storeNote(false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(onPressed: (){
              _storeNote(true);
            },
              child: Text("Save",style: TextStyle(color: Colors.white),))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                child: TextField(

                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Colors.orange,
                  cursorHeight: 25,
                  controller: titleController,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,

                  ),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: ("Title"),
                    hintStyle: TextStyle(color: Colors.grey,),

                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                child: TextField(
                  autofocus: true,
                  showCursor: true,
                  textAlignVertical: TextAlignVertical.center,
                  cursorColor: Colors.orange,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  cursorHeight: 25,
                  controller: contentController,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,

                  ),


                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: ("Title"),
                    hintStyle: TextStyle(color: Colors.grey,),

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
