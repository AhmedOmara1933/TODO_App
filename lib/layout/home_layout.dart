import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/components/default_bottomnavbar.dart';
import 'package:todo_app/shared/components/default_textformfield.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';

// ignore: must_be_immutable
class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var taskTitle = TextEditingController();
  var taskTime = TextEditingController();
  var taskDate = TextEditingController();

  HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AppInsertToDatabase) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text(
              'TODO App',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          bottomNavigationBar: DefaultBottomNavBar(
              unselectedItemColor:Colors.grey[700],
              selectedIndex: cubit.currentIndex,
              onItemSelected: (value) {
                cubit.changeBottomNavBar(index: value);
              }
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cubit.isBottomSheet) {
                if (formKey.currentState!.validate()) {
                  cubit.insertToDatabase(
                      title: taskTitle.text,
                      time: taskTime.text,
                      date: taskDate.text);
                  cubit.isBottomSheetShown(isShown: false, icon: Icons.add);
                }
              } else {
                cubit.isBottomSheetShown(isShown: true, icon: Icons.edit);
                scaffoldKey.currentState!
                    .showBottomSheet((context) {
                  return Container(
                    color: Colors.grey[100],
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: DefaultTextFormField(
                                text: 'Task Title',
                                prefixicon: Icons.text_fields_outlined,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Task Title must be fill';
                                  }
                                  return null;
                                },
                                controller: taskTitle),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0),
                            child: DefaultTextFormField(
                                text: 'Task Time',
                                onTap: () {
                                  showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                      .then((value) {
                                    taskTime.text = value!.format(context);
                                  });
                                },
                                prefixicon: Icons.watch_later_outlined,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Task Time must be fill';
                                  }
                                  return null;
                                },
                                controller: taskTime),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: DefaultTextFormField(
                                text: 'Task Date',
                                prefixicon: Icons.calendar_month_sharp,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                  ).then((value) {
                                    taskDate.text =
                                        DateFormat.yMMMEd().format(value!);
                                  });
                                },
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Task Time must be fill';
                                  }
                                  return null;
                                },
                                controller: taskDate),
                          ),
                        ],
                      ),
                    ),
                  );
                })
                    .closed
                    .then((value) {
                  cubit.isBottomSheetShown(isShown: false, icon: Icons.add);
                });
              }
            },
            child: Icon(cubit.fbiIcon),
          ),
          body: cubit.screans[cubit.currentIndex],
        );
      },
    );
  }
}
