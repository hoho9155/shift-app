import 'package:beamcoda_jobs_partners_flutter/ui/job/applicants/index.dart';
import 'package:beamcoda_jobs_partners_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../data/job.dart';
import '../../types/jobdetail.dart';
import '../../types/jobnew.dart';

class ViewJobPost extends StatefulWidget {
  final int id;
  const ViewJobPost({super.key, required this.id});

  @override
  State<ViewJobPost> createState() => _ViewJobPostState();
}

class _ViewJobPostState extends State<ViewJobPost> {
  bool isEditing = false;
  bool isFixed = true;
  final formKey = GlobalKey<FormState>();
  JobNew newJob = JobNew(id: 0, title: "", type: "", location: "", startDate: "", endDate: "", workers: 0, payRate: 0, desc: "", hours: 0, fixedPay: 0, isVerified: false);
  late TextEditingController stTime;
  late TextEditingController edTime;
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    stTime = TextEditingController();
    edTime = TextEditingController();
    myFocusNode = FocusNode();

    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    jobProvider.curJob.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String result = await jobProvider.getJobDetail(context, widget.id);

      if (result != '') {
        Util.showToast(result);
      }
    });
  }

  @override
  void dispose() {
    stTime.dispose();
    edTime.dispose();
    myFocusNode.dispose();

    super.dispose();
  }

  void onPaytypeToggle(bool value) {
    setState(() {
      isFixed = !value;

      if (!isFixed) {
        newJob.fixedPay = 0;
      }
    });
  }

  void saveJob(BuildContext context) async{
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
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 15),
                Text('Saving...')
              ],
            ),
          ),
        );
      });

    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    newJob.id = jobProvider.curJob.id!;
    String result = await jobProvider.editJob(context, newJob);

    if (result != '')
      Util.showToast(result);

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void deleteJob(BuildContext context) async{
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
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 15),
                  Text('Deleting...')
                ],
              ),
            ),
          );
        });

    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    String result = await jobProvider.deleteJob(context, jobProvider.curJob.id!);

    if (result != '')
      Util.showToast(result);

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    const Color defaultTextColor = Color.fromRGBO(76, 76, 76, 1.0);
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
                if (jobDetail.status == JobStatus.ACTIVE)
                  ...[
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: (){
                            if (!isEditing) {
                              deleteJob(context);
                            }
                            else {
                              setState(() {
                                isEditing = false;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(foregroundColor: Colors.blue, backgroundColor: Colors.white,
                            textStyle: const TextStyle(fontSize: 18.0),
                            padding: const EdgeInsets.all(15.0),
                            shape: const StadiumBorder(side: BorderSide(color: Colors.blue)),
                            elevation: 0
                          ),
                          child: !isEditing ? const Text("Delete") : const Text("Cancel"),
                        )
                      ),
                    ),

                    const SizedBox(width: 15.0),

                    ElevatedButton(
                      onPressed: () {
                        if (isEditing) {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            saveJob(context);
                          }
                        }

                        else {
                          myFocusNode.requestFocus();
                          setState(() {
                            isEditing = true;
                            isFixed = jobDetail.fixedPay != 0;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.blue,
                        textStyle: const TextStyle(fontSize: 18.0),
                        padding: const EdgeInsets.all(15.0),
                        shape: const StadiumBorder(),
                      ),
                      child: !isEditing ? const Text("Edit") : const Text("Ok"),
                    )
                  ]
              ],
            ),

            const SizedBox(height: 10.0),

            if (jobDetail.status == JobStatus.ACTIVE)
              FractionallySizedBox(
                widthFactor: 1.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return ApplicantsPage(jobID: jobProvider.curJob.id!);
                    }));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3.0),
                      border: Border.all(color: Colors.blue, width: 1.0)
                    ),

                    child: const Center(
                      child: Text("Applicants", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500, color: Colors.blue)),
                    )
                  ),
                )
              ),

            const SizedBox(height: 20.0),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: DefaultTextStyle(
                  style: const TextStyle(fontSize: detailFont, color: defaultTextColor),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Title", style: TextStyle(fontWeight: FontWeight.w700)),

                        TextFormField(
                          key:UniqueKey(),
                          initialValue: jobDetail.title,
                          validator: (value) => value!.isEmpty ? "required" : null,
                          onSaved: (newValue) => newJob.title = newValue!,
                          readOnly: !isEditing,
                          focusNode: myFocusNode,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),

                        const SizedBox(height: 20.0),

                        const Text("Shift type", style: TextStyle(fontWeight: FontWeight.w700)),

                        TextFormField(
                          key:UniqueKey(),
                          initialValue: jobDetail.type,
                          validator: (value) => value!.isEmpty ? "required" : null,
                          onSaved: (newValue) => newJob.type = newValue!,
                          readOnly: !isEditing,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),

                        const SizedBox(height: 20.0),

                        const Text("Location", style: TextStyle(fontWeight: FontWeight.w700)),

                        TextFormField(
                          key:UniqueKey(),
                          initialValue: jobDetail.location,
                          validator: (value) => value!.isEmpty ? "required" : null,
                          onSaved: (newValue) => newJob.location = newValue!,
                          readOnly: !isEditing,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),

                        const SizedBox(height: 20.0),

                        const Text("Company", style: TextStyle(fontWeight: FontWeight.w700)),

                        const SizedBox(height: 10.0),

                        Text(jobDetail.company!, style: const TextStyle(fontWeight: FontWeight.w500)),

                        const SizedBox(height: 20.0),

                        if (!isEditing)
                          ...[
                            const Text("Duration", style: TextStyle(fontWeight: FontWeight.w700)),
                            const SizedBox(height: 10.0),
                            Text(jobDetail.duration!, style: const TextStyle(fontWeight: FontWeight.w500)),
                          ]
                        else
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  validator: (value) => value!.isEmpty ? "Required" : null,
                                  onSaved: (value) => newJob.startDate = value!,
                                  controller: stTime,
                                  onTap: () {
                                    DatePicker.showDatePicker(context, currentTime: DateTime.now(), minTime: DateTime.now(),
                                      locale: LocaleType.en,
                                      onConfirm: (time) {
                                        stTime.text = DateFormat("yyyy-MM-dd hh:mm:ss").format(time);
                                      },
                                    );
                                  },
                                  decoration: const InputDecoration(
                                    label: Text("Start time", style: TextStyle(fontWeight: FontWeight.w700))
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10.0),

                              Expanded(
                                child: TextFormField(
                                  validator: (value) => value!.isEmpty ? "Required" : null,
                                  onSaved: (value) => newJob.endDate = value!,
                                  controller: edTime,
                                  onTap: () {
                                    DatePicker.showDatePicker(context, currentTime: DateTime.now(), minTime: DateTime.now(),
                                      locale: LocaleType.en,
                                      onConfirm: (time) {
                                        edTime.text = DateFormat("yyyy-MM-dd hh:mm:ss").format(time);
                                      },
                                    );
                                  },
                                  decoration: const InputDecoration(
                                      label: Text("End time", style: TextStyle(fontWeight: FontWeight.w700))
                                  ),
                                ),
                              )
                            ],
                          )
                        ,

                        const SizedBox(height: 20.0),

                        const Text("Workers needed", style: TextStyle(fontWeight: FontWeight.w700)),

                        TextFormField(
                          key:UniqueKey(),
                          initialValue: jobDetail.workers.toString(),
                          validator: (value) => value!.isEmpty ? "required" : null,
                          onSaved: (newValue) => newJob.workers = int.parse(newValue!),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          readOnly: !isEditing,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),

                        const SizedBox(height: 20.0),

                        if (isEditing)
                          ...[
                            Row(
                              children: [
                                const Text("Fixed", style: TextStyle(fontWeight: FontWeight.w700)),
                                const SizedBox(width: 10.0),
                                Switch(
                                  onChanged: onPaytypeToggle,
                                  value: !isFixed,
                                  activeColor: Colors.blue.withOpacity(0.8),
                                  inactiveThumbColor: Colors.blue.withOpacity(0.8),
                                  activeTrackColor: Colors.grey.withOpacity(0.4),
                                  inactiveTrackColor: Colors.grey.withOpacity(0.4),
                                ),
                                const SizedBox(width: 10.0),
                                const Text("Hourly", style: TextStyle(fontWeight: FontWeight.w700)),
                              ],
                            ),

                            if (isFixed)
                              TextFormField(
                                validator: (value) => value!.isEmpty ? "required" : null,
                                onSaved: (newValue) => newJob.fixedPay = int.parse(newValue!),
                                initialValue: jobDetail.fixedPay.toString(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                  hintText: "Fixed price",
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0)
                                ),
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              )
                            else
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      validator: (value) => value!.isEmpty ? "required" : null,
                                      onSaved: (newValue) => newJob.hours = int.parse(newValue!),
                                      initialValue: jobDetail.hours.toString(),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: const InputDecoration(
                                          hintText: "Hours needed",
                                          hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0)
                                      ),
                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                    )
                                  ),

                                  const SizedBox(width: 10.0),

                                  Expanded(
                                    child: TextFormField(
                                      validator: (value) => value!.isEmpty ? "required" : null,
                                      onSaved: (newValue) => newJob.payRate = double.parse(newValue!),
                                      initialValue: jobDetail.payRate!.toStringAsFixed(2),
                                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,2})'))
                                      ],
                                      decoration: const InputDecoration(
                                          hintText: "Hourly pay",
                                          hintStyle: TextStyle(color: Colors.grey, fontSize: 18.0)
                                      ),
                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                    )
                                  )
                                ],
                              ),
                          ]
                        else if (jobDetail.fixedPay != 0)
                          ...[
                            const Text("Fixed pay", style: TextStyle(fontWeight: FontWeight.w700)),
                            const SizedBox(height: 10.0),
                            Text("\$${jobDetail.fixedPay}", style: const TextStyle(fontWeight: FontWeight.w500))
                          ]
                        else
                          ...[
                            const Text("Hourly pay", style: TextStyle(fontWeight: FontWeight.w700)),
                            const SizedBox(height: 10.0),
                            Text("\$${jobDetail.payRate!.toStringAsFixed(2)}/hr * ${jobDetail.hours} hours", style: const TextStyle(fontWeight: FontWeight.w700))
                          ]
                        ,

                        const SizedBox(height: 20.0),

                        const Text("Rating", style: TextStyle(fontWeight: FontWeight.w700)),

                        const SizedBox(height: 10.0),

                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.orangeAccent),
                            const SizedBox(width: 5.0),
                            Text(jobDetail.rating!, style: const TextStyle(fontWeight: FontWeight.w500))
                          ],
                        ),

                        const SizedBox(height: 20.0),

                        const Text("Description", style: TextStyle(fontWeight: FontWeight.w700)),

                        TextFormField(
                          key:UniqueKey(),
                          maxLines: null,
                          initialValue: jobDetail.desc,
                          validator: (value) => value!.isEmpty ? "required" : null,
                          onSaved: (newValue) => newJob.desc = newValue!,
                          readOnly: !isEditing,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                )
              )
            )
          ],
        ),
      )
    );
  }
}
