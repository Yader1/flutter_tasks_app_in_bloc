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
      value.forEach((task) {
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
      });
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

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {

  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {

  }

  void _onMarkFavoriteOrUnfavoriteTask(MarkFavoriteOrUnfavoriteTask event, Emitter<TasksState> emit) {

  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {

  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {

  }

  void _onDeleteAllTask(DeleteAllTasks event, Emitter<TasksState> emit) {

  }
}
