// Invoice List Data Type
class Invoice {
  const Invoice(
      {required this.id,
      required this.packageName,
      required this.amount,
      required this.paymentMethod,
      required this.isPaid});
  final int id;
  final String packageName;
  final String amount;
  final String paymentMethod;
  final bool isPaid;
  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      packageName: json['package'],
      amount: json['amount'].toString(),
      paymentMethod:
          (json['payment_method'] == null) ? '' : json['payment_method'],
      isPaid: (json['paid'] == 1) ? true : false,
    );
  }
}
