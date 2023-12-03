// ignore_for_file: file_names, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_application_7/data/localStorage.dart';
import 'package:flutter_application_7/models/Task.dart';
import 'package:flutter_application_7/ui_helper/stylesHelper.dart';
import 'package:get_it/get_it.dart';

class ListTasks extends StatefulWidget {
  final List<Task> tasks;
  const ListTasks({required this.tasks, super.key});

  @override
  State<ListTasks> createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
  late final getIt = GetIt.instance<LocalStorage>();
  late List<Task> tasks;
  @override
  void initState() {
    super.initState();
    tasks = [];
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        TextEditingController taskController = TextEditingController();
        Task thisTask = tasks[index];
        taskController.text = thisTask.task;
        return Dismissible(
          key: Key(thisTask.id),
          onDismissed: (direction) {
            tasks.removeAt(index);
            getIt.deleteTask(task: thisTask);
          },
          background: Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                ),
                Text(
                  "Bu görev silindi!",
                  style: stylesHelper.dismBackgroundTextStyle,
                )
              ],
            ),
          ),
          child: Card(
              child: ListTile(
            leading: GestureDetector(
              onTap: () {
                setState(() {
                  thisTask.isComplated = !(thisTask.isComplated);
                  getIt.updateTask(task: thisTask);
                });
              },
              child: Container(
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      color: thisTask.isComplated == true
                          ? Colors.green
                          : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green, width: 0.8))),
            ),
            title: thisTask.isComplated == true
                ? Text(
                    thisTask.task,
                    style: stylesHelper.tasktitleTextStyle,
                  )
                : TextField(
                    controller: taskController,
                    textInputAction: TextInputAction.done,
                    maxLines: null,
                    minLines: 1,
                    onSubmitted: (value) {
                      if (value.length > 3) {
                        thisTask.task = value;
                        setState(() {
                          getIt.updateTask(task: thisTask);
                        });
                      }
                    },
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
            trailing: Text(
              thisTask.fromTimetoString(),
              style: stylesHelper.taskTimeTextStyle,
            ),
          )),
        );
      },
      itemCount: tasks.length,
    );
  }

  void getTasks() async {
    tasks = widget.tasks;
  }
}
