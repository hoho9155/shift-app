/// Post Duration Data Type Definition
class PostDuration {
  const PostDuration({
    required this.id,
    required this.name,
    required this.duration,
    required this.isPremium,
  });
  final int id;
  final String name;
  final int duration;
  final bool isPremium;

  factory PostDuration.fromJson(Map<String, dynamic> json) {
    return PostDuration(
      id: json['id'],
      name: json['name'],
      duration: json['duration'],
      isPremium: (json['premium'] == 1) ? true : false,
    );
  }
}
