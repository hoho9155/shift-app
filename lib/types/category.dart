/// Category Data Type Definition
class Category {
  const Category({required this.id, required this.name, required this.icon});
  final int id;
  final String name;
  final String icon;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }
}
