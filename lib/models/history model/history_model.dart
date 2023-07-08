
class HistoryModel {
  late int id;
  late int roomId;
  late String date;
  late double duration;
  late String startTime;
  late String endTime;
  late String sessionType;
  late double totalCost;

  HistoryModel({
    required this.id,
    required this.roomId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.sessionType,
    required this.totalCost,
  });
}
