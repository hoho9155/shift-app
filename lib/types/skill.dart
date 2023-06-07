/// Skill Data Type Definition
class Skill {
  const Skill({required this.id, required this.name, required this.isHinted});
  final int id;
  final String name;
  final bool isHinted;

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      name: json['name'],
      isHinted: (json['is_hinted'] == 1) ? true : false,
    );
  }
}
