import 'package:beamcoda_jobs_partners_flutter/data/auth.dart';
import 'package:beamcoda_jobs_partners_flutter/ui/profile/verifieditem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../../types/verifiedpartner.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({super.key});

  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  bool isEditing = false;
  List<VerifiedPartner> verifiedPartners = [
    VerifiedPartner(name: "John Ronaldo", companyName: "Kreston Sales Company"),
    VerifiedPartner(name: "Marina Stoe", companyName: "Minnesota Bar")
  ];
  FocusNode myFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
  }

  void saveProfile(BuildContext context) async{
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

    await Future.delayed(const Duration(seconds: 3));

    Navigator.of(context).pop();
  }

  void VerifyWorker(BuildContext context) async{
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
                  Text('Wait...')
                ],
              ),
            ),
          );
        });

    await Future.delayed(const Duration(seconds: 3));

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    const Color defaultTextColor = Color.fromRGBO(76, 76, 76, 1.0);
    const Color warnColor = Color.fromRGBO(255, 151, 150, 1.0);
    const Color warnBackcolor = Color.fromRGBO(254, 241, 207, 1.0);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTextStyle(
        style: const TextStyle(fontSize: 18.0, color: defaultTextColor),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),

              Center(
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(75.0),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/sample_photo.png"),
                      fit: BoxFit.cover
                    ),
                  ),
                )
              ),

              const SizedBox(height: 10.0),

              const Center(
                child: Text("Charles Robinson", style: TextStyle(fontSize: 36.0, color: defaultTextColor, fontWeight: FontWeight.w700)),
              ),

              const SizedBox(height: 10.0),

              const Center(
                child: Text("Habor Gateway North, Garden", style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.w400)),
              ),

              const SizedBox(height: 20.0),

              const Text("Profile strength", style: TextStyle(fontSize: 24.0, color: defaultTextColor, fontWeight: FontWeight.w700)),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: const LinearProgressIndicator(color: warnColor, backgroundColor: Color.fromRGBO(225, 225, 225, 1), value: 0.3, minHeight: 10.0),
                )
              ),

              const Text("Weak", style: TextStyle(fontSize: 18.0, color: warnColor, fontWeight: FontWeight.w400)),

              const SizedBox(height: 10.0),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: warnBackcolor
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Row(
                  children: const [
                    Icon(Icons.warning_amber, color: warnColor),
                    SizedBox(width: 10.0),
                    Text("Add profile photo", style: TextStyle(color: Colors.lightBlue, fontSize: 18.0))
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: warnBackcolor
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Row(
                  children: const [
                    Icon(Icons.warning_amber, color: warnColor),
                    SizedBox(width: 10.0),
                    Text("Enter birthday", style: TextStyle(color: Colors.lightBlue, fontSize: 18.0))
                  ],
                )
              ),

              const SizedBox(height: 20.0),

              Container(
                color: Colors.grey.withOpacity(0.3),
                height: 10.0
              ),

              const SizedBox(height: 40.0),

              const Text("Edit profile", style: TextStyle(fontSize: 36.0, color: defaultTextColor, fontWeight: FontWeight.w700)),

              const SizedBox(height: 20.0),

              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: (){
                    if (isEditing) {
                      saveProfile(context);
                    }
                    else {
                      myFocusNode.requestFocus();
                    }

                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.blue,
                    textStyle: const TextStyle(fontSize: 18.0),
                    padding: const EdgeInsets.all(15.0),
                    shape: const StadiumBorder(),
                  ),
                  child: !isEditing ? const Text("Edit") : const Text("Ok"),
                )
              ),

              const SizedBox(height: 20.0),

              Row(
                children: const [
                  Expanded(
                    child: Text("First name", style: TextStyle(fontWeight: FontWeight.w700))
                  ),

                  SizedBox(width: 10.0),

                  Expanded(
                    child: Text("Last name", style: TextStyle(fontWeight: FontWeight.w700))
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: "John",
                      validator: (value) => value!.isEmpty ? "required" : null,
                      readOnly: !isEditing,
                      focusNode: myFocusNode,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),

                  const SizedBox(width: 10.0),

                  Expanded(
                    child: TextFormField(
                      initialValue: "Smith",
                      validator: (value) => value!.isEmpty ? "required" : null,
                      readOnly: !isEditing,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20.0),

              const Text("Email", style: TextStyle(fontWeight: FontWeight.w700)),

              TextFormField(
                initialValue: "abc@123.com",
                validator: (value) => value!.isEmpty ? "required" : null,
                readOnly: !isEditing,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 20.0),

              const Text("Address", style: TextStyle(fontWeight: FontWeight.w700)),

              TextFormField(
                initialValue: "Kreston Roseville",
                validator: (value) => value!.isEmpty ? "required" : null,
                readOnly: !isEditing,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 20.0),

              const Text("Birthday", style: TextStyle(fontWeight: FontWeight.w700)),

              TextFormField(
                onTap: () {
                  if (isEditing){
                    DatePicker.showDatePicker(context,
                      locale: LocaleType.en,
                      onConfirm: (time) {
                      },
                    );
                  }
                },
                initialValue: "2022.10.30",
                validator: (value) => value!.isEmpty ? "required" : null,
                readOnly: !isEditing,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 20.0),

              Container(
                  color: Colors.grey.withOpacity(0.3),
                  height: 10.0
              ),

              const SizedBox(height: 40.0),

              const Text("Your link", style: TextStyle(fontSize: 36.0, color: defaultTextColor, fontWeight: FontWeight.w700)),

              const SizedBox(height: 20.0),

              Text("https://shiftwork.com/${authProvider.isWorker ? 'partners' : 'workers'}/458269071",
                style: const TextStyle(color: defaultTextColor, fontSize: 18.0, fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 10.0),

              if (authProvider.isWorker)
                const Text("You can share this link to get shifts from co-worker.", style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.w500))
              else
                const Text("You can share this link to the worker you trust.", style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.w500))
              ,

              if (authProvider.isWorker)
                ...[
                  const SizedBox(height: 20.0),

                Container(
                    color: Colors.grey.withOpacity(0.3),
                    height: 10.0
                ),

                const SizedBox(height: 40.0),

                const Text("Get verified", style: TextStyle(fontSize: 36.0, color: defaultTextColor, fontWeight: FontWeight.w700)),

                const SizedBox(height: 20.0),

                const Text("Get verified by providing partner link. The more you get verified partners, the more you get shifts.",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.w500)),

                const SizedBox(height: 10.0),

                TextFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 18.0, color: Colors.grey),
                    hintText: "https://shiftwork.com/partners/"
                  ),
                  style: const TextStyle(color: defaultTextColor, fontSize: 18.0)
                ),

                const SizedBox(height: 20.0),

                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () {
                      VerifyWorker(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      elevation: 0,
                      textStyle: const TextStyle(fontSize: 18.0),
                      padding: const EdgeInsets.all(15.0),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text("Verify"),
                  )
                ),

                const SizedBox(height: 20.0),

                if (verifiedPartners.isEmpty)
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: const Center(
                        child: Text("You aren't verified by any partners.", style: TextStyle(fontSize: 18.0, color: Colors.blue, fontWeight: FontWeight.w700)),
                      )
                    ),
                  )
                else
                  ...[
                    const Text("Partners you get verified by", style: TextStyle(fontSize: 18.0, color: defaultTextColor, fontWeight: FontWeight.w700)),

                    const SizedBox(height: 20.0),

                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: verifiedPartners.length,
                      itemBuilder: (context, index) {
                        return VerifiedItem(key: UniqueKey(), partnerInfo: verifiedPartners[index]);
                      }
                    ),
                  ],
                ],
            ],
          ),
        ),
      ),
    );
  }
}