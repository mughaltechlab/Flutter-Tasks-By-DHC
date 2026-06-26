import 'dart:convert';

class Task {
  final String title;
  bool isCompleted;

  Task({
    required this.title,
    this.isCompleted = false,
  });

  // Task ko Map (JSON) me badalne ke liye
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  // Map (JSON) se wapas Task object banane ke liye
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
    );
  }

  // List of Tasks ko String banakar save karne ke liye
  static String encode(List<Task> tasks) => json.encode(
        tasks.map<Map<String, dynamic>>((task) => task.toMap()).toList(),
      );

  // String ko wapas List of Tasks banane ke liye
  static List<Task> decode(String tasksJson) => tasksJson.isEmpty
      ? []
      : (json.decode(tasksJson) as List<dynamic>)
          .map<Task>((item) => Task.fromMap(item))
          .toList();
}