import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/database_helper.dart';
import '../models/task.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  List<Task> _tasks = [];
  bool _showArchived = false;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await _dbHelper.getAllTasks(archived: _showArchived);
    setState(() {
      _tasks = tasks;
    });
  }

  Future<void> _toggleTaskCompletion(Task task) async {
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      description: task.description,
      taskDate: task.taskDate,
      taskTime: task.taskTime,
      isCompleted: !task.isCompleted,
      isArchived: task.isArchived,
    );
    await _dbHelper.updateTask(updatedTask);
    await _loadTasks();
  }

  Future<void> _archiveTask(Task task) async {
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      description: task.description,
      taskDate: task.taskDate,
      taskTime: task.taskTime,
      isCompleted: task.isCompleted,
      isArchived: true,
    );
    await _dbHelper.updateTask(updatedTask);
    await _loadTasks();
  }

  Future<void> _deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    await _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_showArchived ? 'Archived Tasks' : 'All Tasks'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Column(
        children: [
          // Task List
          Expanded(
            child: _tasks.isEmpty
                ? const Center(
              child: Text(
                'No tasks yet!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: _tasks.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) => _toggleTaskCompletion(task),
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('h:mm a').format(
                            DateTime(
                              task.taskDate.year,
                              task.taskDate.month,
                              task.taskDate.day,
                              task.taskTime.hour,
                              task.taskTime.minute,
                            ),
                          ),
                        ),
                        Text(
                          DateFormat('MMM dd, yyyy').format(task.taskDate),
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.archive, color: Colors.orange),
                          onPressed: () => _archiveTask(task),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteTask(task.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
          await _loadTasks();
        },
        backgroundColor: Colors.green.shade700,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _showArchived ? 1 : 0,
        onTap: (index) {
          setState(() {
            _showArchived = index == 1;
          });
          _loadTasks();
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'Archived',
          ),
        ],
      ),
    );
  }
}