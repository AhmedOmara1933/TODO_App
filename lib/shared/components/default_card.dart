import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';

// ignore: must_be_immutable
class DefaultCard extends StatelessWidget {
  Map model;

  DefaultCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (value) {
        AppCubit.get(context).deleteDatabase(id: model['id'].toString());
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 55.0,
              child: Text(
                '${model['time']}',
                style: const TextStyle(
                  fontSize: 23.0,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateDatabase(status: 'done', id: '${model['id']}');
                },
                icon: const Icon(
                  Icons.check_box,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateDatabase(status: 'archived', id: '${model['id']}');
                },
                icon: const Icon(
                  Icons.archive,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }
}
