import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/default_card.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';

class Archived extends StatelessWidget {
  const Archived({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var tasks=AppCubit.get(context).archivedTasks;
        return ConditionalBuilder(
            condition: tasks.isNotEmpty,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => DefaultCard(
                  model: tasks[index],
                ),
                separatorBuilder: (context, index) =>  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(
                    height: 1.0,
                    color: Colors.grey[800],
                  ),
                ),
                itemCount:tasks.length
            ),
            fallback: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu,
                    size: 100.0,
                    color: Colors.grey[500],
                  ),
                  const Text(
                    'No Tasks Yet, Please Add Some Tasks',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black54
                    ),
                  ),
                ],
              ),
            ),
        );
      },
    );
  }
}
