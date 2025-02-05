import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:taski_todo/pages/home/home_state.dart';
import 'package:taski_todo/pages/widgets/taski_app_bar/taski_app_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskCubit = BlocProvider.of<TaskCubit>(context);

    return Scaffold(
      appBar: TaskiAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (query) {
                taskCubit.searchTasks(query);
              },
              decoration: InputDecoration(
                labelText: 'Search Tasks',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    width: 2,
                    color: Color(0xff0c8ce9),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Color(0xff0c8ce9),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(
                    color: Color(0xff0c8ce9),
                  ),
                ),
                prefixIcon: Image.asset(
                  'assets/images/search.png',
                  width: 24,
                  height: 24,
                  color: Colors.blue,
                ),
                suffixIcon: Image.asset(
                  'assets/images/close.png',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is TaskLoaded && state.tasks.isNotEmpty) {
                    return ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final task = state.tasks[index];
                        return ListTile(
                          title: Text(task.title),
                          subtitle: Text(task.subtitle),
                        );
                      },
                    );
                  } else if (state is TaskLoaded && state.tasks.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/undraw.png',
                          ),
                          Text('No result found.'),
                        ],
                      ),
                    );
                  } else if (state is TaskError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
