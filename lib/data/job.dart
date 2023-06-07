import 'dart:convert';
import 'dart:core';
import 'package:beamcoda_jobs_partners_flutter/types/job_applicant.dart';
import 'package:beamcoda_jobs_partners_flutter/types/jobdetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../types/user.dart';
import './auth.dart';
import '../types/category.dart';
import '../types/job_types.dart';
import '../types/jobcompact.dart';
import '../types/jobnew.dart';
import '../types/post_duration.dart';
import '../types/skill.dart';
import '../utils/constants.dart';

class JobProvider extends ChangeNotifier {
  //For partner
  final List<JobCompact> _jobs = <JobCompact>[];
  //For User
  final List<JobCompact> _openJobs = <JobCompact>[];
  final List<JobCompact> _myJobs = <JobCompact>[];
  final List<JobApplicant> _bookedWorkers = <JobApplicant>[];
  final List<JobApplicant> _reservedWorkers = <JobApplicant>[];
  final JobDetail _curJob = JobDetail();

  List<JobCompact> get jobs => _jobs;
  List<JobCompact> get openJobs => _openJobs;
  List<JobCompact> get myJobs => _myJobs;
  List<JobApplicant> get bookedWorkers => _bookedWorkers;
  List<JobApplicant> get reservedWorkers => _reservedWorkers;
  JobDetail get curJob => _curJob;

  Future<String> loadJobs(BuildContext ctx) async {
    AuthProvider provider = Provider.of<AuthProvider>(ctx, listen: false);
    _jobs.clear();

    try {
      final Uri uri =
      Uri.parse('${AppConstants.API_URL}${AppConstants.PARTNER_SHIFTLIST}');
      final response = await http.post(uri, body: jsonEncode({
        'id': provider.partner!.id
      }), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${provider.token}'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        List<dynamic> list = data['list'];

        for (Map<String, dynamic> element in list) {
          _jobs.add(JobCompact.fromJson(element));
        }

        notifyListeners();
        return '';
      }
    } catch(_){}
    return AppConstants.MSG_NETERROR;
  }

  Future<String> loadUserJobs(BuildContext ctx) async {
    AuthProvider provider = Provider.of<AuthProvider>(ctx, listen: false);
    _openJobs.clear();
    _myJobs.clear();

    try {
      Uri uri = Uri.parse(
          '${AppConstants.API_URL}${AppConstants.WORKER_SHIFTLIST}');
      http.Response response = await http.post(uri, body: jsonEncode({
        'id': provider.user!.id,
        'isOpen': true
      }), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${provider.token}'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        List<dynamic> list = data['list'];

        for (Map<String, dynamic> element in list) {
          _openJobs.add(JobCompact.fromJson(element));
        }
      }
      else {
        return AppConstants.MSG_NETERROR;
      }

      uri = Uri.parse('${AppConstants.API_URL}${AppConstants.WORKER_SHIFTLIST}');
      response = await http.post(uri, body: jsonEncode({
        'id': provider.user!.id,
        'isOpen': false
      }), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${provider.token}'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        List<dynamic> list = data['list'];

        for (Map<String, dynamic> element in list) {
          _myJobs.add(JobCompact.fromJson(element));
        }
      }
      else {
        return AppConstants.MSG_NETERROR;
      }
    }catch(_) { return AppConstants.MSG_NETERROR;}

    notifyListeners();
    return '';
  }

  Future<String> getJobDetail(BuildContext ctx, int id) async {
    AuthProvider provider = Provider.of<AuthProvider>(ctx, listen: false);

    try {
      final Uri uri = Uri.parse(
          '${AppConstants.API_URL}${AppConstants.SHIFTDETAIL}');
      Map<String,dynamic> obj = {'id': id};
      if (provider.isWorker) {
        obj['workerId'] = provider.user?.id;
      }

      final response = await http.post(uri, body: jsonEncode(obj),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${provider.token}'
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        _curJob.fromJson(data['data']);
        notifyListeners();
        return '';
      }
    }catch(_){}
    return AppConstants.MSG_NETERROR;
  }

  Future<String> editJob(BuildContext ctx, JobNew job) async {
    AuthProvider provider = Provider.of<AuthProvider>(ctx, listen: false);

    try {
      final Uri uri = Uri.parse(
          '${AppConstants.API_URL}${AppConstants.PARTNER_SHIFTEDIT}');
      final response = await http.post(uri, body: jsonEncode({
        'id': job.id,
        'title': job.title,
        'type': job.type,
        'location': job.location,
        'startDate': job.startDate,
        'endDate': job.endDate,
        'workers': job.workers,
        'payRate': job.payRate,
        'hours': job.hours,
        'fixedPay': job.fixedPay,
        'desc': job.desc
      }), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${provider.token}'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        notifyListeners();
        return '';
      }
    }catch(_){}
    return AppConstants.MSG_NETERROR;
  }

