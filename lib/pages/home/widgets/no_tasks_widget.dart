import 'package:flutter/material.dart';
import 'package:taski_todo/pages/widgets/create_task_modal/create_task_modal.dart';

class NoTasksWidget extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController noteController;

  const NoTasksWidget({
    super.key,
    required this.titleController,
    required this.noteController,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/undraw.png'),
          const SizedBox(height: 30),
          Text(
            'You have no task listed.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
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
            },
            child: Container(
              width: 151,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0XFFE6F2FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add,
                    size: 27,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Create task',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
