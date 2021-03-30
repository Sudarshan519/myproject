class User {
  final String id;
  final String name;
  final String email;
  final String photo;
  final String address;
  final String phone;
  final String createdAt;
  User(this.id, this.name, this.email, this.photo, this.address, this.phone,
      this.createdAt);
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as String,
      json['email'] as String,
      json['photo'] as String,
      json['address'] as String,
      json['phone'] as String,
      json['email'] as String,
      json['createdAt'] as String,
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': id,
        'photo': photo,
        'address': address,
        'phone': phone,
        'createdAt': createdAt,
      };
}
