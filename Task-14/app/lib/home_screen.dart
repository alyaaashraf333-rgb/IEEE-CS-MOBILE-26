import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, List<Task>>(
      builder: (context, tasks) {

        final activeTasks = tasks.where((t) => t.status == 'active').toList();

        return Scaffold(
          appBar: AppBar(
            title: Text('All Tasks', style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: Icon(Icons.menu, color: Colors.black),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: activeTasks.length,
              itemBuilder: (context, index) {
                final task = activeTasks[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.check_circle_outline, size: 16),
                          SizedBox(width: 5),
                          Text('task ${task.date.day}'),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // زر الإضافة العائم (FAB)
          floatingActionButton: FloatingActionButton(
            onPressed: () {

              context.read<AppCubit>().addTask("New Task ${tasks.length + 1}");
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.black,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'All',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.archive),
                label: 'Archive',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle),
                label: 'Done',
              ),
            ],
          ),
        );
      },
    );
  }
}