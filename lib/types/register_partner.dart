/// Register Partner Data Type Definition
class RegisterPartner {
  RegisterPartner({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
  });
  late int id;
  late String email;
  late String phoneNumber;
  late String firstName;
  late String lastName;
  late String password;
}
