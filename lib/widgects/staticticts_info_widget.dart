import 'dart:ui';

import 'package:diplom/api/branch.dart';
import 'package:diplom/models/users_logs_by_course.dart';
import 'package:diplom/utils/calculator.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../models/data.dart';

class StatisticsInfoRow extends StatefulWidget {
  final String header;
  final List<Data> data;

  const StatisticsInfoRow({
    Key? key,
    required this.header,
    required this.data
  }) : super(key: key);

  @override
  State<StatisticsInfoRow> createState() => _StatisticsInfoRowState();

}
class _StatisticsInfoRowState extends State<StatisticsInfoRow> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 8, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/event_icon.png',height: 70, width: 70),
          const Padding(padding: EdgeInsets.only(right: 16)),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color.fromRGBO(93, 92, 99, 1)),
                  children: [
                    TextSpan(text: widget.header),
                  ],
                ),
              ),
              for(final info in widget.data) ...[
                const Padding(padding: EdgeInsets.only(top: 16)),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromRGBO(93, 92, 99, 1)),
                    children: [
                      TextSpan(text: '${info.key}: ${info.value.round()} s'),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 6)),
              ]
            ],
          )
        ],
      ),
    );
  }
}
