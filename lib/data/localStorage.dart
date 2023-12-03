// ignore_for_file: file_names

import 'package:flutter_application_7/models/Task.dart';

abstract class LocalStorage{
  Future<void> addTask({required Task task});
  Future<Task> getTask({required String id});
  Future<List<Task>> getAllTask();
  Future<void> deleteTask({required Task task});
  Future<Task> updateTask({required Task task});
}