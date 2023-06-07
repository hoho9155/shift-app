class NotificationSettings {
  const NotificationSettings(
      {required this.newApplicants, required this.jobExpiry});
  final bool newApplicants;
  final bool jobExpiry;
  factory NotificationSettings.fromJson(Map<String, dynamic> json) {
    return NotificationSettings(
      newApplicants: (json['new_applicants'] == 0) ? false : true,
      jobExpiry: (json['job_expiry'] == 0) ? false : true,
    );
  }
}
