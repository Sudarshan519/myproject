class Request {
  final String userid;
  final String service;
  final String datetime;
  final String latitude;
  final String longitude;
  final String mechanicid;
  final String status;

  Request(this.userid, this.service, this.datetime, this.latitude,
      this.longitude, this.status, this.mechanicid);
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
        'mechanicid':mechanicid
      };
}

// final List<Request> request = [
//   Request('asdfe', 'repair', '1212', '2.22', '3232.33', 'sent',''),
//   Request('sdfese', 'ambulance', '1212', '2.22', '3232.33', 'reviewed',''),
//   Request('slkef', 'police', '1212', '2.22', '3232.33', 'on move',''),
//   Request('slkawefef', 'car oil', '1212', '2.22', '3232.33', 'repairing',''),
//   Request('sef', 'car wash', '1212', '2.22', '3232.33', 'repaired',''),
//   Request('sef', 'puncture', '1212', '2.22', '3232.33', 'true',''),
// ];
