import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski_todo/core/ui/styles/app_text_styles.dart';
import 'package:taski_todo/pages/home/home_cubit.dart';
import 'package:validatorless/validatorless.dart';

class CreateTaskModal extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController noteController;
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Chave para o formulário

  CreateTaskModal({
    super.key,
    required this.titleController,
    required this.noteController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Padding(
          padding: const EdgeInsets.only(top: 34, left: 42),
          child: Form(
            key: _formKey, // Associa o formulário à chave
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
                          color: const Color(0xFFC6CFDC),
                          width: 2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: "What's on your mind?",
                        ),
                        validator: Validatorless.required('Title is required'),
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
                      child: TextFormField(
                        controller: noteController,
                        decoration: InputDecoration(
                          hintText: 'Add a note...',
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.required('Note is required'),
                        ]),
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
                        onPressed: () => _submitTask(context),
                        child: Text(
                          'Create',
                          style: context.textStyles.textSemiBold.copyWith(
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitTask(BuildContext context) {
    // 1. Valida o formulário
    if (!_formKey.currentState!.validate()) return;

    // 2. Lê os valores dos controladores
    final taskTitle = titleController.text;
    final taskNote = noteController.text;

    // 3. Adiciona a tarefa usando o TaskCubit
    context.read<TaskCubit>().addTask(taskTitle, taskNote);

    // 4. Fecha o modal
    Navigator.pop(context);
  }
}
