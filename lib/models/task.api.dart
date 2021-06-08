import 'dart:convert';
import 'package:todo_list/models/task.dart';
import 'package:http/http.dart' as http;

class TaskApi {
  static Future<List<Task>> getTasks() async {
    var uri = Uri.https(
      'tasks-crud-api.herokuapp.com',
      '/task-list/',
    );

    final response =
        await http.get(uri, headers: {"content-type": "application/json"});

    List _temp = jsonDecode(response.body);
    return Task.tasksFromSnapshot(_temp);
  }

  static Future postTask(String title, String description) async {
    var uri = Uri.https(
      'tasks-crud-api.herokuapp.com',
      '/task-create/',
    );
    final response = await http.post(uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(
            {"title": title, "description": description, "completed": false}));
  }

  static Future deleteTask(String id) async {
    var uri = Uri.https(
      'tasks-crud-api.herokuapp.com',
      "/task/$id/",
    );
    final response = await http.delete(uri);
  }

  static Future updateTask(Task task) async {
    var uri = Uri.https(
      'tasks-crud-api.herokuapp.com',
      "/task/${task.id}/",
    );
    final response = await http.put(uri,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          "title": task.title,
          "description": task.description,
          "completed": task.completed
        }));
  }

  static Future<Task> getTask(int id) async {
    var uri = Uri.https(
      'tasks-crud-api.herokuapp.com',
      "/task/${id.toString()}/",
    );
    final response = await http.get(uri);
    Task task = Task.fromJson(response.body);
    return task;
  }
}
