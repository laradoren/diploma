import 'dart:ui';

import 'package:diplom/api/branch.dart';
import 'package:diplom/models/users_logs_by_course.dart';
import 'package:diplom/utils/calculator.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class UserInfoRow extends StatefulWidget {
  final String name;
  final String surname;
  final String userId;
  final List<UsersLogsByCourse> usersLogs;
  final List branches;

  const UserInfoRow({
    Key? key,
    required this.name,
    required this.surname,
    required this.userId,
    required this.usersLogs,
    required this.branches,
  }) : super(key: key);

  @override
  State<UserInfoRow> createState() => _UserInfoRowState();

}
class _UserInfoRowState extends State<UserInfoRow> with TickerProviderStateMixin {
  int _progress = 0;

  void initPageState() async {
    List<String> pagesNames = [];
    List<List<dynamic>> numberOfBranchesChildren = [];
    final Calculator calculator = Calculator();

    for(String branch in widget.branches) {
      dynamic page = await fetchPageByBranch(branch);
      List<dynamic> pageChildren = await fetchPageChildrenByBranch(branch);
      numberOfBranchesChildren.add(pageChildren);
      pagesNames.add(page.caption);
    }



    setState(() {
      for(final userLog in widget.usersLogs) {
        if(userLog.userId == widget.userId) {
          _progress = calculator.countProgress(userLog.logs, widget.branches, numberOfBranchesChildren);
        }
      }
    });
  }

  @override
  void initState() {
    initPageState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.account_circle, size: 76, color: Color.fromRGBO(154, 153, 162, 1)),
          const Padding(padding: EdgeInsets.only(right: 8)),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color.fromRGBO(93, 92, 99, 1)),
                  children: [
                    TextSpan(text: '${widget.name} ${widget.surname}'),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 16)),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: SfLinearGauge(
                    showTicks: false,
                    interval: 100,
                    axisLabelStyle: const TextStyle(
                        color: Color.fromRGBO(93, 92, 99, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    axisTrackStyle: const LinearAxisTrackStyle(
                        thickness: 10, edgeStyle: LinearEdgeStyle.bothCurve),
                    barPointers: [
                      LinearBarPointer(
                          value: double.parse(_progress.toString()),
                          thickness: 10,
                          edgeStyle: LinearEdgeStyle.bothCurve,
                          //Apply linear gradient
                          shaderCallback: (bounds) => const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromRGBO(80, 69, 153, 1),
                                Color.fromRGBO(56, 179, 158, 1),
                                Color.fromRGBO(41, 245, 41, 1),
                              ]).createShader(bounds)),
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
