
// ignore_for_file: file_names

import 'package:flutter_application_7/data/localStorage.dart';
import 'package:flutter_application_7/models/Task.dart';
import 'package:hive_flutter/hive_flutter.dart';






class HiveStorage extends LocalStorage{
  late Box<Task> box;
  
  HiveStorage(){
    box=Hive.box<Task>("tasks");
    
  }
  @override
  Future<void> addTask({required Task task}) async {
    await box.put(task.id, task);
    
    //var box2=await Hive.openBox<Map>("deneme");
    //box2.put("1",json.encode({"ad":"enes","soyad":"bayri"}));
    //await box2.put("2",({"ad":"enes","soyad":"bayri"}));
    //var d=await box2.get("1");
    //print(json.decode(d)["ad"]);
    //var d2=await box2.get("2");
    //print(d2!["soyad"]);
  }

  @override
  Future<void> deleteTask({required Task task}) async{
    await box.delete(task.id);
  }

  @override
  Future<List<Task>> getAllTask() async{
    List<Task> getTasks=[];
    if(box.isNotEmpty){
      getTasks=box.values.toList();
      getTasks.sort((a, b) => a.createdAt.compareTo(b.createdAt),);
      
    }
    return getTasks;
  }

  @override
  Future<Task> getTask({required String id}) async{
    Task gettedTask=box.get(id)!;
    return gettedTask;
  }

  @override
  Future<Task> updateTask({required Task task}) async{
    await box.put(task.id, task);
    return task;
  }

}