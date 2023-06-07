/// Partner Data Type Definition
class Partner {
  Partner(
  {
    this.id,
    this.email,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.birthyear,
    this.companyName,
    this.EIN,
    this.companyLocation,
    this.rating,
    this.address,
    this.password
  });
  int? id;
  String? email;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  int? birthyear;
  String? rating;
  String? companyName;
  String? EIN;
  String? companyLocation;
  String? address;
  String? password;

  // factory Partner.fromJson(Map<String, dynamic> json) {
  //   return Partner(
  //     id: json['id'],
  //     name: json['name'],
  //     displayName: json['display_name'],
  //     email: json['email'],
  //     img: json['profile_picture'],
  //     bio: json['bio'],
  //     packageId: json['package'][0]['id'],
  //     memberSince: json['member_since'],
  //     empCount: json['company_size'],
  //   );
  // }
}
