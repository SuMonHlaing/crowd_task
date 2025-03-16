import 'package:crowd_task/task.dart';
import 'package:crowd_task/task_data.dart';
import 'package:crowd_task/tasks_page.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crowd Tasks',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TasksPage(
        pendingAnswerTasks: pendingTasks,
        acceptedTasks: acceptedTasks,
        completedFTasks: completedTasks,
        declinedTasks: rejectedTasks,
      ),
    );
  }
}









