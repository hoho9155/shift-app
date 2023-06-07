// Edit Post Data Type Definition
class EditPost {
  EditPost(
      {required this.partnerId,
      required this.id,
      required this.title,
      required this.isRemote,
      required this.city,
      required this.country,
      required this.category,
      required this.noPayRange,
      required this.minSalary,
      required this.maxSalary,
      required this.jobType,
      required this.desc,
      required this.isPublished,
      required this.status});
  late int partnerId;
  late int id;
  late String title;
  late bool isRemote;
  late String city;
  late String country;
  late int category;
  late bool noPayRange;
  late int minSalary;
  late int maxSalary;
  late int jobType;
  late String desc;
  late bool isPublished;
  late String status;
  factory EditPost.fromJson(Map<String, dynamic> json) {
    return EditPost(
      partnerId: json['partner']['id'],
      id: json['id'],
      title: json['title'],
      isRemote: (json['remote_position'] == 1) ? true : false,
      city: (json['remote_position'] == 0) ? json['city'] : '',
      country: (json['remote_position'] == 0) ? json['country'] : '',
      category: json['category']['id'],
      noPayRange: (json['no_pay_range'] == 1) ? true : false,
      minSalary:
          (json['min_salary_range'] != null) ? json['min_salary_range'] : 0,
      maxSalary:
          (json['max_salary_range'] != null) ? json['max_salary_range'] : 0,
      jobType: json['job_type']['id'],
      desc: json['desc'],
      isPublished: (json['published'] == 1) ? true : false,
      status: json['status'],
    );
  }
}
