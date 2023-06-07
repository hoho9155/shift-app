import 'dart:convert';
import 'dart:io';

import 'package:beamcoda_jobs_partners_flutter/data/auth.dart';
import 'package:beamcoda_jobs_partners_flutter/ui/profile/performance.dart';
import 'package:beamcoda_jobs_partners_flutter/ui/profile/profile.dart';
import 'package:beamcoda_jobs_partners_flutter/ui/settings/index.dart';
import 'package:beamcoda_jobs_partners_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../theme_data/fonts.dart';
import '../theme_data/inputs.dart';
import 'company.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 20.0, right: 10.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const SettingsPage();
                          }
                      ));
                    },
                    icon: const Icon(Icons.settings, color: Colors.blue),
                  ),
                )
              ),

              const SizedBox(width: 5.0),

              IconButton(
                onPressed: (){

                },
                icon: const Icon(Icons.help_outline, color: Colors.blue),
              ),
            ],
          ),

          Expanded(
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                    tabs: authProvider.isWorker ?
                      [
                        const Tab(text: "Personal"),
                        const Tab(text: "Performance")
                      ] :
                      [
                        const Tab(text: "Company"),
                        const Tab(text: "Profile")
                      ],
                  ),

                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: !authProvider.isWorker ? [
                        const ProfileCompany(),
                        const ProfileMain(),
                      ] :
                      [
                        const ProfileMain(),
                        const ProfilePerformance()
                      ],
                    )
                  )
                ],
              ),
            )
          )
        ]
      )
    );
  }
}
