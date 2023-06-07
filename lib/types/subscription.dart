// Subscription List Data Type
class Subscription {
  const Subscription(
      {required this.id,
      required this.name,
      required this.price,
      required this.subscriptionType,
      required this.features,
      required this.active});
  final int id;
  final String name;
  final String price;
  final String subscriptionType;
  final List<dynamic> features;
  final bool active;
  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      name: json['name'],
      price: json['price'].toString(),
      subscriptionType: json['subscription_type'],
      features: json['features'].map((item) => item['name']).toList(),
      active: (json['active'] == 1) ? true : false,
    );
  }
}
