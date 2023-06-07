import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelpVerified extends StatelessWidget {
  const HelpVerified({super.key});

  @override
  Widget build(BuildContext context) {
    const Color defaultTextColor = Color.fromRGBO(76, 76, 76, 1.0);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.close, color: Colors.blue, size: 100.0)
            ),
            const SizedBox(height: 20.0),
            const Text("Verified workers", style: TextStyle(fontSize: 36.0, color: defaultTextColor, fontWeight: FontWeight.w700)),
            const SizedBox(height: 20.0),
            const Text("Verified workers are ones who worked previously with partner or those trusted by partner. "
                "If a partner work with someone, the worker become verified for that partner. "
                "And worker can also be verified manually by sharing partner link with his known partner.",
              style: TextStyle(fontSize: 18.0, color: defaultTextColor, fontWeight: FontWeight.w500),
              textAlign: TextAlign.start),
          ],
        )
      )
    );
  }
}