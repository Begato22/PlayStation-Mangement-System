import 'package:flutter/material.dart';
import '../../shared/Materials/material_app.dart';

class PVIndicator extends StatelessWidget {
  const PVIndicator({Key? key, required this.isCurrent}) : super(key: key);

  final bool isCurrent;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: isCurrent ? 32 : 7,
      height: 7,
      margin: const EdgeInsets.symmetric(horizontal: 7),
      decoration: BoxDecoration(
        borderRadius: isCurrent ? BorderRadius.circular(30) : null,
        color: isCurrent ? MaterialPSApp.basicColor : MaterialPSApp.basicColor.withOpacity(0.3),
        shape: isCurrent ? BoxShape.rectangle : BoxShape.circle,
      ),
    );
  }
}
