import 'package:beamcoda_jobs_partners_flutter/data/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/job.dart';
import '../../utils/constants.dart';
import '../job/item/index.dart';
import '../job/new/index.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final jobProvider = Provider.of<JobProvider>(context, listen: false);
      String result = await jobProvider.loadUserJobs(context);

      if (result != '') {
        Util.showToast(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    const Color defaultTextColor = Color.fromRGBO(76, 76, 76, 1.0);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 20.0, right: 10.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: (){

              },
              icon: const Icon(Icons.help_outline, color: Colors.blue),
            )
          ),

          const SizedBox(height: 10.0),

          Expanded(
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TabBar(
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
                    labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    tabs: [
                      Tab(text: "Open shifts"),
                      Tab(text: "My shifts")
                    ],
                  ),

                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: jobProvider.openJobs.length,
                            itemBuilder: (_, i) {
                              return JobPost(
                                key: UniqueKey(),
                                jobPost: jobProvider.openJobs[i],
                                isWorker: true,
                              );
                            },
                          ),
                        ),

                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: jobProvider.myJobs.length,
                            itemBuilder: (_, i) {
                              return JobPost(
                                key: UniqueKey(),
                                jobPost: jobProvider.myJobs[i],
                                isWorker: true
                              );
                            },
                          ),
                        ),
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
