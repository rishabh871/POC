import 'package:flutter/material.dart';

class FeatureItem extends StatelessWidget {
  final String label;
  final String value;

  FeatureItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Label
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            // Separator
            const SizedBox(width: 8.0),
            // Value
            Expanded(
              flex: 3,
              child: Text(
                value,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
