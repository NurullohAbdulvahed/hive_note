import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_moor/models/note_model.dart';

class DBService{
  static const String dbName = "db_notes";
  static var box = Hive.box(dbName);

  static Future<void> storeMode(bool isLight) async{
    await box.put("isLight", isLight);
  }


  static bool  loadMode() {
    return box.get("isLight",defaultValue: true);
  }
  
  
  
  
  
  
  
 static Future<void> storeNotes(List<Note> noteList) async{
   //object => map => string
   List<String> stringList = noteList.map((note) => jsonEncode(note.toJson())).toList();
    await box.put("notes", stringList);
  }

  static List<Note> loadNote() {
    List<String> stringList = box.get("notes") ?? <String> [];
    List<Note> noteList = stringList.map((string) => Note.fromJson(jsonDecode(string))).toList();
    return noteList;
  }
 static Future<void> removeNotes() async {
    box.delete("notes");
  }

}