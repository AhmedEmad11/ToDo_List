class Task {
  final int id;
  final String title;
  final String description;
  final bool completed;

  Task(
      {this.id = 1,
      required this.title,
      required this.description,
      required this.completed});

  factory Task.fromJson(dynamic json) {
    return Task(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      completed: json['completed'] as bool,
    );
  }

  static Map<String, dynamic> toJson(Task task) => {
        'id': task.id.toString(),
        'title': task.title,
        'description': task.description,
        'completed': task.completed
      };

  static List<Task> tasksFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Task.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Task {id: $id, title: $title, decription: $description, completed: $completed}';
  }
}
