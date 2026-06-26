import 'dart:convert';

class Task {
  final String id;
  final String title;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  // Task object ko Map me badalne ke liye (Saving ke liye)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  // Map se wapas Task object banane ke liye (Loading ke liye)
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
    );
  }

  // List of Tasks ko String (JSON) banakar save karne ke liye
  static String encode(List<Task> tasks) => json.encode(
        tasks.map<Map<String, dynamic>>((task) => task.toMap()).toList(),
      );

  // String (JSON) ko wapas List of Tasks banane ke liye
  static List<Task> decode(String tasksJson) => tasksJson.isEmpty
      ? []
      : (json.decode(tasksJson) as List<dynamic>)
          .map<Task>((item) => Task.fromMap(item))
          .toList();
}