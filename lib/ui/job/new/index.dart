import 'package:beamcoda_jobs_partners_flutter/ui/job/help_verified.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/auth.dart';
import '../../../data/job.dart';
import '../../../types/jobnew.dart';
import '../../../utils/constants.dart';

class NewJobPost extends StatefulWidget {
  const NewJobPost({super.key});

  @override
  State<NewJobPost> createState() => _NewJobPostState();
}

class _NewJobPostState extends State<NewJobPost> {
  TextEditingController stTime = TextEditingController();
  TextEditingController edTime = TextEditingController();
  bool isFixed = true;
  bool isVerified = false;
  final formKey = GlobalKey<FormState>();
  JobNew newJob = JobNew(id: 0, title: "", type: "", location: "", startDate: "", endDate: "", workers: 0, payRate: 0, desc: "", fixedPay: 0, hours: 0, isVerified: false);

  void onPaytypeToggle(bool value) {
    setState(() {
      isFixed = !value;

      if (!isFixed) {
        newJob.fixedPay = 0;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    stTime.dispose();
    edTime.dispose();
  }

  void postJob(BuildContext context) async{
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
                  Text('Posting...')
                ],
              ),
            ),
          );
        });

    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    String result = await jobProvider.postJob(context, newJob);

    if (result != '') {
      Util.showToast(result);
    }

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    const Color defaultTextColor = Color.fromRGBO(76, 76, 76, 1.0);
    const TextStyle textStyle1 = TextStyle(fontSize: 20.0, color: defaultTextColor);
    const TextStyle textStyle2 = TextStyle(fontSize: 18.0, color: defaultTextColor, fontWeight: FontWeight.w700);
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
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: (){
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          postJob(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.blue,
                        textStyle: const TextStyle(fontSize: 18.0),
                        padding: const EdgeInsets.all(15.0),
                        shape: const StadiumBorder(),
                      ),
                      child: const Text("Post"),
                    )
                  ),
                )
              ],
            ),

            const SizedBox(height: 10.0),

            const Text("Shift details", textAlign: TextAlign.start, style: TextStyle(
              color: defaultTextColor,
              fontSize: 36.0,
              fontWeight: FontWeight.w700,
            )),

            const SizedBox(height: 10.0),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: isVerified,
                            onChanged: (value) {
                              newJob.isVerified = value!;
                              setState(() {
                                isVerified = value;
                              });
                            },
                          ),
                          const SizedBox(width: 5.0),
                          const Text("Only verified workers", style: TextStyle(color: Colors.grey, fontSize: 18.0)),
                          const SizedBox(width: 5.0),
                          const Icon(Icons.verified, color: Colors.green),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                    return const HelpVerified();
                                  }));
                                },
                                child: const Icon(Icons.help_outline, color: Colors.blue),
                              )

                            ),
                          )
                        ]
                      ),

                      const SizedBox(height: 10.0),

                      TextFormField(
                        validator: (value) => value!.isEmpty ? "Required" : null,
                        onSaved: (value) => newJob.title = value!,
                        decoration: const InputDecoration(
                          label: Text("Title", style: textStyle2),
                        ),
                        style: textStyle1
                      ),

                      const SizedBox(height: 10.0),

                      TextFormField(
                        validator: (value) => value!.isEmpty ? "Required" : null,
                        onSaved: (value) => newJob.type = value!,
                        decoration: const InputDecoration(
                            label: Text("Shift type", style: textStyle2)
                        ),
                        style: textStyle1
                      ),

                      const SizedBox(height: 10.0),

                      TextFormField(
                        validator: (value) => value!.isEmpty ? "Required" : null,
                        onSaved: (value) => newJob.location = value!,
                        decoration: const InputDecoration(
                            label: Text("Location", style: textStyle2)
                        ),
                        style: textStyle1,
                      ),

                      const SizedBox(height: 10.0),

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
                                    stTime.text = "${time.year}.${time.month}.${time.day}" ;
                                  },
                                );
                              },
                              decoration: const InputDecoration(
                                  label: Text("Start time", style: textStyle2)
                              ),
                              style: textStyle1,
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
                                    edTime.text = "${time.year}.${time.month}.${time.day}" ;
                                  },
                                );
                              },
                              decoration: const InputDecoration(
                                  label: Text("End time", style: textStyle2),
                              ),
                              style: textStyle1,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 10.0),

                      TextFormField(
                        validator: (value) => value!.isEmpty ? "Required" : null,
                        onSaved: (value) => newJob.workers = int.parse(value!),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                            label: Text("Workers needed", style: textStyle2),
                        ),
                        style: textStyle1
                      ),

                      const SizedBox(height: 20.0),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Fixed", style: textStyle2),
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
                          const Text("Hourly", style: textStyle2),
                          const Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Icon(Icons.attach_money ,color: Colors.blue)
                            )
                          )
                        ],
                      ),

                      const SizedBox(height: 10.0),

                      if (isFixed)
                        TextFormField(
                          validator: (value) => value!.isEmpty ? "required" : null,
                          onSaved: (newValue) => newJob.fixedPay = int.parse(newValue!),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            label: Text("Fixed price", style: textStyle2),
                          ),
                          style: textStyle1
                        )
                      else
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (value) => value!.isEmpty ? "required" : null,
                                onSaved: (newValue) => newJob.hours = int.parse(newValue!),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                  label: Text("Hours needed", style: textStyle2),
                                ),
                                style: textStyle1
                              )
                            ),

                            const SizedBox(width: 10.0),

                            Expanded(
                                child: TextFormField(
                                  validator: (value) => value!.isEmpty ? "required" : null,
                                  onSaved: (newValue) => newJob.payRate = double.parse(newValue!),
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,2})'))
                                  ],
                                  decoration: const InputDecoration(
                                    label: Text("Hourly pay", style: textStyle2),
                                  ),
                                  style: textStyle1
                                )
                            )
                          ],
                        ),

                      const SizedBox(height: 10.0),

                      TextFormField(
                        maxLines: null,
                        validator: (value) => value!.isEmpty ? "Required" : null,
                        onSaved: (value) => newJob.desc = value!,
                        decoration: const InputDecoration(
                            label: Text("Description", style: textStyle2)
                        ),
                        style: textStyle1
                      ),
                    ],
                  )
                )
              )
            )
          ],
        ),
      ),
    );
  }
}