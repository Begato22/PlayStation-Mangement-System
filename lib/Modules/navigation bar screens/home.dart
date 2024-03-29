import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:playstation/layouts/home%20layout/bloc/cubit.dart';
import 'package:playstation/layouts/home%20layout/bloc/states.dart';
import 'package:playstation/shared/Materials/material_app.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../shared/componentes/components.dart';

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaystationHomeCubit, PlaystationHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PlaystationHomeCubit.get(context);
        return Scaffold(
          body: cubit.rooms.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      buildHomeTitle('Rooms Status'),
                      const SizedBox(height: 15),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: SfCircularChart(
                                  palette: const [
                                    MaterialPSApp.basicColor,
                                    MaterialPSApp.backgroundColor,
                                  ],
                                  series: <CircularSeries>[
                                    PieSeries<ChartData, String>(
                                        dataSource: [
                                          ChartData(
                                              "Online",
                                              double.parse(
                                                  '${cubit.online.length}')),
                                          ChartData(
                                              "Offline",
                                              double.parse(
                                                  '${cubit.rooms.length - cubit.online.length}')),
                                        ],
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        // Segments will explode on tap
                                        explode: true,
                                        // First segment will be exploded on initial rendering
                                        explodeIndex: 1)
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  statisticItem(
                                      'Online',
                                      cubit.online.length / cubit.rooms.length,
                                      MaterialPSApp.basicColor,
                                      true),
                                  // Spacer(),
                                  statisticItem(
                                      'Offline',
                                      (cubit.rooms.length -
                                              cubit.online.length) /
                                          cubit.rooms.length,
                                      MaterialPSApp.backgroundColor,
                                      false),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      buildHomeTitle('Rooms Statistics'),
                      const SizedBox(height: 20),
                      buildRawData(Icons.meeting_room, 'Total  Rooms',
                          '${cubit.rooms.length} Room'),
                      const SizedBox(height: 5),
                      buildRawData(Icons.online_prediction_rounded,
                          'Total Onlines', '${cubit.online.length} Room'),
                      const SizedBox(height: 5),
                      buildRawData(Icons.archive, 'Total Archive',
                          '${cubit.history.length} Session')
                    ],
                  ),
                )
              : Center(
                  child: GestureDetector(
                    onTap: () {
                      cubit.changeShowingBottomSheet();
                    },
                    child: buildEmptyReplacmentScreen(
                      lable: 'no rooms found',
                      iconData: FontAwesomeIcons.chartSimple,
                      size: 100,
                    ),
                  ),
                ),
        );
      },
    );
  }

  Container buildRawData(IconData iconData, String title, String value) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 217, 216, 216),
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const SizedBox(width: 30),
                Text(
                  "$title: ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  value,
                ),
              ],
            ),
          ),
          CircleAvatar(
              radius: 18,
              child: Icon(
                iconData,
                size: 18,
              )),
        ],
      ),
    );
  }

  Align buildHomeTitle(String title) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Row statisticItem(String title, double value, Color color, bool isCeil) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(isCeil
            ? "$title Rooms ${(value * 100).toInt()}%"
            : "$title Rooms ${(value * 100).ceil()}%")
      ],
    );
  }
}
