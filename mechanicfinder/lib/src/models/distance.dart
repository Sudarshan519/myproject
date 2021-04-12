class DistanceModel {
  double id;
  String name;
  String address;
  int mechanicindex;
  double latitude;
  double longitude;
  String shopid;

  DistanceModel({this.id, this.name});

  DistanceModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.mechanicindex = json['mechanicindex'];
    this.latitude = json['latitude'];
    this.longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
