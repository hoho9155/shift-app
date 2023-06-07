import 'package:beamcoda_jobs_partners_flutter/ui/job/applicants/index.dart';
import 'package:beamcoda_jobs_partners_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import '../../data/job.dart';
import '../../types/jobdetail.dart';
import '../../types/jobnew.dart';

class UserViewJobPost extends StatefulWidget {
  final int id;
  final bool isOpen;

  const UserViewJobPost({super.key, required this.id, required this.isOpen});

  @override
  State<UserViewJobPost> createState() => _UserViewJobPostState();
}

class _UserViewJobPostState extends State<UserViewJobPost> {
  static const activeColor = Colors.green;
  static const Color activeBgColor = Color.fromRGBO(214, 254, 205, 1.0);
  static const Color waitColor = Color.fromRGBO(255, 127, 39, 1.0);
  static const Color waitBgColor = Color.fromRGBO(255, 222, 183, 1.0);
  static const defaultTextColor = Color.fromRGBO(76, 76, 76, 1.0);
  static const TextStyle textStyle1 = TextStyle(fontSize: 22.0, color: defaultTextColor, fontWeight: FontWeight.w700);
  static const TextStyle textStyle2 = TextStyle(fontSize: 18.0, color: defaultTextColor, fontWeight: FontWeight.w500);

