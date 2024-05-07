import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final List<String> dataList = [];

class RecordList extends ConsumerWidget {
  const RecordList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: const <Widget>[
        ActivityCard(
          date: "4월 5일 19:30",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "16분 37초",
          backgroundColor: Colors.black87,
          textColor: Colors.white,
        ),
        ActivityCard(
          date: "4월 4일 20:00",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "17분 37초",
          backgroundColor: Colors.white,
          textColor: Colors.black87,
        ),
        ActivityCard(
          date: "4월 4일 20:00",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "17분 37초",
          backgroundColor: Colors.white,
          textColor: Colors.black87,
        ),
        ActivityCard(
          date: "4월 4일 20:00",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "17분 37초",
          backgroundColor: Colors.white,
          textColor: Colors.black87,
        ),
        ActivityCard(
          date: "4월 4일 20:00",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "17분 37초",
          backgroundColor: Colors.white,
          textColor: Colors.black87,
        ),
        ActivityCard(
          date: "4월 4일 20:00",
          type: "rrr",
          status: "",
          distance: "3Km",
          duration: "17분 37초",
          backgroundColor: Colors.white,
          textColor: Colors.black87,
        ),
      ],
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String date;
  final String type;
  final String status;
  final String distance;
  final String duration;
  final Color backgroundColor;
  final Color textColor;

  const ActivityCard({
    super.key,
    required this.date,
    required this.type,
    required this.status,
    required this.distance,
    required this.duration,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date.split(" ")[0] + " " + date.split(" ")[1],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date.split(" ")[2],
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Card(
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // <Widget> 은 무엇을 의미하는가?
                  Text("사용자모드",
                      style: TextStyle(color: textColor, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(type + (status.isNotEmpty ? " - $status" : ""),
                      style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(distance,
                          style: TextStyle(color: textColor, fontSize: 18)),
                      Text(duration,
                          style: TextStyle(color: textColor, fontSize: 18)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
