// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part "Task.g.dart";


@HiveType(typeId:1)
class Task extends HiveObject{
  @HiveField(1)
  final String id;

  @HiveField(2)
  String task;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  bool isComplated;

  Task({required this.id,required this.task , required this.createdAt ,required this.isComplated});

  factory Task.create({required String task,required TimeOfDay createdAt }){
    final now = DateTime.now();
    DateTime p1=DateTime(now.year, now.month, now.day, createdAt.hour, createdAt.minute);
    return Task(id: const Uuid().v1(), task: task, createdAt: p1, isComplated: false);
  }

  String fromTimetoString(){
    String saat= createdAt.hour<10 ? "0${createdAt.hour}" : createdAt.hour.toString();
    String dakika=  createdAt.minute<10 ? "0${createdAt.minute}" : createdAt.minute.toString();
    return ("$saat:$dakika");
  } 
}