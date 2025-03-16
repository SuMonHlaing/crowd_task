import 'package:crowd_task/client.dart';

class Task {
  final String uuid;
  final String description;
  final DateTime dueDate;
  final bool? accepted;
  final DateTime? completed;
  final Client client;

  Task(
      {required this.uuid,
      required this.description,
      required this.dueDate,
      this.accepted,
      this.completed,
      required this.client});
  Task copyWith({
    String? uuid,
    String? description,
    DateTime? dueDate,
    bool? accepted,
    DateTime? completed,
    Client? client,
  }) {
    return Task(
      uuid: uuid ?? this.uuid,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      accepted: accepted ?? this.accepted,
      completed: completed ?? this.completed,
      client: client ?? this.client,
    );
  }

  bool get isDoing => accepted == true && completed == null;
  bool get isRequested => accepted == null;
  bool get isCompleted => completed != null;
}
