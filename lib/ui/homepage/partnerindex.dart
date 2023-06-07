import 'package:beamcoda_jobs_partners_flutter/data/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/job.dart';
import '../../utils/constants.dart';
import '../job/item/index.dart';
import '../job/new/index.dart';

class PartnerHomePage extends StatefulWidget {
  const PartnerHomePage({super.key});

  @override
  State<PartnerHomePage> createState() => _PartnerHomePage();
}

class _PartnerHomePage extends State<PartnerHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final jobProvider = Provider.of<JobProvider>(context, listen: false);
      String result = await jobProvider.loadJobs(context);

      if (result != '') {
        Util.showToast(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = Provider.of<JobProvider>(context);
    const Color defaultTextColor = Color.fromRGBO(76, 76, 76, 1.0);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 20.0, right: 10.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const NewJobPost();
                    })
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  textStyle: const TextStyle(fontSize: 18.0),
                  padding: const EdgeInsets.all(2),
                  elevation: 0,
                ),
                icon: const Icon(Icons.post_add),
                label: const Text("Post a new shift")
              ),

              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      onPressed: (){

                      },
                      icon: const Icon(Icons.help_outline, color: Colors.blue),
                  )
                )
              )
            ],
          ),

          const SizedBox(height: 10.0),

          const Text("Posted shifts", textAlign: TextAlign.start, style: TextStyle(
            color: defaultTextColor,
            fontSize: 36.0,
            fontWeight: FontWeight.w700,
          )),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: jobProvider.jobs.length,
                itemBuilder: (_, i) {
                  return JobPost(
                    key: UniqueKey(),
                    jobPost: jobProvider.jobs[i],
                    isWorker: false
                  );
                },
              )
            )
          ),
        ]
      )
    );
  }
}
