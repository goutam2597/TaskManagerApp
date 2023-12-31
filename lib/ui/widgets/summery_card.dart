
import 'package:flutter/material.dart';

class SummeryCard extends StatelessWidget {
  const SummeryCard({
    super.key,
    required this.number,
    required this.title,
  });

  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                '$number',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(title,style: const TextStyle(fontSize: 13),),
            ],
          ),
        ),
      ),
    );
  }
}
