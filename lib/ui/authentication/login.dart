// ignore_for_file: use_build_context_synchronously, unawaited_futures

import 'dart:async';

import 'package:beamcoda_jobs_partners_flutter/data/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../ui/authentication/register.dart';
import '../../utils/constants.dart';
import '../layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isWorker = true;
  TextEditingController email = TextEditingController(), password = TextEditingController(), phoneNumber = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    email.dispose();
    password.dispose();
    phoneNumber.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    const Color defaultTextColor = Color.fromRGBO(76, 76, 76, 1.0);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    const btnRadius = 22.0;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              color: Colors.blue,
              iconSize: 30.0,
              padding: const EdgeInsets.all(0),
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),

            const Text("Log in to your Shiftwork account", textAlign: TextAlign.start, style: TextStyle(
              color: defaultTextColor,
              fontSize: 36.0,
              fontWeight: FontWeight.w700,
            )),

            const SizedBox(height: 20.0),

            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          if (!isWorker) {
                            setState(() {
                              isWorker = true;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: isWorker
                              ? BoxDecoration(
                              color: Colors.blue,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(btnRadius), bottomLeft: Radius.circular(btnRadius)),
                              border: Border.all(color: Colors.blue, width: 1.0)
                          )
                              : BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(btnRadius), bottomLeft: Radius.circular(btnRadius)),
                              border: Border.all(color: Colors.blue, width: 1.0)) ,
                          child: Center(
                              child: Text("Worker", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: isWorker ? Colors.white : Colors.blue))
                          ),
                        )
                    )
                ),

                Expanded(
                  child: GestureDetector(
                      onTap: () {
                        if (isWorker){
                          setState(() {
                            isWorker = false;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        decoration: isWorker
                            ? BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(btnRadius), bottomRight: Radius.circular(btnRadius)),
                            border: Border.all(color: Colors.blue, width: 1.0))
                            : BoxDecoration(
                            color: Colors.blue,
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(btnRadius), bottomRight: Radius.circular(btnRadius)),
                            border: Border.all(color: Colors.blue, width: 1.0)),
                        child: Center(
                            child: Text("Partner", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: isWorker ? Colors.blue : Colors.white))
                        ),
                      )
                  ),
                )
              ],
            ),

            const SizedBox(height: 20.0),

            if (isWorker)
              TextFormField(
                controller: phoneNumber,
                style: const TextStyle(fontSize: 18.0, color: defaultTextColor),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'(^\d\d{0,9})'))
                ],
                decoration: const InputDecoration(
                    hintText: "Enter your phone number",
                    hintStyle: TextStyle(color: Colors.grey)
                )
              )
            else
              ...[
                TextFormField(
                  controller: email,
                  style: const TextStyle(fontSize: 18.0, color: defaultTextColor),
                  decoration: const InputDecoration(
                    label: Text("Email", style: TextStyle(color: Colors.grey))
                  )
                ),

                const SizedBox(height: 20.0),

                TextFormField(
                  controller: password,
                  style: const TextStyle(fontSize: 18.0, color: defaultTextColor),
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text("Password", style: TextStyle(color: Colors.grey))
                  )
                ),
              ],

            const SizedBox(height: 20.0),

            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const Register();
                        },
                      )
                    );
                  },
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.blue, backgroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18.0),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0), side: const BorderSide(color: Colors.blue, width: 1.0)),
                  ),
                  child: const Text("Sign up"),
                ),

                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () async{
                        String? result;

                        if (isWorker) {
                          result = await authProvider.loginWorker(phoneNumber.value!.text);
                        } else {
                          result = await authProvider.loginPartner(email.value!.text, password.value!.text);
                        }

                        if (result == '') {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  authProvider.isWorker = isWorker;
                                  return LayoutPage(key: UniqueKey());
                                },
                              )
                          );
                        }
                        else {
                          Util.showToast(result);
                        }
                      },
                      style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.blue,
                        textStyle: const TextStyle(fontSize: 18.0),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
                      ),
                      child: const Text("Log in"),
                    )
                  )
                )
              ],
            )
          ]
        )
      )
    );
  }
}