import 'package:beamcoda_jobs_partners_flutter/ui/job/userindex.dart';
import 'package:beamcoda_jobs_partners_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../types/jobcompact.dart';
import '../index.dart';

class JobPost extends StatelessWidget {
  final JobCompact jobPost;
  final bool isWorker;
  const JobPost({required Key key, required this.jobPost, required this.isWorker}) : super(key: key);

  static const activeColor = Colors.green;
  static const Color activeBgColor = Color.fromRGBO(214, 254, 205, 1.0);
  static const Color progColor = Colors.pink;
  static const Color progBgColor = Color.fromRGBO(249, 193, 213, 1.0);
  static const Color finishColor = Colors.blue;
  static const Color finishBgColor = Color.fromRGBO(213, 235, 253, 1.0);
  static const Color waitColor = Color.fromRGBO(255, 127, 39, 1.0);
  static const Color waitBgColor = Color.fromRGBO(255, 222, 183, 1.0);

  Widget getBadgeWidget() {
    late Color color;
    late Color bgColor;

    if (isWorker) {
      bgColor = jobPost.status == JobStatus.BOOKED ? activeBgColor : waitBgColor;
      color = jobPost.status == JobStatus.BOOKED ? activeColor : waitColor;
    }
    else{
      bgColor = jobPost.status == JobStatus.ACTIVE ? activeBgColor : jobPost.status == JobStatus.INPROGRESS ? progBgColor: finishBgColor;
      color = jobPost.status == JobStatus.ACTIVE ? activeColor : jobPost.status == JobStatus.INPROGRESS ? progColor: finishColor;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: bgColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      child: Text(isWorker ? JobStatus.USERLABELS[jobPost.status] : JobStatus.LABELS[jobPost.status],
          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: color)),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color defaultTextColor = Color.fromRGBO(76, 76, 76, 1.0);
    const double jobPostFont = 18.0;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => isWorker ? UserViewJobPost(id: jobPost.id, isOpen: jobPost.status == JobStatus.NEW) : ViewJobPost(id: jobPost.id),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(jobPost.title, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: defaultTextColor)),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text("${jobPost.workers} worker${jobPost.workers == 1 ? "" : "s"}",
                        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, color: defaultTextColor)),
                  )
                )
              ],
            ),

            const SizedBox(height: 5.0),

            Row(
              children: [
                Text(jobPost.duration, style: const TextStyle(fontSize: jobPostFont, fontWeight: FontWeight.w400, color: defaultTextColor)),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(jobPost.fixedPay == 0 ? "\$${jobPost.payRate.toStringAsFixed(2)}/hr" : "Fixed \$${jobPost.fixedPay}",
                        style: const TextStyle(fontSize: jobPostFont, fontWeight: FontWeight.w400, color: defaultTextColor)),
                  )
                )
              ],
            ),

            const SizedBox(height: 5.0),

            Text(jobPost.location, style: const TextStyle(fontSize: jobPostFont, color: Colors.grey)),

            const SizedBox(height: 5.0),

            Row(
              children: [
                if (!isWorker || (isWorker && jobPost.status != JobStatus.NEW))
                  getBadgeWidget(),

                if (!isWorker && jobPost.status == JobStatus.ACTIVE && jobPost.bookNumer > 0)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: activeBgColor
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    margin: const EdgeInsets.only(left: 5.0),
                    child: Text(jobPost.bookNumer.toString(), style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: activeColor)),
                  ),

                if (!isWorker && jobPost.status == JobStatus.ACTIVE && jobPost.waitNumber > 0)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: waitBgColor,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    margin: const EdgeInsets.only(left: 5.0),
                    child: Text(jobPost.waitNumber.toString(), style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: waitColor)),
                  ),

                if (jobPost.isVerified)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Icon(Icons.verified, color: Colors.green)
                  ),

                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text("Posted at ${jobPost.postedTime}", style: const TextStyle(fontSize: jobPostFont, color: defaultTextColor))
                  ),
                )
              ]
            )
          ],
        ),
      )
    );
  }
}
