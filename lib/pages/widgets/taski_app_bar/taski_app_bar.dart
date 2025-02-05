import 'package:flutter/material.dart';
import 'package:taski_todo/core/ui/styles/app_text_styles.dart';

class TaskiAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isTesting;
  const TaskiAppBar({this.isTesting = false, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Color(0XFF007FFF),
                ),
                child: isTesting
                    ? Image.asset(
                        'assets/images/check.png') // Usa imagem local durante o teste
                    : Image.network(
                        // Usa imagem de rede em produção
                        'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                      ),
              ),
              const SizedBox(width: 8),
              Text(
                'Taski',
                style: context.textStyles.textSemiBold,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'John',
                style: context.textStyles.textSemiBold.copyWith(fontSize: 22),
              ),
              const SizedBox(width: 8),
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
