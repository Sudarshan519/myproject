class Mechanic{
  String id;
  String name;
  String address;
  String phone;
  String email;
  String mylatitude;
  String mylongitude;
}

class MechanicModel {

  int id;
  String name;

  MechanicModel({ this.id, this.name });

  MechanicModel.fromJson(Map<String, dynamic> json){
      this.id = json['id'];
      this.name = json['name'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}