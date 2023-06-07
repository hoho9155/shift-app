// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class JobStatus {
  static const int ACTIVE = 2;
  static const int INPROGRESS = 1;
  static const int FINISHED = 0;
  static const LABELS = ["Inprogress", "Finished","Active"];

  static const int NEW = 0;
  static const int BOOKED = 1;
  static const int RESERVED = 2;
  static const USERLABELS = ["New", "Booked", "Reserved"];
}

class AppConstants {
  static const String API_URL = "http://5.183.11.250:8000/api";
  static const String STATIC_WEB_URL = "https://codajobs.beamcoda.com";
  static const String CURRENCY_PREFIX = "\$";

  //Partner
  static const String PARTNER_LOGIN = "/login/partner";
  static const String PARTNER_REGISTER = "/signup/partner";
  static const String PARTNER_SHIFTLIST = "/shifts/list";
  static const String PARTNER_SHIFTPOST = "/shifts/post";
  static const String PARTNER_SHIFTEDIT = "/shifts/edit";
  static const String PARTNER_SHIFTDELETE = "/shifts/delete";
  static const String PARTNER_SHIFTAPPLICANTS = "/shifts/applicants";
  static const String PARTNER_PROMOTEWORKER = "/shifts/promote";
  static const String PARTNER_DEMOTEWORKER = "/shifts/demote";
  static const String PARTNER_COMPANYUPDATE = "/profile/company";

  //Worker
  static const String WORKER_LOGIN = "/login/worker";
  static const String WORKER_REGISTER = "/signup/worker";
  static const String WORKER_SHIFTLIST = "/shifts/listWorker";
  static const String WORKER_SHIFTAPPLY = "/shifts/apply";
  static const String WORKER_SHIFTCANCEL = "/shifts/cancel";

  //Common
  static const String LOGOUT = "/logout";
  static const String SHIFTDETAIL = "/shifts/detail";
  static const String MESSAGE_CONTACTLIST = "/messages/contact";
  static const String MESSAGE_LIST = "/messages/list";
  static const String MESSAGE_INSERT = "/messages/insert";
  static const String PERSONALUPDATE = "/profile/personal";
  static const String MSG_NETERROR = "Network or server error!";
}

class Util {
  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        backgroundColor: const Color.fromRGBO(76, 76, 76, 1),
        webPosition: "center",
        webBgColor: "#4a4a4a",
        fontSize: 16.0
    );
  }
}