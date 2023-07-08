// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:playstation/layouts/home%20layout/bloc/states.dart';
import 'package:playstation/models/room%20model/room_model.dart';
import 'package:playstation/models/session%20model/session_model.dart';

import 'package:sqflite/sqflite.dart';
import '../../../Modules/navigation bar screens/account_screen.dart';
import '../../../Modules/navigation bar screens/home._screendart';
import '../../../Modules/navigation bar screens/online_screen.dart';
import '../../../Modules/navigation bar screens/rooms_screen.dart';
import '../../../Modules/navigation bar screens/setting.dart';
import '../../../models/history model/history_model.dart';
import '../../../shared/Materials/material_app.dart';

class PlaystationHomeCubit extends Cubit<PlaystationHomeStates> {
  PlaystationHomeCubit() : super(PlaystationHomeInitialStates());

  static PlaystationHomeCubit get(context) => BlocProvider.of(context);

  bool isHidden = true;
  IconData passwordVisibilityIcon = Icons.visibility;
  void changeVisibility() {
    isHidden = !isHidden;
    if (isHidden) {
      passwordVisibilityIcon = Icons.visibility;
    } else {
      passwordVisibilityIcon = Icons.visibility_off;
    }
    emit(ChangeVisibility());
  }

  int currentPage = 2;
  List screensTitle = [
    'Home',
    'Online',
    'Rooms',
    'History',
    'Setting',
  ];
  List screens = [
    const Home(),
    const OnlineScreen(),
    RoomsScreen(),
    const AccountScreen(),
    const SettingPage(),
  ];

  List<Widget> navigationBarItem = const [
    Icon(Icons.home, size: 25, color: MaterialPSApp.whiteColor),
    Icon(Icons.online_prediction, size: 25, color: MaterialPSApp.whiteColor),
    Icon(MaterialPSApp.playstationIcon, color: MaterialPSApp.whiteColor),
    Icon(Icons.history, size: 25, color: MaterialPSApp.whiteColor),
    Icon(Icons.settings, size: 25, color: MaterialPSApp.whiteColor),
  ];

  void changeNavigationBarPage(int index) {
    currentPage = index;
    emit(ChangeNavigationBarPage());
  }

//********************************** Radio Button **********************************
  var groupValue = 1;
  var groupValue1 = 1;
  void changeRadioValue(value) {
    groupValue = value;
    emit(ChangeRadio());
  }
//********************************** Radio Button **********************************

//**********************************Check Box **********************************
  bool isChecked = false;
  void changeCheckBox(bool? value) {
    isChecked = value!;
    emit(ChangeCheck());
  }
//**********************************Check Box **********************************

//********************************** Bottom Sheet **********************************
  bool show = false;

  void changeShowingBottomSheet() {
    show = !show;
    emit(ShowBottomSheet());
  }

