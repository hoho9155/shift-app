import 'package:beamcoda_jobs_partners_flutter/ui/authentication/demo.dart';
import 'package:beamcoda_jobs_partners_flutter/ui/message/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './homepage/index.dart';
import './profile/index.dart';
import './settings/index.dart';
import './theme_data/fonts.dart';
import '../data/auth.dart';
import '../ui/authentication/login.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({required Key key}) : super(key: key);

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  final List<Widget> tabWidgets = [
    const HomePage(),
    const MessagePage(),
    const ProfilePage()
  ];
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: tabIndex,
        onTap: (value) {
          setState(() {
            tabIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt),
            activeIcon: Icon(Icons.person_add_alt_1),
            label: "Shifts"
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.messenger_outline),
            activeIcon: Icon(Icons.messenger),
            label: "Messages"
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_outlined),
            activeIcon: Icon(Icons.person_pin_rounded),
            label: "Profile"
          ),
        ],
      ),

      body: IndexedStack(index: tabIndex, children: tabWidgets)
    );
  }
}
