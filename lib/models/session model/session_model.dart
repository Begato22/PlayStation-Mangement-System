class SessionModel {
  late int id;
  late int roomId;
  late double duration;
  late String startTime;
  late String endTime;
  late String sessionType;
  late double totalCost;
  late bool isOpenTime;

  SessionModel({
    required this.id,
    required this.roomId,
    required this.duration,
    required this.startTime,
    required this.endTime,
    required this.sessionType,
    required this.totalCost,
    required this.isOpenTime ,
  });
}