  @override
  void initState() {
    super.initState();

    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    jobProvider.curJob.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String result = await jobProvider.getJobDetail(context, widget.id);

      if (result != '') {
        Util.showToast(result);
      }
    });
  }

  void applyJob(BuildContext context) async{
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          // The background color
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 15),
                Text(widget.isOpen ? 'Applying...' : 'Canceling...')
              ],
            ),
          ),
        );
      });

    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    String? result;

    if (widget.isOpen) {
      result = await jobProvider.applyjob(context, jobProvider.curJob.id!);
    }
    else {
      result = await jobProvider.cancelJob(context, jobProvider.curJob.id!);
    }

    if (result != '') {
      Util.showToast(result!);
    }

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void openPassDialog(BuildContext context) async{
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Passing shift to co-worker", style: TextStyle(fontSize: 24.0, color: defaultTextColor, fontWeight: FontWeight.w500)),

                const SizedBox(height: 10),

                Container(
                  color: Colors.grey.withOpacity(0.3),
                  height: 1.0
                ),

                const SizedBox(height: 10),

                TextFormField(
                  // ignore: prefer_const_constructors
                  decoration: InputDecoration(
                    label: const Text("Co-worker link", style: TextStyle(fontSize: 15.0, color: defaultTextColor, fontWeight: FontWeight.w700)),
                  ),
                  style: const TextStyle(fontSize: 18.0, color: defaultTextColor, fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.blue,
                            backgroundColor: Colors.white,
                            elevation: 0,
                            textStyle: const TextStyle(fontSize: 18.0),
                            padding: const EdgeInsets.all(15.0),
                            shape: const StadiumBorder(side: BorderSide(color: Colors.blue))
                          ),
                          child: const Text("Cancel"),
                        )
                      ),
                    ),

                    const SizedBox(width: 10.0),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          elevation: 0,
                          textStyle: const TextStyle(fontSize: 18.0),
                          padding: const EdgeInsets.all(15.0),
                          shape: const StadiumBorder()
                      ),
                      child: const Text("Pass"),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    const double detailFont = 18.0;
    JobProvider jobProvider = Provider.of<JobProvider>(context);
    JobDetail jobDetail = jobProvider.curJob;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () {
                        applyJob(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.all(15.0),
                        shape: const StadiumBorder(),
                        elevation: 0,
                        textStyle: const TextStyle(fontSize: 18.0),
                      ),
                      child: Text(widget.isOpen ? "Apply" : "Cancel"),
                    )
                  ),
                )
              ],
            ),

            const SizedBox(height: 10.0),

            if (!widget.isOpen)
              ...[
                const SizedBox(height: 10.0),

                FractionallySizedBox(
                  widthFactor: 1.0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                      color: jobDetail.status == JobStatus.BOOKED ? activeBgColor : waitBgColor,
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: Center(
                      child: Text(jobDetail.status == JobStatus.BOOKED ? "You are booked for this shift" : "You are reserved for this shift",
                          style: TextStyle(fontSize: 18.0, color: jobDetail.status == JobStatus.BOOKED ? activeColor : waitColor, fontWeight: FontWeight.w700)),
                    )
                  ),
                ),

                if (jobDetail.status == JobStatus.BOOKED && jobDetail.isVerified!)
                  ...[
                    const SizedBox(height: 20.0),

                    FractionallySizedBox(
                        widthFactor: 1.0,
                        child: GestureDetector(
                          onTap: () {
                            openPassDialog(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3.0),
                              border: Border.all(color: Colors.blue, width: 1.0)
                            ),

                            child: const Center(
                              child: Text("Pass to co-worker", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500, color: Colors.blue)),
                            )
                          ),
                        )
                    ),

                    const SizedBox(height: 10.0),

                    const Text("As you are verified worker for this partner, you can pass this shift to co-worker by providing his link.",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 18.0, fontWeight: FontWeight.w500))
                  ],

                const SizedBox(height: 20.0)
              ],

            FractionallySizedBox(
              widthFactor: 1.0,
              child: Container(
                padding: const EdgeInsets.only(bottom: 20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey)),
                ),
                child: const Text("Shift details", textAlign: TextAlign.start, style: TextStyle(
                  color: defaultTextColor,
                  fontSize: 36.0,
                  fontWeight: FontWeight.w700,
                )),
              ),
            ),

            const SizedBox(height: 20.0),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Title", style: textStyle1),

                    const SizedBox(height: 10.0),

                    Text(jobDetail.title!, style: textStyle2),

                    const SizedBox(height: 20.0),

                    const Text("Shift type", style: textStyle1),

                    const SizedBox(height: 10.0),

                    Text(jobDetail.type!, style: textStyle2),

                    const SizedBox(height: 20.0),

                    const Text("Location", style: textStyle1),

                    const SizedBox(height: 10.0),

                    Text(jobDetail.location!, style: textStyle2),

                    const SizedBox(height: 20.0),

                    const Text("Company", style: textStyle1),

                    const SizedBox(height: 10.0),

                    Text(jobDetail.company!, style: textStyle2),

                    const SizedBox(height: 20.0),

                    const Text("Duration", style: textStyle1),

                    const SizedBox(height: 10.0),

                    Text(jobDetail.duration!, style: textStyle2),

                    const SizedBox(height: 20.0),

                    const Text("Workers needed", style: textStyle1),

                    const SizedBox(height: 10.0),

                    Text(jobDetail.workers.toString(), style: textStyle2),

                    const SizedBox(height: 20.0),

                    if (jobDetail.fixedPay != 0)
                      ...[
                        const Text("Fixed pay", style: textStyle1),
                        const SizedBox(height: 10.0),
                        Text("\$${jobDetail.fixedPay}", style: textStyle2)
                      ]
                    else
                      ...[
                        const Text("Hourly pay", style: textStyle1),
                        const SizedBox(height: 10.0),
                        Text("\$${jobDetail.payRate!.toStringAsFixed(2)}/hr * ${jobDetail.hours} hours", style: textStyle2)
                      ]
                    ,

                    const SizedBox(height: 20.0),

                    const Text("Rating", style: textStyle1),

                    const SizedBox(height: 10.0),

                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orangeAccent),
                        const SizedBox(width: 5.0),
                        Text(jobDetail.rating!, style: textStyle2)
                      ],
                    ),

                    const SizedBox(height: 20.0),

                    const Text("Description", style: textStyle1),

                    const SizedBox(height: 10.0),

                    Text(jobDetail.desc!, style: textStyle2)
                  ]
                ),
              )
            )
          ],
        ),
      )
    );
  }
}
