import 'package:equatable/equatable.dart';
import 'package:flutter_tasks_app/repository/firestore_repository.dart';
import '../../models/task.dart';
import '../bloc_exports.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<GetAllTask>(_onGetAllTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavoriteOrUnfavoriteTask>(_onMarkFavoriteOrUnfavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) async {
    await FirestoreRepository.create(task: event.task);
  }

  void _onGetAllTask(GetAllTask event, Emitter<TasksState> emit) async {
    List<Task> pendingTask = [];
    List<Task> completedTask = [];
    List<Task> favoriteTask = [];
    List<Task> removedTask = [];

    await FirestoreRepository.get().then((value){
      for (var task in value) {
        if(task.isDeleted == true){
          removedTask.add(task);
        } else {
          if(task.isFavorite == true){
            favoriteTask.add(task);
          }
          if(task.isDone == true){
            completedTask.add(task);
          } else {
            pendingTask.add(task);
          }
        }
      }
    });

    emit(TasksState(
      pendingTasks: pendingTask,
      completedTasks: completedTask,
      favoriteTasks: favoriteTask,
      removedTasks: removedTask
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) async {
    Task updateTask = event.task.copyWith(isDone: !event.task.isDone!);
    await FirestoreRepository.update(task: updateTask);
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) async {
    await FirestoreRepository.delete(task: event.task);
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) async {
    Task removedTask = event.task.copyWith(isDeleted: true);
    await FirestoreRepository.update(task: removedTask);
  }

  void _onMarkFavoriteOrUnfavoriteTask(MarkFavoriteOrUnfavoriteTask event, Emitter<TasksState> emit) async {
    Task task = event.task.copyWith(isFavorite: !event.task.isFavorite!);
    await FirestoreRepository.update(task: task);
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {

  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) async {
    Task restoreTask = event.task.copyWith(
      isDeleted: false, 
      isDone: false,
      isFavorite: false,
      date: DateTime.now().toString()
    );
    await FirestoreRepository.update(task: restoreTask);
  }

  void _onDeleteAllTask(DeleteAllTasks event, Emitter<TasksState> emit) async {
    await FirestoreRepository.deleteAllRemovedTasks(taskList: state.removedTasks);
  }
}
