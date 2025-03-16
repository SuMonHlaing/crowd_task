import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'client.dart';
import 'task.dart';
import 'uuid.dart';

class RequestTaskPage extends StatefulWidget {
  final List<Client> clients;

  RequestTaskPage({Key? key, required this.clients}) : super(key: key);

  @override
  RequestTaskPageState createState() => RequestTaskPageState();
}

class RequestTaskPageState extends State<RequestTaskPage> {
  final _formKey = GlobalKey<FormState>();
  Client? _selectedClient;
  String? _description;
  DateTime? _dueDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Requesting a task"),
        leading: CloseButton(),
        actions: <Widget>[
          Builder(
            builder: (context) => ElevatedButton(
              child: Text(
                "SAVE",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                save();
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DropdownButtonFormField<Client>(
                value: _selectedClient,
                onChanged: (client) {
                  setState(() {
                    _selectedClient = client;
                  });
                },
                items: widget.clients
                    .map(
                      (f) => DropdownMenuItem<Client>(
                    value: f,
                    child: Text(f.name),
                  ),
                )
                    .toList(),
                validator: (client) {
                  if (client == null) {
                    return "You must select a client to request the task";
                  }
                  return null;
                },
              ),
              Container(
                height: 16.0,
              ),
              Text("Task description:"),
              TextFormField(
                maxLines: 5,
                inputFormatters: [LengthLimitingTextInputFormatter(200)],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "You must describe the task";
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              Container(
                height: 16.0,
              ),
              Text("Due Date:"),
              TextButton(
                onPressed: () {
                  _selectDueDate(context);
                },
                child: Text(_dueDate == null
                    ? "Select Due Date"
                    : "Due Date: ${_dueDate!.toLocal()}".split(' ')[0]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2029, 12, 31),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  void save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(
        context,
        Task(
          uuid: UUID().generate(),
          description: _description!,
          dueDate: _dueDate!,
          accepted: null,
          completed: null,
          client: _selectedClient!,
        ),
      );
    }
  }
}