  Future<String> deleteJob(BuildContext ctx, int id) async {
    AuthProvider provider = Provider.of<AuthProvider>(ctx, listen: false);

    try {
      final Uri uri = Uri.parse(
          '${AppConstants.API_URL}${AppConstants.PARTNER_SHIFTDELETE}');
      final response = await http.post(uri, body: jsonEncode({
        'id': id
      }), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${provider.token}'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        notifyListeners();
        return '';
      }
    }catch(_){}
    return AppConstants.MSG_NETERROR;
  }

  Future<String> getJobApplicants(BuildContext ctx, int id) async {
    AuthProvider provider = Provider.of<AuthProvider>(ctx, listen: false);

    try {
      final Uri uri = Uri.parse(
          '${AppConstants.API_URL}${AppConstants.PARTNER_SHIFTAPPLICANTS}');
      final response = await http.post(uri, body: jsonEncode({
        'id': id,
      }), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${provider.token}'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        List<dynamic> list = data['booked'];
        for (Map<String, dynamic> element in list) {
          _bookedWorkers.add(JobApplicant(id: element['id'],
              firstName: element['firstName'],
              lastName: element['lastName'],
              headline: element['headline']));
        }

        list = data['reserved'];
        for (Map<String, dynamic> element in list) {
          _reservedWorkers.add(JobApplicant(id: element['id'],
              firstName: element['firstName'],
              lastName: element['lastName'],
              headline: element['headline']));
        }

        notifyListeners();
        return '';
      }
    }catch(_){}
    return AppConstants.MSG_NETERROR;
  }

  Future<String> postJob(BuildContext ctx, JobNew job) async {
    AuthProvider provider = Provider.of<AuthProvider>(ctx, listen: false);

    try {
      final Uri uri = Uri.parse(
          '${AppConstants.API_URL}${AppConstants.PARTNER_SHIFTPOST}');
      final response = await http.post(uri, body: jsonEncode({
        'title': job.title,
        'type': job.type,
        'location': job.location,
        'startDate': job.startDate,
        'endDate': job.endDate,
        'workers': job.workers,
        'payRate': job.payRate,
        'hours': job.hours,
        'fixedPay': job.fixedPay,
        'desc': job.desc,
        'partnerId': provider.partner?.id
      }), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${provider.token}'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        return '';
      }
    }catch(_){}
    return AppConstants.MSG_NETERROR;
  }

  Future<String> applyjob(BuildContext ctx, int id) async {
    AuthProvider provider = Provider.of<AuthProvider>(ctx, listen: false);

    try {
      final Uri uri = Uri.parse(
          '${AppConstants.API_URL}${AppConstants.WORKER_SHIFTAPPLY}');
      final response = await http.post(uri, body: jsonEncode({
        'id': id,
        'workerId': provider.user?.id
      }), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${provider.token}'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        return '';
      }
    }catch(_){}
    return AppConstants.MSG_NETERROR;
  }

  Future<String> cancelJob(BuildContext ctx, int id) async {
    AuthProvider provider = Provider.of<AuthProvider>(ctx, listen: false);

    try {
      final Uri uri = Uri.parse(
          '${AppConstants.API_URL}${AppConstants.WORKER_SHIFTCANCEL}');
      final response = await http.post(uri, body: jsonEncode({
        'id': id,
        'workerId': provider.user?.id
      }), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${provider.token}'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        return '';
      }
    }catch(_){}
    return AppConstants.MSG_NETERROR;
  }

  Future<String> promoteWorker(BuildContext ctx, int id, int workerId) async {
    AuthProvider provider = Provider.of<AuthProvider>(ctx, listen: false);

    try {
      final Uri uri = Uri.parse(
          '${AppConstants.API_URL}${AppConstants.PARTNER_PROMOTEWORKER}');
      final response = await http.post(uri, body: jsonEncode({
        'id': id,
        'workerId': workerId
      }), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${provider.token}'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        notifyListeners();
        return '';
      }
    }catch(_){}
    return AppConstants.MSG_NETERROR;
  }

  Future<String> demoteWorker(BuildContext ctx, int id, int workerId) async {
    AuthProvider provider = Provider.of<AuthProvider>(ctx, listen: false);

    try {
      final Uri uri = Uri.parse(
          '${AppConstants.API_URL}${AppConstants.PARTNER_DEMOTEWORKER}');
      final response = await http.post(uri, body: jsonEncode({
        'id': id,
        'workerId': workerId
      }), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${provider.token}'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String result = data['result'];

        if (result != 'success') {
          return result;
        }

        notifyListeners();
        return '';
      }
    }catch(_){}
    return AppConstants.MSG_NETERROR;
  }
}
