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


  factory Task.fromJson(dynamic json) {
    DateTime? _completedDate;
    if (json['completed'] != null && json['completed'] != 'null') {
      _completedDate = DateTime.parse(json['completed']);
    }
    return Task(
      uuid: json['uuid'] as String,
      description: json['description'] as String,
      dueDate: DateTime.parse(json['dueDate']),
      accepted: json['accepted'] as bool?,
      completed: _completedDate,
      client: Client.fromJson(json['client']),
    );
  }

  Map<String,dynamic> toJson() {
    Map _client = client!.toJson();
    var jsonObj = {
      'uuid': uuid,
      'description': description,
      'dueDate': dueDate.toString(),
      'accepted': accepted,
      'completed': completed.toString(),
      'client': _client,
    };
    return jsonObj;
  }

}
