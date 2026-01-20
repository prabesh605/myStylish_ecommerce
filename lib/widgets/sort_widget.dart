import 'package:flutter/material.dart';

class SortWidget extends StatelessWidget {
  const SortWidget({super.key, required this.name, required this.icon});
  final String name;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(width: 0),
      ),
      padding: EdgeInsets.all(4),
      child: Row(children: [Text(name), icon]),
    );
  }
}
