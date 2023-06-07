class JobDetail {
  JobDetail(
    { this.id,
      this.title,
      this.type,
      this.location,
      this.company,
      this.duration,
      this.workers,
      this.desc,
      this.payRate,
      this.hours,
      this.fixedPay,
      this.rating,
      this.status,
      this.isVerified
    });

  int? id;
  String? title;
  String? type;
  String? location;
  String? company;
  String? duration;
  int? workers;
  double? payRate;
  int? hours;
  int? fixedPay;
  String? rating;
  String? desc;
  int? status;
  bool? isVerified;

  void clear() {
    hours = 0;
    fixedPay = 0;
    status = 0;
    desc = '';
    fixedPay = 0;
    payRate = 0;
    title = '';
    type = '';
    workers = 0;
    duration = '';
    location = '';
    company = '';
    rating = '';
    isVerified = false;
  }

  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    location = json['location'];
    company = json['company'];
    duration = json['duration'];
    workers = json['workers'];
    payRate = double.parse(json['payRate'].toString());
    hours = json['hours'];
    fixedPay = json['fixedPay'];
    rating = json['rating'];
    desc = json['desc'];
    status = json['status'];
  }
}
