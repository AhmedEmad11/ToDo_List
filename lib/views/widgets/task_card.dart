import 'package:flutter/material.dart';
import 'package:todo_list/models/task.api.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/views/single_task.dart';

class TaskCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final bool completed;

  TaskCard({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.teal.shade300,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: Offset(
              0.0,
              10.0,
            ),
            blurRadius: 10.0,
            spreadRadius: -6.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.0),
              child: GestureDetector(
                onTap: () {
                  Task task = Task(
                    id: int.parse(id),
                    title: title,
                    description: description,
                    completed: completed,
                  );
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SingleTask(task: task)));
                },
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                  ),
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            alignment: Alignment.center,
          ),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: (() {
                    if (completed) {
                      return IconButton(
                        icon: Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 35,
                        ),
                        onPressed: () {
                          Task task = Task(
                            id: int.parse(id),
                            title: title,
                            description: description,
                            completed: !completed,
                          );
                          TaskApi.updateTask(task);
                        },
                      );
                    } else {
                      return IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Task task = Task(
                            id: int.parse(id),
                            title: title,
                            description: description,
                            completed: !completed,
                          );
                          TaskApi.updateTask(task);
                        },
                      );
                    }
                  }()),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      TaskApi.deleteTask(id);
                    },
                  ),
                )
              ],
            ),
            alignment: Alignment.bottomLeft,
          ),
        ],
      ),
    );
  }
}
