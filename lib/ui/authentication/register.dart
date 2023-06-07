// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:beamcoda_jobs_partners_flutter/data/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../types/partner.dart';
import '../../types/register_partner.dart';
import '../../types/user.dart';
import '../../utils/constants.dart';
import '../layout.dart';

class Info {
  Partner partner = Partner(firstName: "", lastName: "", phoneNumber: "", email: "", password: "", companyLocation: "", companyName: "", EIN: "");
  User worker = User(firstName: "", lastName: "", phoneNumber: "", email: "");
  bool isWorker = true;
  String code = '';
  String enteredCode = '';
}

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class RegisterInfo extends StatefulWidget {
  const RegisterInfo({super.key, required this.info, required this.formKey});
  final Info info;
  final GlobalKey<FormState> formKey;

  @override
  State<RegisterInfo> createState() => _RegisterInfoState();
}

class _RegisterInfoState extends State<RegisterInfo> {
  bool isWorker = true;
  late TextEditingController confirmControl;

  @override
  void initState() {
    super.initState();

    confirmControl = TextEditingController();
  }

  @override
  void dispose() {
    confirmControl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color defaultTextColor = Color.fromRGBO(76, 76, 76, 1.0);
    const btnRadius = 22.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text("Create account", textAlign: TextAlign.start, style: TextStyle(
          color: defaultTextColor,
          fontSize: 36.0,
          fontWeight: FontWeight.w700,
        )),

        const SizedBox(height: 20.0),

        Form(
          key: widget.formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (!isWorker) {
                          setState(() {
                            isWorker = true;
                            widget.info.isWorker = isWorker;
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
                            widget.info.isWorker = isWorker;
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

              const SizedBox(height: 10.0),

              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                        validator: (value) => value!.isEmpty ? "Required" : null,
                        onSaved: (value) {
                          if (widget.info.isWorker) {
                            widget.info.worker.firstName = value!;
                          } else {
                            widget.info.partner.firstName = value!;
                          }
                        },
                        style: const TextStyle(fontSize: 18.0, color: defaultTextColor),
                        decoration: const InputDecoration(
                          label: Text("First name", style: TextStyle(color: Colors.grey))
                        )
                    ),
                  ),

                  const SizedBox(width: 10.0),

                  Expanded(
                    flex: 1,
                    child: TextFormField(
                        validator: (value) => value!.isEmpty ? "Required" : null,
                        onSaved: (value) {
                          if (widget.info.isWorker) {
                            widget.info.worker.lastName = value!;
                          } else {
                            widget.info.partner.lastName = value!;
                          }
                        },
                        style: const TextStyle(fontSize: 18.0, color: defaultTextColor),
                        decoration: const InputDecoration(
                          label: Text("Last name", style: TextStyle(color: Colors.grey))
                        )
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20.0),

              TextFormField(
                  validator: (value) => value!.isEmpty ? "Required" : null,
                  onSaved: (value) {
                    if (widget.info.isWorker) {
                      widget.info.worker.phoneNumber = value!;
                    } else {
                      widget.info.partner.phoneNumber = value!;
                    }
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'(^\d\d{0,9})'))
                  ],
                  style: const TextStyle(fontSize: 18.0, color: defaultTextColor),
                  decoration: const InputDecoration(
                    label: Text("Phone number", style: TextStyle(color: Colors.grey))
                  )
              ),

              const SizedBox(height: 20.0),

              TextFormField(
                  validator: (value) => value!.isEmpty ? "Required" : null,
                  onSaved: (value) {
                    if (widget.info.isWorker) {
                      widget.info.worker.email = value!;
                    } else {
                      widget.info.partner.email = value!;
                    }
                  },
                  style: const TextStyle(fontSize: 18.0, color: defaultTextColor),
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    label: Text("Email address", style: TextStyle(color: Colors.grey))
                  )
              ),

              if (!isWorker)
                ...[
                  const SizedBox(height: 20.0),

                  TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "required";
                        }
                        return value != confirmControl.text ? "Confirm mismatch" : null;
                      },
                      onSaved: (value) {
                        widget.info.partner.password = value!;
                      },
                      style: const TextStyle(fontSize: 18.0, color: defaultTextColor),
                      obscureText: true,
                      decoration: const InputDecoration(
                          label: Text("Password", style: TextStyle(color: Colors.grey))
                      )
                  ),

                  const SizedBox(height: 20.0),

                  TextFormField(
                      controller: confirmControl,
                      validator: (value) => value!.isEmpty ? "Required" : null,
                      onSaved: (value) {
                        widget.info.partner.password = value!;
                      },
                      obscureText: true,
                      style: const TextStyle(fontSize: 18.0, color: defaultTextColor),
                      decoration: const InputDecoration(
                          label: Text("Confirm password", style: TextStyle(color: Colors.grey))
                      )
                  ),

                  const SizedBox(height: 20.0),

                  TextFormField(
                      validator: (value) => value!.isEmpty ? "Required" : null,
                      onSaved: (value) {
                        widget.info.partner.companyName = value!;
                      },
                      style: const TextStyle(fontSize: 18.0, color: defaultTextColor),
                      decoration: const InputDecoration(
                          label: Text("Business name", style: TextStyle(color: Colors.grey))
                      )
                  ),

                  const SizedBox(height: 20.0),

                  TextFormField(
                      validator: (value) => value!.isEmpty ? "Required" : null,
                      onSaved: (value) {
                        widget.info.partner.EIN = value!;
                      },
                      style: const TextStyle(fontSize: 18.0, color: defaultTextColor),
                      decoration: const InputDecoration(
                          label: Text("Business EIN", style: TextStyle(color: Colors.grey))
                      )
                  ),
                ]
            ]
          ),
        ),

        const SizedBox(height: 40.0),

        const Text("By tapping Next, you agree to our Privacy Policy and Terms of Use.", textAlign: TextAlign.center, style: TextStyle(
          fontSize: 15.0,
          color: Colors.grey,
        )),
      ],
    );
  }
}

