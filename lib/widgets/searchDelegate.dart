// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_7/data/localStorage.dart';
import 'package:flutter_application_7/models/Task.dart';
import 'package:flutter_application_7/widgets/taskListview.dart';
import 'package:get_it/get_it.dart';


class CustomSearchDelegate extends SearchDelegate {
  late final getIt =GetIt.instance<LocalStorage>();
  final List<Task> tasks;
  CustomSearchDelegate({required this.tasks});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query.isEmpty ? null : query="";
          },
          icon: const Icon(
            Icons.close,
            color: Colors.grey,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, 2);
      },
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Task> searchtasks=[];
    for (var t in tasks) {
        if(t.task.toLowerCase().contains(query.toLowerCase())){
          searchtasks.add(t);
        }
      }
    return searchtasks.isNotEmpty ? ListTasks(tasks: searchtasks): const Center(child:Text("Aranan Görev Bulunamadı!"),);
    
    
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Task> searchtasks=[];
    getIt.getAllTask().then((tasks) {
      for (var t in tasks) {
        if(t.task.toLowerCase().contains(query.toLowerCase())){
          searchtasks.add(t);
        }
      }
    });
    return ListTasks(tasks: searchtasks);
  }
  


}
