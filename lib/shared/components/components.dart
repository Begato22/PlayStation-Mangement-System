// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:playstation/layouts/home%20layout/bloc/cubit.dart';
import 'package:playstation/models/session%20model/session_model.dart';

import '../Materials/material_app.dart';

void navigateAndRemoveTo(context, Widget screen) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (Route<dynamic> route) => false,
    );
void navigateTo(context, Widget screen) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );

enum ToastState { success, error, warning }

Future<bool?> showToast(String message, ToastState state) async {
  print("inside inc");
  return await Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 6,
    backgroundColor: changeColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  ).then((value) {
    print(value.toString());
  }).catchError((err) {
    print(err.toString());
  });
}

Color changeColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget defaultButton({required String label, required Function onPressed, bool isDisabled = false}) => Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(isDisabled ? Colors.grey : MaterialPSApp.basicColor),
            overlayColor: MaterialStateProperty.all(isDisabled ? Colors.black : MaterialPSApp.whiteColor),
            enableFeedback: isDisabled,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ))),
        onPressed: () {
          if (isDisabled) {
            null;
          } else {
            onPressed();
          }
        },
        child: Text(
          label.toUpperCase(),
          style: MaterialPSApp.buttonsFontW,
        ),
      ),
    );

Widget roomCardButton(
    {required String label,
    required Function onPressed,
    SessionModel? sessionModel,
    DateTime? duration,
    bool isDisabled = false,
    context,
    required PlaystationHomeCubit cubit}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(top: 20),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled ? Colors.grey : MaterialPSApp.basicColor,
        enableFeedback: !isDisabled,
      ),
      onPressed: () {
        if (isDisabled) {
          null;
        } else {
          onPressed();
        }
      },
      child: isDisabled
          ? sessionModel!.isOpenTime
              ? const Text("Open Time")
              : buildTimer(cubit, context, sessionModel, duration!)
          : Text(
              label.toUpperCase(),
              style: MaterialPSApp.buttonsFontW,
            ),
    ),
  );
}

Widget buildTimer(
  PlaystationHomeCubit cubit,
  BuildContext context,
  SessionModel sessionModel,
  DateTime duration,
) {
  int endTime = DateTime.now().millisecondsSinceEpoch +
      duration.hour * 60 * 60 * 1000 +
      duration.minute * 60 * 1000 +
      duration.second * 1000 +
      duration.millisecond;

  return Center(
    child: CountdownTimer(
      onEnd: () => cubit.finishTime(cubit, context, sessionModel.roomId),
      endTime: endTime,
      widgetBuilder: (_, CurrentRemainingTime? time) {
        if (time == null) {
          return const Text('');
        }
        return sessionModel.isOpenTime
            ? const Text("Open Time")
            : Text(
                '${time.hours ?? 0}:${time.min ?? 0}:${time.sec}',
                style: const TextStyle(fontSize: 12),
              );
      },
    ),
  );
}

Widget defaultTextField({
  required TextEditingController textEditingController,
  required String label,
  String? initialValue,
  required TextInputType textInputType,
  bool obscureText = false,
  required IconData prefix,
  IconData? sufix,
  Function? sufixOnTap,
  Function? validator,
  bool enabled = true,
}) =>
    SizedBox(
      height: 70,
      child: TextFormField(
        initialValue: initialValue,
        validator: (value) {
          if (value!.isEmpty) {
            print('empty');
            return 'You should enter valid $label.';
          } else {
            return null;
          }
        },
        enabled: enabled,
        controller: textEditingController,
        decoration: InputDecoration(
          prefixIcon: Icon(prefix),
          suffixIcon: GestureDetector(
            onTap: () {
              sufixOnTap!();
            },
            child: Icon(sufix),
          ),
          border: const OutlineInputBorder(),
          labelText: label,
        ),
        keyboardType: textInputType,
        obscureText: obscureText,
      ),
    );

Widget customDividerText(String text) => Row(
      children: <Widget>[
        const Expanded(child: Divider(thickness: 2)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(text.toUpperCase()),
        ),
        const Expanded(child: Divider(thickness: 2)),
      ],
    );

Widget buildBackgroundContainer({required Widget child, required context}) {
  var size = MediaQuery.of(context).size;
  return Container(
    width: size.width,
    height: size.height,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/bg.png'),
        fit: BoxFit.cover,
        opacity: 0.05,
      ),
    ),
    child: child,
  );
}

Widget buildEmptyReplacementScreen({
  required String label,
  required IconData iconData,
  required double size,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        iconData,
        size: size,
        color: MaterialPSApp.basicColor.withOpacity(0.3),
      ),
      Text(
        label,
        style: TextStyle(
          fontSize: size / 4,
          color: MaterialPSApp.basicColor.withOpacity(0.3),
        ),
      )
    ],
  );
}

void showDialogAlert({
  required context,
  required String message,
  required String url,
  dynamic onOk,
  bool needCancel = false,
  bool needOk = true,
}) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/dialogPic/$url.png',
            height: 120,
            width: url.contains('sleep') || url.contains('clear') ? 120 : 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 5),
          Text(
            message,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
      actions: <Widget>[
        if (needCancel)
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
        if (needOk)
          TextButton(
            onPressed: () async {
              onOk!();
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
      ],
    ),
  );
}
