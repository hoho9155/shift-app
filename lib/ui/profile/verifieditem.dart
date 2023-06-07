import 'package:beamcoda_jobs_partners_flutter/types/msgcompact.dart';
import 'package:beamcoda_jobs_partners_flutter/types/verifiedpartner.dart';
import 'package:flutter/material.dart';

class VerifiedItem extends StatelessWidget {
  const VerifiedItem({required Key key, required this.partnerInfo}) : super(key: key);
  final VerifiedPartner partnerInfo;

  @override
  Widget build(BuildContext context) {
    const Color defaultTextColor = Color.fromRGBO(76, 76, 76, 1.0);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0))
      ),
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("assets/images/sample_photo.png"),
                fit: BoxFit.cover
              )
            ),
          ),

          const SizedBox(width: 10.0),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(partnerInfo.name, style: const TextStyle(color: defaultTextColor, fontSize: 18.0, fontWeight: FontWeight.w700)),
                const SizedBox(height: 5.0),
                Text(partnerInfo.companyName, style: const TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.w400))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
