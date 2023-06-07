import 'package:flutter/material.dart';

class ProfilePerformance extends StatefulWidget {
  const ProfilePerformance({super.key});

  @override
  State<ProfilePerformance> createState() => _ProfilePerformanceState();
}

class _ProfilePerformanceState extends State<ProfilePerformance> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20.0),

        FractionallySizedBox(
          widthFactor: 1.0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: const Center(
              child: Text("You haven't worked any shifts yet.", style: TextStyle(fontSize: 18.0, color: Colors.blue, fontWeight: FontWeight.w700)),
            )
          ),
        )
      ]
    );
  }
}