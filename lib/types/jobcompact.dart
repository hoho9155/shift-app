// Job Post List Data Type
class JobCompact {
  const JobCompact({
    required this.id,
    required this.title,
    required this.location,
    required this.duration,
    required this.workers,
    required this.payRate,
    required this.hours,
    required this.fixedPay,
    required this.postedTime,
    required this.bookNumer,
    required this.waitNumber,
    required this.isVerified,
    required this.status
  });

  final int id;
  final String title;
  final String location;
  final String duration;
  final int workers;
  final double payRate;
  final int fixedPay;
  final int hours;
  final String postedTime;
  final int status;
  final int bookNumer;
  final int waitNumber;
  final bool isVerified;

  factory JobCompact.fromJson(Map<String, dynamic> json) {
    return JobCompact(
        id: json['id'],
        title: json['title'],
        location: json['location'],
        fixedPay: json['fixedPay'],
        payRate: double.parse(json['payRate'].toString()),
        hours: json['hours'],
        workers: json['workers'],
        duration: json['duration'],
        status: json['status'],
        waitNumber: json['reserveNumber'],
        bookNumer: json['bookNumber'],
        postedTime: json['postedTime'],
        isVerified: true
    );
  }
}
