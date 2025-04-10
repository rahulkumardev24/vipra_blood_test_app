import 'package:flutter/material.dart';
import 'package:vipra_lap/domain/utils/custom_text_style.dart';

class CategoriesCard extends StatefulWidget {
  String title;
  String imagePath;
  CategoriesCard({super.key, required this.title, required this.imagePath});

  @override
  State<CategoriesCard> createState() => _CategoriesCardState();
}

class _CategoriesCardState extends State<CategoriesCard> {
  @override
  MediaQueryData? mqData;
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100,
            width: mqData!.size.width * 0.5,
            decoration: BoxDecoration(
              boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 3)],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Image.asset(widget.imagePath),
            ),
          ),
          Text(
            widget.title,
            style: myTextStyle15(),
          )
        ],
      ),
    );
  }
}
