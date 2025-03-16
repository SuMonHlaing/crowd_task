
import 'package:crowd_task/client.dart';
import 'package:crowd_task/task.dart';
import 'package:crowd_task/uuid.dart';

final uuid = UUID();


final List<Task> pendingTasks = [
  Task(
    uuid: uuid.generate(),
    description: "Deliver my groceries",
    accepted:  null,
    dueDate: DateTime.now().add(Duration(days: 1)),
    client: Client(
      name: "Ronald",
      number: "9876543210",
      photoURL: "https://i.pravatar.cc/300?img=65",
    ),
  ),
  Task(
    uuid: uuid.generate(),
    description: "Walk my dogs",
    accepted: null,
    dueDate: DateTime.now().add(Duration(hours: 5)),
    client: Client(
      name: "Sally",
      number: "1234567890",
      photoURL: "https://i.pravatar.cc/300?img=49",
    ),
  ),
  Task(
    uuid: uuid.generate(),
    description: "Start a new project",
    accepted: null,
    dueDate: DateTime.now(),
    client: Client(
      name: "John",
      number: "11111111111",
      photoURL: "https://i.pravatar.cc/300?img=50",
    ),
  ),
  Task(
    uuid: uuid.generate(),
    description: "Record a new video",
    accepted: null,
    dueDate: DateTime.now(),
    client: Client(
      name: "John",
      number: "11111111111",
      photoURL: "https://i.pravatar.cc/300?img=50",
    ),
  ),

];

final List<Task> acceptedTasks = [
  Task(
    uuid: uuid.generate(),
    description: "Write an app",
    dueDate: DateTime.now().add(Duration(days: 1)),
    accepted: true,
    client: Client(
      name: "Sally",
      number: "1234567890",
      photoURL: "https://i.pravatar.cc/300?img=49",
    ),
  ),
  Task(
    uuid: uuid.generate(),
    description: "Have a chat",
    dueDate: DateTime.now().add(Duration(hours: 1)),
    accepted: true,
    client: Client(
      name: "John",
      number: "11111111111",
      photoURL: "https://i.pravatar.cc/300?img=50",
    ),
  )

];

final List<Task> completedTasks = [Task(
  uuid: uuid.generate(),
  description: "Buy takeaway",
  dueDate: DateTime.now().add(Duration(days: 1)),
  completed: DateTime.now(),
  accepted: true,
  client: Client(
    name: "Sally",
    number: "1234567890",
    photoURL: "https://i.pravatar.cc/300?img=49",
  ),
),
];
final List<Task> rejectedTasks = [  Task(
  uuid: uuid.generate(),
  description: "Take the bins out",
  dueDate: DateTime.now().add(Duration(days: 1)),
  accepted: false,
  client: Client(
    name: "Harry",
    number: "5678901234",
    photoURL: "https://i.pravatar.cc/300?img=13",
  ),
),
];
