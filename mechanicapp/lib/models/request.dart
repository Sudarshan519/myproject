class Request {
  final String userid;
  final String service;
  final String datetime;
  final String latitude;
  final String longitude;
  final String status;
  final String mechanicid;
  Request(
    this.userid,
    this.service,
    this.datetime,
    this.latitude,
    this.longitude,
    this.status,
    this.mechanicid,
  );
  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
        json['userid'] as String,
        json['service'] as String,
        json['datetime'] as String,
        json['latitude'] as String,
        json['longitude'] as String,
        json['status'] as String,
        json['mechanicid'] as String);
  }
  Map<String, dynamic> toJson() => {
        'userid': userid,
        'service': service,
        'datetime': datetime,
        'latitude': latitude,
        'longitude': longitude,
        'status': status,
        'mechanicid': mechanicid
      };
}
