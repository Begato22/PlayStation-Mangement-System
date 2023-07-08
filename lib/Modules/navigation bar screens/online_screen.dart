import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:playstation/layouts/home%20layout/bloc/cubit.dart';
import 'package:playstation/layouts/home%20layout/bloc/states.dart';
import '../../shared/Materials/material_app.dart';
import '../../shared/components/components.dart';

class OnlineScreen extends StatelessWidget {
  const OnlineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaystationHomeCubit, PlaystationHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PlaystationHomeCubit.get(context);

        return Scaffold(
          body: cubit.online.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      // String startTime = DateFormat('h:mm a').format(DateFormat('h:mm a').parse(cubit.online[index].startTime));
                      // String endTime = DateFormat('h:mm a').format(DateFormat('h:mm a').parse(cubit.online[index].endTime));
                      String startTime = DateFormat.jm().format(DateTime.parse(cubit.online[index].startTime));
                      String endTime = DateFormat.jm().format(DateTime.parse(cubit.online[index].endTime));
                      // String endTime = DateFormat.jm().parse(cubit.online[index].endTime).toString();
                      return Card(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          color: Colors.grey[200],
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    cubit.getSpecificRoom(cubit.online[index].id).name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.timer, color: Colors.grey, size: 18),
                                  const SizedBox(width: 5),
                                  buildTimer(
                                    cubit,
                                    context,
                                    cubit.online[index],
                                    cubit.getDateTimeOfSpecificSession(
                                      cubit.getSpecificRoom(cubit.online[index].roomId).id,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: MaterialPSApp.basicColor,
                                thickness: 0.5,
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      rowData('Start Time:', startTime, Icons.watch, Colors.black),
                                      const SizedBox(height: 5),
                                      rowData(
                                          'Total Time: ',
                                          cubit.online[index].isOpenTime ? 'Waiting' : '${cubit.online[index].duration.ceil()} min',
                                          Icons.share_arrival_time_rounded,
                                          Colors.deepOrangeAccent),
                                    ],
                                  ),
                                  const Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      rowData('End Time: ', cubit.online[index].isOpenTime ? 'Waiting' : endTime, Icons.watch, Colors.red),
                                      const SizedBox(height: 5),
                                      rowData(
                                          'Total Cost: ',
                                          cubit.online[index].isOpenTime ? 'Waiting' : '${cubit.online[index].totalCost.ceil()} EG',
                                          Icons.monetization_on,
                                          Colors.green),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemCount: cubit.online.length,
                  ),
                )
              : Center(
                  child: buildEmptyReplacementScreen(
                    label: 'no active rooms now',
                    iconData: Icons.online_prediction_outlined,
                    size: 90,
                  ),
                ),
        );
      },
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
