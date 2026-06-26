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
    _loadTasks(); 
  }

  // 1. SharedPreferences se data Read karna
  Future<void> _loadTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tasksString = prefs.getString('user_tasks_key');
    if (tasksString != null) {
      setState(() {
        _tasks = Task.decode(tasksString);
      });
    }
  }

  // 2. SharedPreferences me data Save karna
  Future<void> _saveTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Task.encode(_tasks);
    await prefs.setString('user_tasks_key', encodedData);
  }

  // 3. Naya task add karne ka function
  void _addTask() {
    if (_taskController.text.trim().isEmpty) return;

    setState(() {
      _tasks.add(Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
        title: _taskController.text.trim(),
      ));
    });
    _taskController.clear();
    _saveTasks(); 
    Navigator.pop(context);
  }

  // 4. Task ko Complete/Incomplete mark karne ka function
  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
    _saveTasks();
  }

  // 5. Task Delete karne ka function
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    _saveTasks();
  }

  // Task add karne wala Custom Dialog Box
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('Add New Task', style: TextStyle(fontWeight: FontWeight.bold)),
        content: TextField(
          controller: _taskController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'What needs to be done?',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: _addTask,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade900,
              foregroundColor: Colors.white,
            ),
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
        elevation: 4,
        title: const Text(
          "Task Management App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_rounded, color: Colors.white, size: 28),
            onPressed: _showAddTaskDialog, // Action button for adding task
          ),
        ],
      ),
      body: _tasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notes_rounded, size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 10),
                  Text(
                    'Your to-do list is clean!',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: Checkbox(
                      activeColor: Colors.grey.shade900,
                      value: task.isCompleted,
                      onChanged: (value) => _toggleTaskCompletion(index),
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                        color: task.isCompleted ? Colors.grey : Colors.black87,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
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