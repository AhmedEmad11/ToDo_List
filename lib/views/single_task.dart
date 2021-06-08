import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_list/models/task.api.dart';
import 'package:todo_list/models/task.dart';

class SingleTask extends StatefulWidget {
  final Task task;

  SingleTask({Key? key, required this.task}) : super(key: key);

  @override
  _SingleTaskState createState() => _SingleTaskState();
}

class _SingleTaskState extends State<SingleTask> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;
  late bool checkValue = widget.task.completed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit A Task"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: widget.task.title,
                    decoration: InputDecoration(
                      labelText: "title",
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) async {
                      title = value.toString();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: widget.task.description,
                    decoration: InputDecoration(
                      labelText: "description",
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (value) async {
                      description = value.toString();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.teal,
                    value: checkValue,
                    onChanged: (bool? newValue) {
                      setState(() {
                        checkValue = newValue as bool;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.teal),
                  onPressed: () {
                    _formKey.currentState!.save();
                    Task tempTask = Task(
                        id: widget.task.id,
                        title: title,
                        description: description,
                        completed: checkValue);
                    TaskApi.updateTask(tempTask);
                    Navigator.pop(context);
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
