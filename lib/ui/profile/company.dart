import 'package:beamcoda_jobs_partners_flutter/data/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileCompany extends StatefulWidget {
  const ProfileCompany({super.key});

  @override
  State<ProfileCompany> createState() => _ProfileCompanyState();
}

class _ProfileCompanyState extends State<ProfileCompany> {
  bool isEditing = false;
  FocusNode myFocusNode = FocusNode();

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

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color defaultTextColor = Color.fromRGBO(76, 76, 76, 1.0);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
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
                    image: AssetImage("assets/icons/company.png")
                  )
                ),
              )
            ),

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

            DefaultTextStyle(
              style: const TextStyle(fontSize: 18.0, color: defaultTextColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Company Name", style: TextStyle(fontWeight: FontWeight.w700)),

                  TextFormField(
                    key: UniqueKey(),
                    initialValue: authProvider.partner?.companyName,
                    validator: (value) => value!.isEmpty ? "required" : null,
                    readOnly: !isEditing,
                    focusNode: myFocusNode,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 20.0),

                  const Text("Company Location", style: TextStyle(fontWeight: FontWeight.w700)),

                  TextFormField(
                    key: UniqueKey(),
                    initialValue: authProvider.partner?.companyLocation,
                    validator: (value) => value!.isEmpty ? "required" : null,
                    readOnly: !isEditing,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 20.0),

                  const Text("Business EIN", style: TextStyle(fontWeight: FontWeight.w700)),

                  TextFormField(
                    key: UniqueKey(),
                    initialValue: authProvider.partner?.EIN,
                    validator: (value) => value!.isEmpty ? "required" : null,
                    readOnly: !isEditing,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ]
              )
            )
          ],
        ),
      ),
    );
  }
}