import 'package:flutter/material.dart';

const int primaryBlueColor = 0xFF8EDCF2;
const int primaryRedColor = 0xFFF1877F;
var sampleContentList = [
  {
    "dayOfWeek": "Sun",
    "day": "08",
    "image": "images/pug.jpeg",
    "title": "Book Talk and Signing Conference",
    "location": "Cos cob, Library",
    "content":
        "This weekend spectacular event will celebrate dogs everwhere in a large-scale ... "
  },
  {
    "dayOfWeek": "Thu",
    "day": "19",
    "image": "images/pug.jpeg",
    "title": "World Dog Expo by WDE",
    "location": "520 8th Avenue",
    "content":
        "This weekend spectacular event will celebrate dogs everwhere in a large-scale ... "
  },
  {
    "dayOfWeek": "Mon",
    "day": "23",
    "image": "images/pug.jpeg",
    "title": "Training: Complete Hair Solution",
    "location": "145 Front Street",
    "content":
        "This weekend spectacular event will celebrate dogs everwhere in a large-scale ... "
  }
];

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color(primaryBlueColor),
          borderRadius: BorderRadius.all(Radius.circular(9))),
      width: 50,
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text("Dec", style: TextStyle(color: Colors.white)),
          Text("19", style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
