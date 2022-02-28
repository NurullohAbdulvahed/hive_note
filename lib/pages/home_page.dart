import 'package:flutter/material.dart';
import 'package:hive_moor/models/note_model.dart';
import 'package:hive_moor/pages/detail_page.dart';
import 'package:hive_moor/services/note_service.dart';


class HomePage extends StatefulWidget {
  static const String id = "/home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 late List<Note> listNote;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNoteList();
  }
  void loadNoteList(){
    setState(() {
      listNote= DBService.loadNote();
    });
  }
  void openDeTailPage()async{
    var result =await Navigator.of(context).pushNamed(DetailPage.id);
    if(result != null && result == true){
      loadNoteList();
    }
  }
  void _openDetailForEdit(String id)async{
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(noteId: id,)));
    if(result != null && result == true){
      loadNoteList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Note"),
        actions: [
          IconButton(
              onPressed: (){
                DBService.storeMode(!DBService.loadMode());
              },
              icon: Icon(DBService.loadMode() ? Icons.dark_mode : Icons.light_mode),
          )
        ],
      ),
      body: GridView.builder(
        itemCount: listNote.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
       itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              _openDetailForEdit(listNote[index].id.toString());
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(listNote[index].title),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(listNote[index].content),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(listNote[index].createTime.toString()),
                    )
                  ],
                ),
              ),
            ),
          );
       }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openDeTailPage,
        child: Icon(Icons.add),

      ),
    );
  }
}
