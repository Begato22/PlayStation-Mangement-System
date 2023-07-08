import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:playstation/models/session%20model/session_model.dart';

import '../../layouts/home layout/bloc/cubit.dart';
import '../../models/room model/room_model.dart';

void endingTime({
  required BuildContext context,
  required PlaystationHomeCubit cubit,
  required SessionModel sessionModel,
}) async {
  await cubit.updateStatusRoomDatabase('false', cubit.getSpecificRoom(sessionModel.roomId).id);
  await cubit.insertNewHistoryIntoDatabase(
    date: DateFormat('yMd').format(DateTime.now()),
    roomId: cubit.getSpecificRoom(sessionModel.roomId).id,
    startTime: sessionModel.startTime,
    endTime: DateFormat.jm().format(DateTime.now()),
    sessionType: sessionModel.sessionType,
    totalCost: sessionModel.totalCost,
  );
  await cubit.deleteSessionFromDatabase(sessionModel.id);
}

bool equalsIgnoreCase(List<RoomModel> roomList, String roomName) {
  bool value = false;
  for (var element in roomList) {
    if (element.name.toLowerCase() == roomName.toLowerCase()) {
      value = true;
    }
  }
  return value;
}
