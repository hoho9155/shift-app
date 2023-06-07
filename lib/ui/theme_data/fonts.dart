import 'package:flutter/material.dart';

abstract class FontThemeData {
  static const Color grey700 = Color.fromRGBO(51, 65, 85, 1.0);
  static const Color teal = Color.fromRGBO(16, 185, 129, 1.0);

  // Common Components
  static const TextStyle partnerHeading = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(0, 0, 0, 1.0),
  );

  static const TextStyle inputLabel = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(100, 116, 139, 1.0),
  );

  static const TextStyle jobItemName = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    color: grey700,
  );

  static const TextStyle jobItemTypeAndLocation = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(80, 80, 80, 1.0),
  );

  static const TextStyle jobItemMomentsAgo = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
    color: grey700,
  );

  static const TextStyle jobItemUnreadNotifications = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle notificationMsgText = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: teal,
  );

  static const TextStyle notificationMsgTextBold = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    color: teal,
  );

  // Job Post
  static const TextStyle jobPostSecondHeading =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: grey700);

  static const TextStyle jobPostSecondHeadingBold =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: grey700);

  static const TextStyle jobPostThirdHeading =
      TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: grey700);

  static const TextStyle jobPostName =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: grey700);

  static const TextStyle jobPostDeadlineDate =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: grey700);

  static const TextStyle jobPostAttributesTitle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: grey700);

  static const TextStyle jobPostAttributesText =
      TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: grey700);

  static const TextStyle jobPostText =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: grey700);

  static const TextStyle jobPostSalaryRangeTitle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: grey700);

  static const TextStyle jobPostSalaryRangeText =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black);

  /// Login Page
  static const TextStyle authHeading =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black);

  static const TextStyle btnText =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white);

  static const TextStyle btnBlackText =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black);

  static const TextStyle authBtnFB =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white);

  static const TextStyle authBtnGoogle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black);

  /// Homepage
  static const TextStyle welcomeTitle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white);

  static const TextStyle welcomeOccupation =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white);

  static const TextStyle sectionTitles =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black);

  static const TextStyle sectionTitleSecondary =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black);

  /// Profile Page
  static const TextStyle profileName =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: grey700);

  static const TextStyle profilePagePrimaryTitle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: grey700);

  static const TextStyle profilePageSecondaryTitle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: grey700);

  static const TextStyle profileOccupation =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: grey700);

  static const TextStyle profilePageOccupation =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: grey700);

  static const TextStyle profilePageLocation = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: grey700,
      fontStyle: FontStyle.italic);

  static const TextStyle profilePageHintTxt = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      color: grey700);

  static const TextStyle profilePageTxt = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color.fromRGBO(149, 149, 149, 1.0));

  static const TextStyle resumeTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static TextStyle resumeDocType = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: Colors.black.withOpacity(0.6),
  );

  /// Settings Page
  static const TextStyle settingsListItem =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: grey700);

  static const TextStyle settingsListItemPrimary =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: grey700);

  static const TextStyle settingsListItemSecondary =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: grey700);

  static const TextStyle settingsFontSizeXl =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w100, color: grey700);

  static const TextStyle settingsFontSizeL =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w100, color: grey700);

  static const TextStyle settingsFontSizeM =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w100, color: grey700);

  static const TextStyle settingsFontSizeXlBold =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black);

  static const TextStyle settingsFontSizeLBold =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black);

  static const TextStyle settingsFontSizeMBold =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black);

  static const TextStyle settingsText =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black);
}
