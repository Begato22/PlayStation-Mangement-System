import 'package:flutter/cupertino.dart';
import '../../shared/Materials/material_app.dart';

class PageViewElement {
  final String title;
  final String description;
  final String imagePath;

  PageViewElement(
      {required this.title,
      required this.description,
      required this.imagePath});
  Container getPageViewElement() {
    return Container(
      color: MaterialPSApp.backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            width: 290,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 70,),
          Align(alignment: Alignment.centerLeft, child: Text(title,style: MaterialPSApp.titleFontO,)),
          const SizedBox(height: 20,),
          Text(
            description,
            textAlign: TextAlign.justify,
            style: MaterialPSApp.basicFontW,

          ),
        ],
      ),
    );
  }
}
