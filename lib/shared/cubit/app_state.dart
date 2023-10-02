part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AppChangeBottomNavBar extends AppState {}

class AppIsButtonSheetShown extends AppState {}

class AppCreateDatabase extends AppState {}

class AppInsertToDatabase extends AppState {}

class AppGetFromDatabase extends AppState {}

class AppUpdateDatabase extends AppState {}

class AppDeleteDatabase extends AppState {}
