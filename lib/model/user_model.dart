class User{
  final int id;
  final String name;
  final String email;
  final String phone;
  final String website;
  final String companyName;
  final String address;
  User({required this.id,
   required this.name,
   required this.email,
  required this.phone,
  required this.website,
  required this.companyName,
  required this.address});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'].toString(),
      website: json['website'],
      companyName: json['company']['name'],
      address:
      "${json['address']['street']}, ${json['address']['suite']}, ${json['address']['city']}, ${json['address']['zipcode']}",
    );
  }
  
}