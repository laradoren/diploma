import 'dart:convert';
import 'dart:ui';

import 'package:diplom/models/course.dart';
import 'package:diplom/utils/calculator.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class CourseWidget extends StatefulWidget {
  final Course course;

  const CourseWidget(
      {Key? key,
        required this.course})
      : super(key: key);

  @override
  State<CourseWidget> createState() => _CourseWidgetState();
}

class _CourseWidgetState extends State<CourseWidget> {
  int _allUsers = 0;
  double _averageTestResult = 0.0;
  double _averageUserTime = 0.0;

  @override
  void initState() {
    final Calculator calculator = Calculator();
    setState(() {
      _allUsers = calculator.countActiveUsers(widget.course.users);
      _averageTestResult = calculator.calculateAverageTestResult(widget.course.users);
      _averageUserTime = calculator.calculateAverageSpendTime(widget.course.users);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
            () {
          final String image = 'http://semantic-portal.net/images/${widget.course.course.image}';
          if(widget.course.course.image != "") {
            return Image.network(image, height: 103, width: 103);
          } else {
            return Image.asset('assets/images/react_icon.png');
          }
        }(),
        const Padding(padding: EdgeInsets.only(right: 16)),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.course.course.caption.capitalize(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(93, 92, 99, 1))),
              const Padding(padding: EdgeInsets.only(top: 4)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(140, 138, 149, 1)),
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 0, 6, 0),
                            child: Image.asset(
                                'assets/images/students.png', height: 20, width: 20),
                          ),
                        ),
                        TextSpan(text: '$_allUsers'),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 30)),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(140, 138, 149, 1)),
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 0, 6, 0),
                            child: Image.asset(
                                'assets/images/star_icon.png', height: 20, width: 20),
                          ),
                        ),
                        TextSpan(text: '$_averageTestResult'),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 30)),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(140, 138, 149, 1)),
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding:
                            const EdgeInsets.fromLTRB(0, 0, 6, 0),
                            child: Image.asset(
                                'assets/images/alarm_clock_icon.png', height: 20, width: 20),
                          ),
                        ),
                        TextSpan(text: '$_averageUserTime'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
