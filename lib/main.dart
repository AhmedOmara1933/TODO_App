import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit/app_cubit.dart';
import 'package:todo_app/shared/cubit/bloc_observer.dart';
import 'layout/home_layout.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..createDataBase())
      ],
      child: SafeArea(
        child: MaterialApp(
          home: HomeLayout(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
