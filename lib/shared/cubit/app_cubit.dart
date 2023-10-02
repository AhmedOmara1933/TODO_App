import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../../modules/archived.dart';
import '../../modules/done.dart';
import '../../modules/task.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screans = [const Task(), const Done(), const Archived()];

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  //todo//////////////////////// changeBottomNavBar/////////////////////////////////
  int currentIndex = 0;

  void changeBottomNavBar({required index}) {
    currentIndex = index;
    emit(AppChangeBottomNavBar());
  }

//todo////////////////////////changeBottomSheet/////////////////////////////////////
  IconData fbiIcon = Icons.add;
  bool isBottomSheet = false;

  void isBottomSheetShown({
    required bool isShown,
    required IconData icon,
  }) {
    isBottomSheet = isShown;
    fbiIcon = icon;
    emit(AppIsButtonSheetShown());
  }

//todo//////////////////////////sqflite database///////////////////////////////

  Database? database;

  void createDataBase() {
    openDatabase('todo2.db', version: 2, onCreate: (database, version) {
      if (kDebugMode) {
        print('database is created');
      }
      database
          .execute(
              "CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,time TEXT,date TEXT,status TEXT)")
          .then((value) {
        if (kDebugMode) {
          print('Table is created');
        }
      });
    }, onOpen: (database) {
      if (kDebugMode) {
        print('database is opened');
      }
      getFromDatabase(database);
    }).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database!.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks(title,time,date,status) VALUES("$title","$time","$date","new")')
          .then((value) {
        if (kDebugMode) {
          print('$value inserted succeed');
        }
        emit(AppInsertToDatabase());
        getFromDatabase(database);
      });
    });
  }

  void getFromDatabase(database) async {
    await database!.rawQuery('SELECT *FROM tasks').then((value) {
      newTasks = [];
      doneTasks = [];
      archivedTasks = [];
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(AppGetFromDatabase());
    });
  }

  void updateDatabase({required String status, required String id}) async {
    await database!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      emit(AppUpdateDatabase());
      getFromDatabase(database);
    });
  }

  void deleteDatabase({required String id})async
  {
    await database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value){
      getFromDatabase(database);
      emit(AppDeleteDatabase());
    });

  }

}
