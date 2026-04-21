import 'package:bloc/bloc.dart';

// Model for a Task
class Task {
  final String title;
  final DateTime date;
  final String status; // 'active', 'done', 'archive'

  Task({required this.title, required this.date, this.status = 'active'});
}


class AppCubit extends Cubit<List<Task>> {
  AppCubit() : super([]);


  void addTask(String title) {
    final newTask = Task(
      title: title,
      date: DateTime.now(),
    );
    emit([...state, newTask]);
  }


  void changeStatus(int index, String newStatus) {
    final updatedState = List<Task>.from(state);
    final task = updatedState[index];
    updatedState[index] = Task(
      title: task.title,
      date: task.date,
      status: newStatus,
    );
    emit(updatedState);
  }
}