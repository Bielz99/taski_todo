// Arquivo: dependency_injection.dart
import 'package:get_it/get_it.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:taski_todo/pages/navigator/bottom_navigator_cubit.dart';
import 'package:taski_todo/repositories/task_repository/task_repository.dart';
import 'package:taski_todo/repositories/task_repository/task_repository_impl.dart';
import 'package:taski_todo/services/task_service/task_service.dart';
import 'package:taski_todo/services/task_service/task_service_impl.dart';

final GetIt sl = GetIt.instance;

void init() {
  _initRepositories();
  _initServices();
  _initCubits();
}

void _initRepositories() {
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl());
}

void _initServices() {
  sl.registerLazySingleton<TaskService>(
      () => TaskServiceImpl(repository: sl()));
}

void _initCubits() {
  sl.registerSingleton<TaskCubit>(TaskCubit(sl()));
  sl.registerFactory(() => BottomNavigatorCubit());
}
