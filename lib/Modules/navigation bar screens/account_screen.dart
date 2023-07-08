import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../layouts/home layout/bloc/cubit.dart';
import '../../layouts/home layout/bloc/states.dart';
import '../../shared/Materials/material_app.dart';
import '../../shared/components/components.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<PlaystationHomeCubit, PlaystationHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PlaystationHomeCubit.get(context);
        return Scaffold(
          body: cubit.historyDates.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: size.width - 50,
                    height: size.height,
                    child: ListView.separated(
                      shrinkWrap: false,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, outerIndex) {
                        return outerIndex == 0
                            ? Container()
                            : SizedBox(
                                width: 100,
                                height: 160 * cubit.datedSession[cubit.historyDates[outerIndex - 1]]!.length.toDouble(),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return buildHistoryCard(cubit, index, cubit.historyDates[outerIndex - 1]);
                                  },
                                  itemCount: cubit.datedSession[cubit.historyDates[outerIndex - 1]]!.length,
                                ),
                              );
                      },
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: customDividerText(cubit.historyDates[index]),
                      ),
                      itemCount: cubit.historyDates.length + 1,
                    ),
                  ),
                )
              : Center(
                  child: buildEmptyReplacementScreen(
                    label: 'No history found now',
                    iconData: Icons.history,
                    size: 90,
                  ),
                ),
        );
      },
    );
  }

  Card buildHistoryCard(PlaystationHomeCubit cubit, int index, String date) {
    String startTime = DateFormat.jm().format(DateTime.parse(cubit.datedSession[date]![index].startTime));
    String endTime = DateFormat.jm().format(DateTime.parse(cubit.datedSession[date]![index].endTime));
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.grey[200],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 30,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[300],
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 70),
                              Text(
                                "${cubit.datedSession[date]![index].sessionType} - ${cubit.getSpecificRoom(cubit.datedSession[date]![index].roomId).deviceType}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      PhysicalShape(
                        shadowColor: Colors.grey,
                        elevation: 10,
                        clipper: const ShapeBorderClipper(shape: CircleBorder()),
                        color: Colors.black,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[500],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const FaIcon(FontAwesomeIcons.gamepad),
                              const SizedBox(width: 3),
                              Text(
                                cubit.getSpecificRoom(cubit.datedSession[date]![index].roomId).name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    rowData('Date: ', cubit.datedSession[date]![index].date, Icons.date_range, Colors.black),
                    const SizedBox(height: 3),
                    rowData('Start Time: ', startTime, Icons.watch, Colors.black),
                    const SizedBox(height: 3),
                    rowData('End   Time: ', endTime, Icons.watch, Colors.red),
                  ],
                ),
                const Spacer(),
                PhysicalShape(
                  shadowColor: Colors.grey,
                  elevation: 5,
                  clipper: const ShapeBorderClipper(shape: CircleBorder()),
                  color: Colors.black,
                  child: CircleAvatar(
                    radius: 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${cubit.datedSession[date]![index].totalCost.ceil()}'),
                        const Text(
                          ' EG',
                          style: TextStyle(fontSize: 8),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget rowData(String title, String data, IconData iconData, Color iconColor) {
    return Row(
      children: [
        Icon(
          iconData,
          color: iconColor,
          size: 10,
        ),
        const SizedBox(width: 3),
        Text(
          title,
          style: const TextStyle(fontSize: 12),
        ),
        Text(
          data,
          style: const TextStyle(color: MaterialPSApp.basicColor, fontSize: 12),
        ),
      ],
    );
  }
}
