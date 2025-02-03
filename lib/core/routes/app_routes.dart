import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taski_todo/pages/home/home_cubit.dart'; // Importa o TaskCubit
import 'package:taski_todo/pages/home/home_page.dart';
import 'package:taski_todo/pages/navigator/bottom_navigator.dart';
import 'package:taski_todo/pages/navigator/bottom_navigator_cubit.dart';
import 'package:taski_todo/pages/search/search_page.dart';

class AppRoutes {
  static const String navigator = '/';
  static const String home = '/home';
  static const String search = '/search';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case navigator:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => GetIt.I<BottomNavigatorCubit>(),
            child: BottomNavigator(),
          ),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => GetIt.I<TaskCubit>(),
            child: HomePage(),
          ),
        );
      case search:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => GetIt.I<TaskCubit>(),
            child: SearchPage(),
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}
