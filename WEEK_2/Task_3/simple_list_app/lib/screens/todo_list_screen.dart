import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks(); // App khulte hi memory se saare tasks uthao
  }

  // 1. SharedPreferences se data read karna
  Future<void> _loadTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('todo_tasks');
    if (tasksString != null) {
      setState(() {
        _tasks = Task.decode(tasksString);
      });
    }
  }

  // 2. SharedPreferences me data save karna
  Future<void> _saveTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Task.encode(_tasks);
    await prefs.setString('todo_tasks', encodedData);
  }

  // 3. Naya task list me add karna
  void _addTask() {
    if (_taskController.text.trim().isEmpty) return;

    setState(() {
      _tasks.add(Task(title: _taskController.text.trim()));
    });
    _taskController.clear();
    _saveTasks(); // Memory me update karo
    Navigator.pop(context); // Dialog box band karo
  }

  // Task ki selection ya completion toggle karna
  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
    _saveTasks();
  }

  // Task ko delete karna (Bonus practice)
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    _saveTasks();
  }

  // Task add karne wala Bottom Sheet / Dialog UI
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Task'),
        content: TextField(
          controller: _taskController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter task name...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _addTask,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        title: const Text("To-Do List", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: _tasks.isEmpty
          ? const Center(
              child: Text(
                'No tasks added yet! Click + to add one.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) => _toggleTaskCompletion(index),
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: task.isCompleted ? Colors.grey : Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => _deleteTask(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}