import 'package:crowd_task/data.dart';
import 'package:crowd_task/request_task_page.dart';
import 'package:crowd_task/task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TasksPage extends StatefulWidget {
  final List<Task> pendingAnswerTasks;
  final List<Task> acceptedTasks;
  final List<Task> completedFTasks;
  final List<Task> declinedTasks;

  const TasksPage({
    super.key,
    required this.pendingAnswerTasks,
    required this.acceptedTasks,
    required this.completedFTasks,
    required this.declinedTasks,
  });

  @override
  TasksPageState createState() => TasksPageState();
}

class TasksPageState extends State<TasksPage> {
  void acceptTask(Task? task) {
    setState(() {
      widget.pendingAnswerTasks.remove(task);
      widget.acceptedTasks.add(task!.copyWith(accepted: true));
    });
  }

  void declineTask(Task task) {
    setState(() {
      widget.pendingAnswerTasks.remove(task);
      widget.declinedTasks.add(task.copyWith(accepted: false));
    });
  }

  void abandonTask(Task task) {
    setState(() {
      widget.acceptedTasks.remove(task);
      widget.declinedTasks.add(task.copyWith(accepted: false));
    });
  }

  void completeTask(Task task) {
    setState(() {
      widget.acceptedTasks.remove(task);
      widget.completedFTasks.add(task.copyWith(completed: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Crowd Tasks"),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              _buildCategoryTab("Requests"),
              _buildCategoryTab("Accepted"),
              _buildCategoryTab("Completed"),
              _buildCategoryTab("Declined"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _TasksList("Pending Requests", widget.pendingAnswerTasks, this),
            _TasksList("Accepted", widget.acceptedTasks, this),
            _TasksList("Completed", widget.completedFTasks, this),
            _TasksList("Rejected", widget.declinedTasks, this),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final task = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RequestTaskPage(
                  clients: theClients,
                ),
              ),
            );
            setState(() {
              widget.pendingAnswerTasks.add(task);
            });
          },
          tooltip: 'Request a Task',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildCategoryTab(String title) {
    return Tab(child: Text(title));
  }
}

// Widget _TasksList(String title, List<Task> tasks, TasksPageState state) {
//   return Column(
//     children: <Widget>[
//       Padding(
//         padding: const EdgeInsets.only(top: 16.0),
//         child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//       ),
//       Expanded(
//         child: ListView.builder(
//           itemCount: tasks.length,
//           itemBuilder: (BuildContext context, int index) {
//             final Task task = tasks[index];
//             return Card(
//               margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: <Widget>[
//                     _itemHeader(task),
//                     Text(task.description),
//                     _itemFooter(task, state),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     ],
//   );
// }

Widget _TasksList(String title, List<Task> tasks, TasksPageState state) {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      Expanded(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              // Landscape mode: use GridView
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                ),
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  final Task task = tasks[index];
                  return _buildTaskCard(task, state);
                },
              );
            } else {
              // Portrait mode: use ListView
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  final Task task = tasks[index];
                  return _buildTaskCard(task, state);
                },
              );
            }
          },
        ),
      ),
    ],
  );
}

Widget _buildTaskCard(Task task, TasksPageState state) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          _itemHeader(task),
          Text(task.description),
          _itemFooter(task, state),
        ],
      ),
    ),
  );
}
Row _itemHeader(Task task) {
  return Row(
    children: <Widget>[
      CircleAvatar(
        backgroundImage: NetworkImage(task.client.photoURL),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Text("${task.client.name} requested: ",
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    ],
  );
}

Widget _itemFooter(Task task, TasksPageState state) {
  if (task.isCompleted) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      alignment: Alignment.centerRight,
      child: Chip(
        label: Text("Completed at: ${DateFormat('yyyy-MM-dd').format(task.completed!)}"),
      ),
    );
  }
  if (task.isRequested) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextButton(
          onPressed: () {
            state.declineTask(task);
          },
          child: const Text("Decline"),
        ),
        TextButton(
          onPressed: () {
            state.acceptTask(task);
          },
          child: const Text("Accept"),
        ),
      ],
    );
  }
  return Container();
}