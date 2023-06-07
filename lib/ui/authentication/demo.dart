import 'package:flutter/material.dart';
import './login.dart';
import './register.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});
  final double bannerImgSize = 120.0;
  final Color defaultTextColor = const Color.fromRGBO(76, 76, 76, 1.0);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return DefaultTextStyle(style: const TextStyle(decoration: TextDecoration.none),
      child: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 60.0),

            Text("Shiftwork", style: TextStyle(fontSize: 24.0, color: defaultTextColor, fontWeight: FontWeight.w700)),

            const SizedBox(height: 20.0),

            Expanded(
              child: PageView(
                scrollDirection: Axis.horizontal,
                children: generateBanner(),
              )
            ),

            FractionallySizedBox(
              widthFactor: 1.0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(3.0)
                ),
                child: TextButton(
                  child: const Text('Create an account', style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w700)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Register(
                            key: UniqueKey(),
                          );
                        },
                      ),
                    );
                  },
                )
              )
            ),

            const SizedBox(height: 20.0),

            TextButton(
              child: const Text('I already have an account', style: TextStyle(fontSize: 18.0)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginPage();
                    },
                  )
                );
              },
            )
          ]
        ),
      )
    );
  }

  List<Widget> generateBanner() {
    List<Widget> banners = [];
    List<String> icons = ["wallet.png", "clock.png", "handshake.png"];
    List<String> text1 = ["Earn up to \$25/hr", "Work on your schedule", "Build relationships"];
    List<String> text2 = ["Book from a variety of shifts at local businesses and get paid quickly.",
                          "Book one-time or recurring shifts that fit your schedule.",
                          "Make professional connections and build your reputation."];

    for (var i = 0; i < 3; i++) {
      banners.add( Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/icons/${icons[i]}", width: bannerImgSize, height: bannerImgSize),
            const SizedBox(height: 20.0),
            Text(text1[i], style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700, color: defaultTextColor)),
            const SizedBox(height: 10.0),
            Text(text2[i], style: TextStyle(fontSize: 18.0, color: defaultTextColor), textAlign: TextAlign.center,),
          ]
      ));
    }

    return banners;
  }
}