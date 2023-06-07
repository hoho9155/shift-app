import 'dart:convert';
import 'dart:math';
import 'package:beamcoda_jobs_partners_flutter/types/job_applicant.dart';
import 'package:beamcoda_jobs_partners_flutter/types/user.dart';
import 'package:beamcoda_jobs_partners_flutter/ui/message/chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/job.dart';
import '../../../utils/constants.dart';

class ApplicantsPage extends StatefulWidget {
  const ApplicantsPage({super.key, required this.jobID});
  final int jobID;

  @override
  State<ApplicantsPage> createState() => _ApplicantsPageState();
}

class _ApplicantsPageState extends State<ApplicantsPage> {
  @override
  void initState() {
    super.initState();

    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    jobProvider.bookedWorkers.clear();
    jobProvider.reservedWorkers.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String result = await jobProvider.getJobApplicants(context, widget.jobID);

      if (result != '') {
        Util.showToast(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color defaultTextColor = Color.fromRGBO(76, 76, 76, 1.0);
    Color likeColor = Colors.blue.withOpacity(0.7);
    Color dislikeColor = Colors.red.withOpacity(0.7);
    Color chatColor = Colors.green.withOpacity(0.7);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final jobProvider = Provider.of<JobProvider>(context);

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
            child: DefaultTextStyle(
              style: const TextStyle(color: defaultTextColor, fontSize: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          color: Colors.blue,
                          iconSize: 30.0,
                          padding: const EdgeInsets.all(0),
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ]
                  ),

                  const SizedBox(height: 20.0),

                  const Text("Applicants for your shift", style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w700)),

                  const SizedBox(height: 10.0),

                  const Text("Booked workers are ones that will work on your shift. Reserved workers are candidates for your shift.",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize:15.0),
                  ),

                  const SizedBox(height: 20.0),

                  Row(
                    children: [
                      IconButton(
                        onPressed: (){

                        },
                        icon: Icon(Icons.thumb_up_alt, color: likeColor)
                      ),

                      const SizedBox(width: 5.0),

                      const Text("Promote", style: TextStyle(fontWeight: FontWeight.w700)),

                      const SizedBox(width: 10.0),

                      IconButton(
                        onPressed: (){

                        },
                        icon: Icon(Icons.thumb_down_alt, color: dislikeColor)
                      ),

                      const SizedBox(width: 5.0),

                      const Text("Demote", style: TextStyle(fontWeight: FontWeight.w700)),

                      const SizedBox(width: 10.0),

                      IconButton(
                        onPressed: (){
                        },
                        icon: Icon(Icons.telegram, color: chatColor)
                      ),

                      const SizedBox(width: 5.0),

                      const Text("Chat", style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),

                  const SizedBox(height: 20.0),

                  const Text("Booked workers", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700)),

                  const SizedBox(height: 5.0),

                  for (int i = 0; i < jobProvider.bookedWorkers.length; i++)
                    generateWorkerItem(jobProvider.bookedWorkers[i], true)
                  ,

                  const SizedBox(height: 20.0),

                  const Text("Reserved workers", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700)),

                  for (int i = 0; i < jobProvider.reservedWorkers.length; i++)
                    generateWorkerItem(jobProvider.reservedWorkers[i], false)
                  ,
                ]
              )
            )
          ),
        )
      );
    }

    Widget generateWorkerItem(JobApplicant user, bool isBooked) {
      Color likeColor = Colors.blue.withOpacity(0.7);
      Color dislikeColor = Colors.red.withOpacity(0.7);
      Color chatColor = Colors.green.withOpacity(0.7);
      final jobProvider = Provider.of<JobProvider>(context, listen: false);

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
        ),
        child: Row(
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage("assets/images/sample_photo.png"),
                    fit: BoxFit.cover
                )
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${user.firstName} ${user.lastName}", style: const TextStyle(fontWeight: FontWeight.w400)),
                    const SizedBox(height: 5.0),
                    Text(user.headline!, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400)),
                  ],
                ),
              )
            ),

            if (!isBooked)
              IconButton(
                onPressed: (){
                  jobProvider.promoteWorker(context, widget.jobID, user.id);
                },
                icon: Icon(Icons.thumb_up_alt, color: likeColor)
              )
            else
              IconButton(
                onPressed: (){
                  jobProvider.demoteWorker(context, widget.jobID, user.id);
                },
                icon: Icon(Icons.thumb_down_alt, color: dislikeColor)
              )
            ,

            IconButton(
              onPressed: (){
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return ChatPage(otherID: user.id, otherName: "${user.firstName} ${user.lastName}");
                }));
              },
              icon: Icon(Icons.telegram, color: chatColor)
            )
          ],
        )
     );
    }
}
