class MechanicModel {
  final String mechanicid;
  final String mechanicName;
  final String imge;
  final String address;
  final String phone;
  final String city;
  final String service;
  final double latitude;
  final double longitude;
  final String status;
  double distance;

  MechanicModel(
      this.mechanicName,
      this.address,
      this.imge,
      this.city,
      this.mechanicid,
      this.phone,
      this.status,
      this.latitude,
      this.longitude,
      this.service,
      this.distance);
  factory MechanicModel.fromJson(Map<String, dynamic> json) {
    return MechanicModel(
      json['mechanicName'] as String,
      json['address'] as String,
      json['image'] as String,
      json['city'] as String,
      json['mechanicid'] as String,
      json['phone'] as String,
      json['status'] as String,
      json['latitude'] as double,
      json['longitude'] as double,
      json['service'] as String,
      json['distance'] ?? 0.0,
    );
  }
  Map<String, dynamic> toJson() => {
        'mechanicName': mechanicName,
        'address': address,
        'image': imge,
        'city': city,
        'mechanicid': mechanicid,
        'phone': phone,
        'status': status,
        'latitude': latitude,
        'longitude': longitude,
        'service': service,
      };

      updatedistance(double distance){

      }
}
