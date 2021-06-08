import 'package:flutter/material.dart';
import 'package:todo_list/models/task.api.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/views/add_task.dart';
import 'package:todo_list/views/widgets/task_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> _tasks;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  Future<void> getTasks() async {
    _tasks = await TaskApi.getTasks();
    setState(() {
      getTasks();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('ToDo List'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            )
          : RefreshIndicator(
              onRefresh: getTasks,
              color: Colors.teal,
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    id: _tasks[index].id.toString(),
                    title: _tasks[index].title,
                    description: _tasks[index].description,
                    completed: _tasks[index].completed,
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal.shade800,
        tooltip: 'add a task',
        child: Icon(
          Icons.add,
        ),
        onPressed: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTask()))
              .then((value) => setState(() {}));
        },
      ),
    );
  }
}
