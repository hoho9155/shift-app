import 'package:beamcoda_jobs_partners_flutter/data/message.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './data/auth.dart';
import './data/job.dart';
import './ui/authentication/demo.dart';
import './ui/layout.dart';
import 'firebase_options.dart';

String? fcmToken;

Future<void> main() async {
  // Register google_fonts license (DM Sans)
  // LicenseRegistry.addLicense(() async* {
  //   final license = await rootBundle.loadString('google_fonts/dmsans/OFL.txt');
  //   yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  // });
  // LicenseRegistry.addLicense(() async* {
  //   final license = await rootBundle.loadString('google_fonts/raleway/OFL.txt');
  //   yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  // });
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // fcmToken = await FirebaseMessaging.instance.getToken();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<JobProvider>(create: (context) => JobProvider()),
        ChangeNotifierProvider<MessageProvider>(create: (context) => MessageProvider()),
      ],
      child: MaterialApp(
        title: 'Shiftwork',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<AuthProvider>(builder: (context, auth, child) {
          return const DemoPage();
        }),
      ),
    );
  }
}
