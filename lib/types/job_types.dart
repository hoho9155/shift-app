/// Job types Type Definition
class JobType {
  const JobType({required this.id, required this.name});
  final int id;
  final String name;

  factory JobType.fromJson(Map<String, dynamic> json) {
    return JobType(
      id: json['id'],
      name: json['name'],
    );
  }
}
