import 'dart:ui';

import 'package:diplom/models/data.dart';
import 'package:flutter/material.dart';

class WeeklyTextRow extends StatelessWidget {
  final String header;
  final List<Data> data;

  const WeeklyTextRow({
    Key? key,
    required this.header,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 8, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.calendar_month_rounded, size: 76, color: Color.fromRGBO(154, 153, 162, 1)),
          const Padding(padding: EdgeInsets.only(right: 16)),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color.fromRGBO(93, 92, 99, 1)),
                  children: [
                    TextSpan(text: header),
                  ],
                ),
              ),
              for(final info in data) ...[
                const Padding(padding: EdgeInsets.only(top: 16)),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300, color: Color.fromRGBO(93, 92, 99, 1)),
                    children: [
                      TextSpan(text: '${info.key}: ${info.value}'),
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
