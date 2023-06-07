// New Post Data Type Definition
class JobNew {
  JobNew({
    required this.id,
    required this.title,
    required this.type,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.workers,
    required this.payRate,
    required this.hours,
    required this.fixedPay,
    required this.desc,
    required this.isVerified
  });

  int id;
  String title;
  String type;
  String location;
  String startDate;
  String endDate;
  int workers;
  int hours;
  double payRate;
  int fixedPay;
  String desc;
  bool isVerified;
}
