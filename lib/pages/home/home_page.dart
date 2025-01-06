import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/models/task_model.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:taski_todo/pages/home/widgets/task_card.dart';
import 'package:taski_todo/pages/home/home_state.dart'; // Certifique-se de importar os estados

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final taskCubit = GetIt.I<TaskCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      taskCubit.loadTasks();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_box,
                  color: Colors.blue,
                ),
                SizedBox(width: 8),
                Text(
                  'Taski',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'John',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Welcome, ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'John.',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4),
            Text(
              "You've got 7 tasks to do.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<TaskCubit, HomeState>(
                bloc: taskCubit,
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is HomeLoaded) {
                    return ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final task = state.tasks[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: TaskCard(
                            title: task.title,
                            subtitle: 'Task description...',
                          ),
                        );
                      },
                    );
                  } else if (state is HomeError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            _showCreateTaskModal(context);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/todo.png',
              width: 24,
              height: 24,
            ),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/plus.png',
              width: 24,
              height: 24,
            ),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/search.png',
              width: 24,
              height: 24,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/checked.png',
              width: 24,
              height: 24,
            ),
            label: 'Done',
          ),
        ],
      ),
    );
  }

  void _showCreateTaskModal(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController noteController = TextEditingController();

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
        return FractionallySizedBox(
          heightFactor: 0.5,
          child: Padding(
            padding: const EdgeInsets.only(top: 34, left: 42),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: Color(0xFFC6CFDC),
                          width: 2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: "What's on your mind?",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[400],
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/leading.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: noteController,
                        decoration: InputDecoration(
                          hintText: 'Add a note...',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[400],
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 50, top: 40),
                      child: TextButton(
                        onPressed: () {
                          final taskTitle = titleController.text;
                          if (taskTitle.isNotEmpty) {
                            context
                                .read<TaskCubit>()
                                .addTask(TaskModel(title: taskTitle));
                          }
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Create',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