class VerifyCode extends StatefulWidget {
  const VerifyCode({super.key, required this.phoneNumber, required this.info});
  final String phoneNumber;
  final Info info;
  
  @override
  State<VerifyCode> createState()=> _VerifyCodeState();
}

class _RegisterState extends State<Register> {
  int state = 0;
  Info shareInfo = Info();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                  color: Colors.blue,
                  iconSize: 30.0,
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    if (state == 0) {
                      Navigator.pop(context);
                    }
                    else {
                      setState(() {
                        state = 0;
                      });
                    }
                  },
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        textStyle: const TextStyle(fontSize: 18.0, color: Colors.white),
                        padding: const EdgeInsets.all(15.0),
                        shape: const StadiumBorder(),
                      ),
                      child: const Text("Next"),
                      onPressed: () async{
                        if (state == 0) {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            setState(() {
                              state = 1;
                            });
                          }
                        }
                        else {
                          if (shareInfo.code != '' && shareInfo.code == shareInfo.enteredCode) {
                            String? result;

                            if (shareInfo.isWorker) {
                              result = await authProvider.registerWorker(shareInfo.worker);
                            }
                            else {
                              result = await authProvider.registerPartner(shareInfo.partner);
                            }

                            if (result == '') {
                              await Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                    authProvider.isWorker = shareInfo.isWorker;
                                    return LayoutPage(key: UniqueKey());
                                  }), (route) => false);
                            }
                            else {
                              Util.showToast(result);
                            }
                          }
                          else {
                            Util.showToast("Incorrect code");
                          }
                        }
                      },
                    ),
                  )
                )
              ],
            ),

            const SizedBox(height: 10.0),

            state == 0 ?
                RegisterInfo(info: shareInfo, formKey: formKey)
                :
                VerifyCode(info: shareInfo, phoneNumber: shareInfo.isWorker ? shareInfo.worker.phoneNumber! : shareInfo.partner.phoneNumber!),
          ],
        ),
      )
    );
  }
}

class _VerifyCodeState extends State<VerifyCode> {
  @override
  void initState(){
    super.initState();

    sendNewCode();
  }

  Future<void> sendNewCode() async{
    bool canSend = await canSendSMS();

    if (!canSend) {
      Util.showToast("Sorry, you can't send verify code on this phone");
      return;
    }

    String code = '';
    Random random = Random();

    for(int i = 0; i < 4; i++) {
      int randomNumber = random.nextInt(10);

      code = "$code$randomNumber";
    }
    widget.info.code = code;

    bool isAndroid = Theme.of(context).platform == TargetPlatform.android;
    await sendSMS(message: code!, recipients: ['1${widget.phoneNumber}'], sendDirect: isAndroid)
        .catchError((onError) {
      Util.showToast("Error while sending code...${onError.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color defaultTextColor = Color.fromRGBO(76, 76, 76, 1.0);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("Enter verification code", textAlign: TextAlign.start, style: TextStyle(
            color: defaultTextColor,
            fontSize: 36.0,
            fontWeight: FontWeight.w700,
          )),

          const SizedBox(height: 20.0),

          Text("We just send you a 4-digit code at (+1) ${widget.phoneNumber}", style: const TextStyle(
              color: defaultTextColor,
              fontSize: 36.0
          )),

          const SizedBox(height: 50.0),

          TextFormField(
            validator: (value) => value!.isEmpty ? "Required" : null,
            style: const TextStyle(fontSize: 18.0, color: defaultTextColor),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d\d{0,3}'))
            ],
            decoration: const InputDecoration(
                hintText: "Enter verification code",
                hintStyle: TextStyle(color: Colors.grey)
            ),
            onChanged: (value) {
              widget.info.enteredCode = value;
            },
          ),

          const SizedBox(height: 40.0),

          TextButton(
            child: const Text("Send a new code", style: TextStyle(fontSize: 18.0, color: Colors.blue),),
            onPressed: () async{
              await sendNewCode();
              Util.showToast("Sent new code");
            },
          )
        ]
    );
  }
}
