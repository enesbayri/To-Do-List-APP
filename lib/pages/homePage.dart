// ignore_for_file: file_names, non_constant_identifier_names, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_application_7/data/localStorage.dart';
import 'package:flutter_application_7/models/Task.dart';
import 'package:flutter_application_7/ui_helper/stylesHelper.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter_application_7/widgets/searchDelegate.dart';
import 'package:get_it/get_it.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? task;
  late List<Task> tasks;
  late final getIt =GetIt.instance<LocalStorage>();
  @override
  void initState() {
    
    super.initState();
    tasks = <Task>[];
    getAllTasks();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            _searchpage(context);
          }, icon: const Icon(Icons.manage_search_sharp)),
          IconButton(
              onPressed: () {
                _showModelBottomSheet(context);
              },
              icon: const Icon(Icons.add_outlined)),
        ],
        title: Text(
          "Bugün Neler Yapacaksın?",
          style: stylesHelper.AppbarTextStyle,
        ),
      ),
      body:listview(tasks)
    );
  }

  ListView listview(List<Task> tasks) {
    return ListView.builder(
      itemBuilder: (context, index) {
        TextEditingController taskController=TextEditingController();
        Task thisTask = tasks[index];
        taskController.text=thisTask.task;
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
              const Icon(Icons.delete_forever,color: Colors.white,),
              Text("Bu görev silindi!",style: stylesHelper.dismBackgroundTextStyle,)
          
            ],),
          ),
          child: Card(
              child: ListTile(
            leading: GestureDetector(
              onTap: () {
                setState(() {
                  thisTask.isComplated=!(thisTask.isComplated);
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
                ? Text(thisTask.task ,style: stylesHelper.tasktitleTextStyle,)
                : TextField(
                    controller:taskController ,
                    textInputAction: TextInputAction.done,
                    maxLines: null,
                    minLines: 1,
                    onSubmitted: (value) {
                      if(value.length>3){
                        thisTask.task=value;
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
      itemCount:tasks.length,
    );
  }

  void _searchpage(BuildContext context)async{
    await showSearch(context: context, delegate: CustomSearchDelegate(tasks: tasks));

    getAllTasks();
  
    
    setState(() {});
  }

  void _showModelBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: "Görev nedir?"),
            onSubmitted: (value) {
              task = value;
              Navigator.of(context).pop();
              Navigator.of(context).push(ShowPicker(context));
            },
          ),
        );
      },
    );
  }

  ShowPicker(BuildContext context) {
    return showPicker(
        context: context,
        is24HrFormat: true,
        value: Time(hour: 0, minute: 0),
        sunrise: const TimeOfDay(hour: 6, minute: 0), // optional
        sunset: const TimeOfDay(hour: 18, minute: 0), // optional
        duskSpanInMinutes: 120, // optional
        iosStylePicker: true,
        onChange: (p0) async{
            Task newTask=Task.create(task: task!, createdAt: p0);
            tasks.add(newTask);
            getIt.addTask(task: newTask);
          
          setState(() {});
        },
        hourLabel: "Saat",
        minuteLabel: "Dakika",
        cancelText: "Geri",
        showCancelButton: false,
        okText: "Tamamla");
  }

  void getAllTasks() async{
    tasks=await getIt.getAllTask(); 
    setState((){
    });
  }
  
 
}
