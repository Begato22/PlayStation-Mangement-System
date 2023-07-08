import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:playstation/layouts/home%20layout/bloc/cubit.dart';
import 'package:playstation/layouts/home%20layout/bloc/states.dart';
import 'package:playstation/shared/Materials/material_app.dart';
import 'package:playstation/shared/components/components.dart';
import 'package:playstation/shared/components/constant.dart';

class RoomsScreen extends StatelessWidget {
  RoomsScreen({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final hourPriceController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaystationHomeCubit, PlaystationHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PlaystationHomeCubit.get(context);
        // cubit.checkList(cubit, context);
        return Scaffold(
          body: cubit.rooms.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.all(20),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: cubit.rooms.length + 1,
                    itemBuilder: (context, index) {
                      return index == cubit.rooms.length
                          ? Center(
                              child: GestureDetector(
                                onTap: () {
                                  // cubit.changeShowingBottomSheet();
                                  showModalBottomSheet(
                                    context: context,
                                    elevation: 10,
                                    builder: (context) {
                                      return buildBottomSheetChild(context);
                                    },
                                  );
                                },
                                child: buildEmptyReplacementScreen(
                                  label: 'add new room',
                                  iconData: Icons.add,
                                  size: 40,
                                ),
                              ),
                            )
                          : buildGridItem(cubit, context, index);
                    },
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.25,
                    ),
                  ),
                )
              : Center(
                  child: GestureDetector(
                    onTap: () {
                      // cubit.changeShowingBottomSheet();
                      showModalBottomSheet(
                        context: context,
                        elevation: 10,
                        builder: (context) {
                          return buildBottomSheetChild(context);
                        },
                      );
                    },
                    child: buildEmptyReplacementScreen(label: 'add new room', iconData: Icons.add, size: 100),
                  ),
                ),
          // bottomSheet: cubit.showBottomSheet(
          //   widget: buildBottomSheetChild(context),
          // ),
        );
      },
    );
  }

  Widget buildGridItem(PlaystationHomeCubit cubit, context, int index) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: MaterialPSApp.basicColor,
            child: Row(
              children: [
                //this row for name + min room word
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 6,
                      backgroundColor: Colors.white,
                    ),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: cubit.rooms[index].isBusy ? Colors.green : Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Text(
                  cubit.rooms[index].name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    if (cubit.rooms[index].isBusy) {
                      showDialogAlert(
                        context: context,
                        message: 'Your Room is working now please wait until it finish its time and then you can remove it.',
                        url: 'note',
                        needOk: false,
                      );
                    } else {
                      showDialogAlert(
                        context: context,
                        message:
                            "Are you sure you need to delete ${cubit.rooms[index].name}?\nNote: That's will delete all history session of this room.",
                        url: 'sure',
                        onOk: () => cubit.deleteRoomFromDatabase(cubit.rooms[index].id),
                        needCancel: true,
                      );
                    }
                  },
                  child: const FaIcon(
                    // ignore: deprecated_member_use
                    FontAwesomeIcons.remove,
                    color: Colors.grey,
                    size: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          rowDataItem(
            cubit.rooms[index].deviceType,
            MaterialPSApp.playstationIcon,
          ),
          rowDataItem(
            '${cubit.rooms[index].hourPrice} EG',
            Icons.attach_money_outlined,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: roomCardButton(
              context: context,
              label: 'start time',
              isDisabled: cubit.rooms[index].isBusy,
              onPressed: () {
                if (cubit.rooms[index].isBusy) {
                  return null;
                } else {
                  var durationController = TextEditingController();
                  showDialog(
                    context: context,
                    builder: (ctx) => BlocConsumer<PlaystationHomeCubit, PlaystationHomeStates>(
                      listener: (ctx, state) {},
                      builder: (ctx, state) {
                        return buildInsertSessionFieldBox(
                          cubit,
                          index,
                          durationController,
                          ctx,
                        );
                      },
                    ),
                  );
                }
              },
              duration: cubit.rooms[index].isBusy ? cubit.getDateTimeOfSpecificSession(cubit.rooms[index].id) : null,
              sessionModel: cubit.rooms[index].isBusy ? cubit.getSpecificSession(cubit.rooms[index].id) : null,
              cubit: cubit,
            ),
          ),
          if (cubit.rooms[index].isBusy)
            Center(
              child: GestureDetector(
                onTap: () async {
                  showDialogAlert(
                    context: context,
                    message: "Are you sure you want to Finish Time of room (${cubit.rooms[index].name}) ?",
                    url: 'sleep',
                    needCancel: true,
                    onOk: () async {
                      return await cubit.finishTime(cubit, context, cubit.rooms[index].id);
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FaIcon(FontAwesomeIcons.circleExclamation, size: 14, color: Colors.red),
                    SizedBox(width: 5),
                    Text(
                      "Finish Time",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  AlertDialog buildInsertSessionFieldBox(
    PlaystationHomeCubit cubit,
    int index,
    TextEditingController durationController,
    context,
  ) {
    var formKey = GlobalKey<FormState>();
    return AlertDialog(
      title: Text(
        'Add new session to ${cubit.rooms[index].name}',
        style: const TextStyle(fontSize: 15),
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            defaultTextField(
              textEditingController: durationController,
              label: 'Duration',
              textInputType: TextInputType.number,
              prefix: Icons.timer,
              enabled: !cubit.isChecked,
            ),
            Row(
              children: [
                const Text("Start with open time"),
                Checkbox(
                  checkColor: Colors.white,
                  value: cubit.isChecked,
                  onChanged: (bool? value) => cubit.changeCheckBox(value),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 1,
                  groupValue: cubit.groupValue,
                  onChanged: (value) {
                    return cubit.changeRadioValue(value);
                  },
                ),
                const Text('Single'),
                const Spacer(),
                Radio(
                  value: 2,
                  groupValue: cubit.groupValue,
                  onChanged: (value) {
                    return cubit.changeRadioValue(value);
                  },
                ),
                const Text('Multi'),
                const SizedBox(width: 7),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            if (cubit.isChecked) {
              log('cubit.isChecked : ${cubit.isChecked}');
              double duration = 8 * 60;
              DateTime now = DateTime.now();
              await cubit.insertNewSessionIntoDatabase(
                roomId: cubit.rooms[index].id,
                duration: duration,
                startTime: now.toString(),
                endTime: now
                    .add(
                      Duration(
                        minutes: int.parse(duration.ceil().toString()),
                      ),
                    )
                    .toString(),
                sessionType: cubit.groupValue == 1 ? 'Single' : 'Multi',
                totalCost: cubit.groupValue == 1
                    ? cubit.rooms[index].hourPrice * duration / 60
                    : cubit.rooms[index].hourPrice * duration / 60 * 1.75,
                isOpenTime: '${cubit.isChecked}',
              );
              await cubit.updateStatusRoomDatabase('true', cubit.rooms[index].id);
              Navigator.pop(context);
            } else {
              log('cubit.isChecked : ${cubit.isChecked}');
              if (formKey.currentState!.validate()) {
                if (double.parse(durationController.text) * 60 > 8 * 60) {
                  showToast('${durationController.text} hours is too many, something wrong!', ToastState.warning);
                } else {
                  if (double.parse(durationController.text) * 60 < 0) {
                    showToast('${durationController.text} hours is too short!', ToastState.warning);
                  } else {
                    double duration = double.parse(durationController.text) * 60;
                    DateTime now = DateTime.now();
                    await cubit.insertNewSessionIntoDatabase(
                      roomId: cubit.rooms[index].id,
                      duration: duration,
                      startTime: now.toString(),
                      endTime: now
                          .add(
                            Duration(
                              minutes: int.parse(duration.ceil().toString()),
                            ),
                          )
                          .toString(),
                      sessionType: cubit.groupValue == 1 ? 'Single' : 'Multi',
                      totalCost: cubit.groupValue == 1
                          ? cubit.rooms[index].hourPrice * duration / 60
                          : cubit.rooms[index].hourPrice * duration / 60 * 1.75,
                      isOpenTime: '${cubit.isChecked}',
                    );
                    await cubit.updateStatusRoomDatabase('true', cubit.rooms[index].id);
                    Navigator.pop(context);
                  }
                }
              }
            }
          },
          child: const Text("okay"),
        ),
      ],
    );
  }

  Widget rowDataItem(String deviceType, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Row(
        children: [
          CircleAvatar(
            radius: 8,
            backgroundColor: Colors.grey[300],
            child: Icon(
              iconData,
              color: MaterialPSApp.backgroundColor,
              size: 8,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            deviceType,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 9,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget buildBottomSheetChild(context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<PlaystationHomeCubit, PlaystationHomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PlaystationHomeCubit.get(context);
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(238, 238, 238, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      defaultTextField(
                        textEditingController: nameController,
                        label: 'Enter Room Name',
                        textInputType: TextInputType.name,
                        prefix: Icons.meeting_room_outlined,
                      ),
                      const SizedBox(height: 10),
                      defaultTextField(
                          textEditingController: hourPriceController,
                          label: 'Enter price per hour',
                          textInputType: TextInputType.number,
                          prefix: Icons.attach_money),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('Select your playstation:'),
                          Radio(
                            value: 1,
                            groupValue: cubit.groupValue,
                            onChanged: (value) {
                              return cubit.changeRadioValue(value);
                            },
                          ),
                          const Text('PS 4'),
                          const Spacer(),
                          Radio(
                            value: 2,
                            groupValue: cubit.groupValue,
                            onChanged: (value) {
                              return cubit.changeRadioValue(value);
                            },
                          ),
                          const Text('PS 5'),
                          const SizedBox(width: 7),
                        ],
                      ),
                      defaultButton(
                        label: 'create room',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (nameController.text.length > 6) {
                              showToast('You should insert short name room', ToastState.warning);
                            } else if (equalsIgnoreCase(cubit.rooms, nameController.text)) {
                              showToast('${nameController.text} is already exists.', ToastState.error);
                            } else {
                              await cubit
                                  .insertNewRoomIntoDatabase(
                                name: nameController.text,
                                roomType: cubit.groupValue == 1 ? 'Playstation 4' : 'Playstation 5',
                                hourPrice: int.parse(hourPriceController.text),
                              )
                                  .then(
                                (value) {
                                  log('done');
                                  // cubit.changeShowingBottomSheet();
                                  Navigator.of(context).pop();
                                  nameController.text = hourPriceController.text = '';
                                  cubit.groupValue = 1;
                                },
                              );
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            //work for stackDeans
            Positioned(
              top: 10,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  // cubit.changeShowingBottomSheet();
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.cancel, color: Colors.grey[500]),
              ),
            ),
            Positioned(
              top: 8,
              right: size.width / 2 - 50,
              child: Container(
                width: 100,
                height: 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
