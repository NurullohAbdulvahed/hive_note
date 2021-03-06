import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_moor/pages/detail_page.dart';
import 'package:hive_moor/pages/home_page.dart';
import 'package:hive_moor/services/note_service.dart';


void main() async {
  //Initialization
  await Hive.initFlutter();
  await Hive.openBox(DBService.dbName);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: DBService.box.listenable(),
        builder: (context, box, widget) {
          return MaterialApp(
            themeMode: DBService.loadMode() ? ThemeMode.light: ThemeMode.dark,
            darkTheme: ThemeData.dark(),
            theme: ThemeData.light(),
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
            routes: {
              HomePage.id: (context) => HomePage(),
              DetailPage.id: (context) => DetailPage(),
            },
          );
        }
    );
  }
}