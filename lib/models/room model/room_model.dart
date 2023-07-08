class RoomModel {
  late int id;
  late String name;
  late String deviceType;
  late int hourPrice;
  late bool isBusy ;

  RoomModel({
    required this.id,
    required this.name,
    required this.deviceType,
    required this.hourPrice,
    required this.isBusy,
  });
}
