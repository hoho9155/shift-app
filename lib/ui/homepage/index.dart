import 'package:beamcoda_jobs_partners_flutter/data/auth.dart';
import 'package:beamcoda_jobs_partners_flutter/ui/homepage/partnerindex.dart';
import 'package:beamcoda_jobs_partners_flutter/ui/homepage/userindex.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/job.dart';
import '../job/item/index.dart';
import '../job/new/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return authProvider.isWorker ? const UserHomePage() : const PartnerHomePage();
  }
}