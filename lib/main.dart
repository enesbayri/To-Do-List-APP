// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_7/data/HiveStorage.dart';
import 'package:flutter_application_7/data/localStorage.dart';
import 'package:flutter_application_7/models/Task.dart';
import 'package:flutter_application_7/pages/homePage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';


final getIt = GetIt.instance;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveSetup();
  GetItsetup();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      
  runApp(const App());
}


void GetItsetup() {
  getIt.registerSingleton<LocalStorage>(HiveStorage(),signalsReady: true);
}
Future<void> HiveSetup()async{
  await Hive.initFlutter("tasks");
  Hive.registerAdapter(TaskAdapter());
  var box=await Hive.openBox<Task>("tasks");
  for (var task in box.values) {
    if(task.createdAt.day!=DateTime.now().day){
      box.delete(task.id);
    }
    
  }
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              actionsIconTheme: IconThemeData(color: Colors.blue),
              centerTitle: false,
              elevation: 0,
              backgroundColor: Colors.transparent)),
      home: const HomePage(),
    );
  }
}
