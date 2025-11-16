import 'package:flutter/material.dart';

class ResultCard extends StatelessWidget {
  final double bmi;
  final String category;
  final Color color;

  const ResultCard({
    super.key,
    required this.bmi,
    required this.category,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(.2),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your BMI",
                style: Theme.of(context).textTheme.headlineSmall),
            Text(
              bmi.toStringAsFixed(1),
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Chip(
              backgroundColor: color,
              label: Text(
                category,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
