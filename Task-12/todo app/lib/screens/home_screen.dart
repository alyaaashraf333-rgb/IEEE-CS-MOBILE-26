import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'tasks_screen.dart';
import 'archive_screen.dart';
import 'done_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var taskController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  late Database database;
  List<Map> tasks = [];
  int currentIndex = 0;

  // إنشاء قاعدة البيانات
  Future<void> createDatabase() async {
    try {
      final databasesPath = await getDatabasesPath();
      final path = '$databasesPath/todo_app.db';

      print('📂 Database path: $path');

      database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          print('🗄️ Creating database...');
          await db.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, time TEXT, date TEXT, status TEXT)',
          );
          print('✅ Table created successfully');
        },
        onOpen: (db) async {
          print('✅ Database opened successfully');
          await loadData();
        },
      );
    } catch (e) {
      print('❌ Error creating database: $e');
    }
  }

  // جلب البيانات
  Future<void> loadData() async {
    try {
      final List<Map> data = await database.rawQuery('SELECT * FROM tasks ORDER BY id DESC');
      print('📋 Loaded ${data.length} tasks from database');

      if (mounted) {
        setState(() {
          tasks = data;
        });
      }
    } catch (e) {
      print('❌ Error loading data: $e');
    }
  }

  // إضافة مهمة جديدة
  Future<void> insertDataToDatabase({
    required String title,
    required String time,
    required String date,
    required String status,
  }) async {
    try {
      print('📝 Inserting task: title=$title, time=$time, date=$date, status=$status');

      final int id = await database.rawInsert(
        'INSERT INTO tasks (title, time, date, status) VALUES (?, ?, ?, ?)',
        [title, time, date, status],
      );

      print('✅ Task inserted with ID: $id');
      await loadData();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task added successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('❌ Error inserting task: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // تحديث حالة المهمة
  Future<void> updateTaskStatus({required int id, required String status}) async {
    try {
      print('🔄 Updating task $id to status: $status');

      await database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id],
      );

      print('✅ Task updated successfully');
      await loadData();
    } catch (e) {
      print('❌ Error updating task: $e');
    }
  }

  // حذف مهمة
  Future<void> deleteTask({required int id}) async {
    try {
      print('🗑️ Deleting task $id');

      await database.rawDelete(
        'DELETE FROM tasks WHERE id = ?',
        [id],
      );

      print('✅ Task deleted successfully');
      await loadData();
    } catch (e) {
      print('❌ Error deleting task: $e');
    }
  }

  // إظهار الـ Bottom Sheet
  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Add New Task',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Task Name Field
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.task, color: Colors.green),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: taskController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Task Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter task name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // Time Field
                InkWell(
                  onTap: () => _selectTime(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.green),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            timeController.text.isEmpty
                                ? 'Task Time'
                                : timeController.text,
                            style: TextStyle(
                              color: timeController.text.isEmpty
                                  ? Colors.grey
                                  : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Date Field
                InkWell(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.green),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            dateController.text.isEmpty
                                ? 'Task Date'
                                : dateController.text,
                            style: TextStyle(
                              color: dateController.text.isEmpty
                                  ? Colors.grey
                                  : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // Add Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (timeController.text.isEmpty || dateController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select time and date'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                          return;
                        }

                        insertDataToDatabase(
                          title: taskController.text,
                          time: timeController.text,
                          date: dateController.text,
                          status: 'active',
                        );

                        Navigator.pop(context);
                        taskController.clear();
                        timeController.clear();
                        dateController.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Add Task',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  // اختيار الوقت
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && mounted) {
      setState(() {
        timeController.text = picked.format(context);
      });
    }
  }

  // اختيار التاريخ
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && mounted) {
      setState(() {
        dateController.text = DateFormat('MMM dd, yyyy').format(picked);
      });
    }
  }

  // الحصول على الشاشة الحالية
  Widget get currentScreen {
    List<Map> filteredTasks;

    switch (currentIndex) {
      case 0: // All Tasks - المهام النشطة
        filteredTasks = tasks.where((task) =>
        task['status'] == 'active' || task['status'] == null
        ).toList();
        return TasksScreen(
          tasks: filteredTasks,
          onUpdateStatus: updateTaskStatus,
          onDelete: deleteTask,
        );
      case 1: // Archive - المؤرشفة
        filteredTasks = tasks.where((task) =>
        task['status'] == 'archive'
        ).toList();
        return ArchiveScreen(
          tasks: filteredTasks,
          onDelete: deleteTask,
        );
      case 2: // Done - المكتملة
        filteredTasks = tasks.where((task) =>
        task['status'] == 'done'
        ).toList();
        return DoneScreen(
          tasks: filteredTasks,
          onDelete: deleteTask,
        );
      default:
        return const SizedBox();
    }
  }

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentIndex == 0
              ? 'All Tasks'
              : currentIndex == 1
              ? 'Archive'
              : 'Done',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: loadData,
          ),
        ],
      ),
      body: currentScreen,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showBottomSheet,
        backgroundColor: Colors.green,
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'Archive',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'Done',
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timeController.dispose();
    dateController.dispose();
    taskController.dispose();
    super.dispose();
  }
}