import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/pages/completed_tasks/completed_tasks_page.dart';
import 'package:taski_todo/pages/home/home_page.dart';
import 'package:taski_todo/pages/navigator/bottom_navigator_cubit.dart';
import 'package:taski_todo/pages/navigator/bottom_navigator_state.dart';
import 'package:taski_todo/pages/search/search_page.dart';
import 'package:taski_todo/pages/widgets/create_task_modal/create_task_modal.dart';

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavigatorCubit, BottomNavigatorState>(
          builder: (context, state) {
        switch (state.selectedIndex) {
          case 0:
            return const HomePage();
          case 2:
            return SearchPage();
          case 3:
            return CompletedTasksPage();

          default:
            return const HomePage();
        }
      }),
      bottomNavigationBar:
          BlocBuilder<BottomNavigatorCubit, BottomNavigatorState>(
        builder: (context, state) {
          return SizedBox(
            height: 100,
            child: BottomNavigationBar(
              currentIndex: state.selectedIndex,
              selectedItemColor: Color(0xff007fff),
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 16,
              unselectedFontSize: 16,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/todo_grey.png',
                    width: 24,
                    height: 24,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/todo.png',
                    width: 24,
                    height: 24,
                    color: Color(0xff007fff),
                  ),
                  label: 'Todo',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/plus.png',
                    width: 24,
                    height: 24,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/plus.png',
                    width: 24,
                    height: 24,
                    color: Color(0xff007fff),
                  ),
                  label: 'Create',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/search.png',
                    width: 24,
                    height: 24,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/search.png',
                    width: 24,
                    height: 24,
                    color: Color(0xff007fff),
                  ),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/checked.png',
                    width: 24,
                    height: 24,
                  ),
                  activeIcon: Image.asset(
                    'assets/images/checked.png',
                    width: 24,
                    height: 24,
                    color: Color(0xff007fff),
                  ),
                  label: 'Done',
                ),
              ],
              onTap: (index) {
                final TextEditingController titleController =
                    TextEditingController();
                final TextEditingController noteController =
                    TextEditingController();
                if (index == 1) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    builder: (context) {
                      return CreateTaskModal(
                        titleController: titleController,
                        noteController: noteController,
                      );
                    },
                  );
                }
                context.read<BottomNavigatorCubit>().setSelectedIndex(index);
              },
            ),
          );
        },
      ),
    );
  }
}