  Widget? showBottomSheet({required Widget widget}) {
    if (show) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return widget;
        },
      );
    } else {
      return null;
    }
  }
  //********************************** Bottom Sheet **********************************

  //********************************** Dialog **********************************
  int duration = 0;
  void changeDuration(int value) {
    duration = value;
    print("PlaystationHomeChangeDurationState $duration");
    emit(ChangeDuration());
  }
  //********************************** Dialog **********************************

  // ****************************************** Databse ******************************************
  List<RoomModel> rooms = [];

  late Database database;
  void createDatabase() async {
    await openDatabase(
      "playstation.db",
      version: 1,
      onCreate: (Database database, int version) async {
        // When creating the db, create the table
        try {
          await database.execute('CREATE TABLE Room (id INTEGER PRIMARY KEY, name TEXT, roomType TEXT, hourPrice INTEGER, isBusy TEXT)');
          print("Room Table is created !");
        } catch (onError) {
          print("This err in creating Room Table ${onError.toString()}");
        }
        try {
          await database.execute(
              'CREATE TABLE Session (id INTEGER PRIMARY KEY, room_id INTEGER, duration DOUBLE,  start_time TEXT, end_time TEXT, session_type TEXT, total_cost DOUBLE,isOpenTime TEXT)');
          print("Session Table is created !");
        } catch (onError) {
          print("This err in creating Session Table ${onError.toString()}");
        }

        try {
          await database.execute(
              'CREATE TABLE History (id INTEGER PRIMARY KEY, room_id INTEGER, date TEXT, start_time TEXT, end_time TEXT, session_type TEXT, total_cost DOUBLE)');
          print("History Table is created !");
        } catch (onError) {
          print("This err in creating History Table ${onError.toString()}");
        }
      },
      onOpen: (database) async {
        // (database);
        await getAllRoomsFromDatabase(database);
        await getAllSessionFromDatabase(database);
        await getAllHistoryFromDatabase(database);
        // print("Database is opened !");
      },
    ).then(
      (value) {
        database = value;
        emit(CreateDatabase());
      },
    );
  }

  Future<dynamic> insertNewRoomIntoDatabase({
    required String name,
    required String roomType,
    required int hourPrice,
  }) async {
    return await database.transaction(
      (txn) async {
        try {
          await txn.rawInsert('INSERT INTO Room(name, roomType, hourPrice, isBusy) VALUES("$name", "$roomType", $hourPrice, "false")');
          getLastRoomFromDatabase(database);
          emit(InsertNewRoom());
        } catch (onError) {
          // print("err in insert operation (room) ${onError.toString()}");
        }
      },
    );
  }

  Future<void> getLastRoomFromDatabase(database) async {
    try {
      var value = await database.rawQuery('select * from Room ORDER BY id DESC LIMIT 1');
      for (var element in value) {
        rooms.add(
          RoomModel(
            id: element['id'],
            name: element['name'],
            deviceType: element['roomType'],
            hourPrice: element['hourPrice'],
            isBusy: parseBool(element['isBusy']),
          ),
        );
      }
      // print(rooms);
      emit(GetLastRoom());
    } catch (e) {
      // print(e.toString());
    }
  }

  Future<void> getAllRoomsFromDatabase(database) async {
    rooms = [];
    try {
      var value = await database.rawQuery('select * from Room');
      for (var element in value) {
        // print("helooooooooooooooo 2");
        rooms.add(
          RoomModel(
            id: element['id'],
            name: element['name'],
            deviceType: element['roomType'],
            hourPrice: element['hourPrice'],
            isBusy: parseBool(element['isBusy']),
          ),
        );
      }
      // print("we get all room $rooms");
      emit(GetAllRooms());
    } catch (e) {
      // print(e.toString());
    }
  }

  Future<dynamic> insertNewSessionIntoDatabase({
    required double duration,
    required int roomId,
    required String startTime,
    required String endTime,
    required String sessionType,
    required double totalCost,
    required String isOpenTime,
  }) async {
    // duration start_time  end_time  session_type  total_cost
    return await database.transaction(
      (txn) async {
        try {
          await txn.rawInsert(
              'INSERT INTO Session(room_id , duration, start_time, end_time , session_type , total_cost, isOpenTime) VALUES($roomId, $duration, "$startTime", "$endTime", "$sessionType", $totalCost, "$isOpenTime")');
          getLastSessionFromDatabase(database);
          emit(InsertNewSession());
        } catch (onError) {
          // print("err in insert operation (session) ${onError.toString()}");
        }
      },
    );
  }

  List<SessionModel> online = [];

  Future<void> getAllSessionFromDatabase(database) async {
    try {
      online = [];
      var value = await database.rawQuery('select * from Session');
      for (var element in value) {
        online.add(
          SessionModel(
            id: element['id'],
            roomId: element['room_id'],
            duration: element['duration'],
            startTime: element['start_time'],
            endTime: element['end_time'],
            sessionType: element['start_time'],
            totalCost: element['total_cost'],
            isOpenTime: parseBool(element['isOpenTime']),
          ),
        );
      }
      // print(online);
      emit(GetAllSessions());
    } catch (e) {
      // print(e.toString());
    }
  }

  Future<void> getLastSessionFromDatabase(database) async {
    try {
      var value = await database.rawQuery('select * from Session ORDER BY id DESC LIMIT 1');
      for (var element in value) {
        online.add(
          SessionModel(
            id: element['id'],
            roomId: element['room_id'],
            duration: element['duration'],
            startTime: element['start_time'],
            endTime: element['end_time'],
            sessionType: element['session_type'],
            totalCost: element['total_cost'],
            isOpenTime: parseBool(element['isOpenTime']),
          ),
        );
      }
      // print(online);
      emit(GetLastSession());
    } catch (e) {
      // print(e.toString());
    }
  }

  Future<dynamic> insertNewHistoryIntoDatabase({
    required int roomId,
    required String date,
    required String startTime,
    required String endTime,
    required String sessionType,
    required double totalCost,
  }) async {
    // duration start_time  end_time  session_type  total_cost
    return await database.transaction(
      (txn) async {
        try {
          await txn.rawInsert(
              'INSERT INTO History(date, room_id , start_time, end_time , session_type , total_cost) VALUES("$date" , $roomId ,"$startTime", "$endTime", "$sessionType", $totalCost)');
          getLastHistoryFromDatabase(database);
          emit(InsertNewHistory());
        } catch (onError) {
          // print("err in insert operation (history) ${onError.toString()}");
        }
      },
    );
  }

  List<HistoryModel> history = [];
  List<String> historyDates = [];
  Map<String, List<HistoryModel>> datedSession = {};

  Future<void> getAllHistoryFromDatabase(database) async {
    try {
      history = [];
      var value = await database.rawQuery('select * from History');
      for (var element in value) {
        history.add(
          HistoryModel(
            id: element['id'],
            roomId: element['room_id'],
            date: element['date'],
            startTime: element['start_time'],
            endTime: element['end_time'],
            sessionType: element['session_type'],
            totalCost: element['total_cost'],
          ),
        );
        historyDates.add(element['date']);
      }
      historyDates = historyDates.toSet().toList();

      historyDates.forEach(
        (date) {
          List<HistoryModel> list = [];
          history.forEach(
            (session) {
              if (date == session.date) {
                list.add(session);
              }
            },
          );
          datedSession.addAll({date: list});
        },
      );
      print("historyDates ${historyDates.toSet().toList()}");
      emit(GetAllHistory());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getLastHistoryFromDatabase(database) async {
    try {
      var value = await database.rawQuery('select * from History ORDER BY id DESC LIMIT 1');
      for (var element in value) {
        history.add(
          HistoryModel(
            id: element['id'],
            roomId: element['room_id'],
            date: element['date'],
            startTime: element['start_time'],
            endTime: element['end_time'],
            sessionType: element['session_type'],
            totalCost: element['total_cost'],
          ),
        );
        historyDates.add(element['date']);
      }
      historyDates = historyDates.toSet().toList();

      historyDates.forEach(
        (date) {
          List<HistoryModel> list = [];
          history.forEach(
            (session) {
              if (date == session.date) {
                list.add(session);
              }
            },
          );
          datedSession.addAll({date: list});
        },
      );
      emit(GetLastHistory());
    } catch (e) {
      // print(e.toString());
    }
  }

//  Future< List<Map<String, dynamic>>>? getSessionByRoomIdFromDatabase(
//       {database, required int roomId}) {
//     database.rawQuery('select * from Session where room_id = $roomId ').then(
//       (value) {
  // print("object from getSessionByRoomIdFromDatabase. ");
  // print("object from getSessionByRoomIdFromDatabase. ${value.data}");
//         return value;
//       },
//     );

  // }

  Future<void> updateStatusRoomDatabase(String isBusy, int id) async {
    await database.rawUpdate('UPDATE Room SET isBusy = ? WHERE id = ?', [isBusy, id]);
    getSpecificRoom(id).isBusy = parseBool(isBusy);
    print("@@ object = ${getSpecificRoom(id).isBusy}");
    emit(UpdateStatus());
  }

  Future<void> deleteSessionFromDatabase(int id) async {
    await database.rawDelete('DELETE FROM Session WHERE id = ?', [id]);
    online.removeWhere((element) => element.id == id);
    emit(DeleteSession());
  }

  Future<void> deleteRoomFromDatabase(int id) async {
    await database.rawDelete('DELETE FROM Room WHERE id = ?', [id]);
    rooms.removeWhere((element) => element.id == id);
    await database.rawDelete('DELETE FROM History WHERE room_id = ?', [id]);
    history.removeWhere((element) => element.roomId == id);
    emit(DeleteRoom());
  }

  Future<void> deleteAllHistoryFromDatabase() async {
    await database.rawDelete('DELETE  FROM History');
    history = [];
    emit(ClearHistory());
  }

  Future<void> deleteDatabase() => databaseFactory.deleteDatabase('playstation.db').then(
        (value) {
          // print("DB Deleted.");
        },
      );

  // Future<void> getAllDates() async {
  //   var value = await database
  //     .rawQuery('select date from History');
  //     for (var item in value) {
  //       historyDates.add(item);
  //     }
  // }

  bool parseBool(String s) {
    if (s.toLowerCase() == 'true') {
      return true;
    } else if (s.toLowerCase() == 'false') {
      return false;
    }

    throw '"$s" can not be parsed to boolean.';
  }

  DateTime getDateTimeOfSpecificSession(int roomId) {
    SessionModel session = online.firstWhere((element) => element.roomId == roomId);
    DateTime endTime = DateTime.parse(session.endTime); // 9:00 pm
    DateTime now = DateTime.now(); // 10:00 pm
    DateTime duration = endTime.subtract(Duration(
      hours: now.hour,
      minutes: now.minute,
      seconds: now.second,
      milliseconds: now.millisecond,
    ));
    return duration;
  }

  RoomModel getSpecificRoom(int roomId) {
    return rooms.firstWhere((element) => element.id == roomId);
  }

  SessionModel getSpecificSession(int roomId) {
    return online.firstWhere((element) => element.roomId == roomId);
  }

  Future<void> checkList(
    cubit,
    context,
  ) async {
    if (online.isNotEmpty) {
      online.forEach(
        (element) async {
          if (DateTime.now().isAfter(DateTime.parse(element.endTime))) {
            await finishTime(cubit, context, element.roomId);
            emit(CheckList());
          }
        },
      );
    }
  }

  Future<void> finishTime(
    PlaystationHomeCubit cubit,
    BuildContext context,
    int roomId,
  ) async {
    SessionModel session = getSpecificSession(roomId);
    print(' ## ${session.startTime} end time:  ${DateTime.now()}');
    DateTime startTime = DateTime.parse(session.startTime);
    DateTime endTime = DateTime.now();
    DateTime duration = endTime.subtract(Duration(
      hours: startTime.hour,
      minutes: startTime.minute,
      seconds: startTime.second,
      milliseconds: startTime.millisecond,
    ));
    double totalHours = (duration.hour * 60 + duration.minute + duration.second / 60) / 60;
    double totalCost = session.sessionType.contains('Single')
        ? totalHours * getSpecificRoom(session.roomId).hourPrice
        : totalHours * getSpecificRoom(session.roomId).hourPrice * 1.75;
    await updateStatusRoomDatabase('false', getSpecificRoom(session.roomId).id);
    await database.rawUpdate('UPDATE Session SET end_time = ? WHERE id = ?', [endTime.toString(), session.id]);
    print(" ^^ UPDATE Session");
    await database.rawUpdate('UPDATE Session SET total_cost = ? WHERE id = ?', [totalCost, session.id]);
    print(" ^^ UPDATE Session");
    await insertNewHistoryIntoDatabase(
        roomId: session.roomId,
        date: DateFormat('yMd').format(DateTime.now()),
        startTime: session.startTime,
        endTime: endTime.toString(),
        sessionType: session.sessionType,
        totalCost: totalCost);
    await deleteSessionFromDatabase(session.id);
    emit(FinishTime());
  }
}

// ****************************************** Databse ******************************************
