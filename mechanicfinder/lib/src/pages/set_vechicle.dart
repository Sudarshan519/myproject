import 'package:flutter/material.dart';
import 'package:mechanicfinder/src/widgets/text_field.dart';

class MyVechicle extends StatefulWidget {
  @override
  _MyVechicleState createState() => _MyVechicleState();
}

class _MyVechicleState extends State<MyVechicle> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController model = TextEditingController();
  TextEditingController company = TextEditingController();
  //TextEditingController category=TextEditingController();
  //TextEditingController type=TextEditingController();
  var type = ['light-duty', 'heavy-duty'];
  final category = [
    'M i.e vechicles carrying passengers',
    'N i.e vechicles carrying goods',
    'L i.e 2- and 3-wheel vechicles and quardicycles',
    'L quardicycles or 4 wheelers small i.e cars,vans,...'
        'T i.e agricultural and foresty tractors & ...',
  ];
  String defaultValue;
  void validation() {
    if (model.text.trim().isEmpty || model.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Email or username is Empty'),
      ));
      return;
    }
    if (company.text.trim().isEmpty || company.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('password is Empty'),
      ));
      return;
    }
  }

  Widget dropdown({String category, IconData icon}) {
    return DropdownMenuItem(
        child: ListTile(
     // leading: Icon(icon),
      title: Text(category),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  defaultValue = category[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          MyTextField(
            controller: model,
            hintText: 'Model no',
            obscureText: false,
          ),
          SizedBox(height: 30),
          MyTextField(
            controller: company,
            hintText: 'Password',
            obscureText: true,
          ),
          DropdownButton(
            items: [DropdownMenuItem(
        child: ListTile(
      leading: Icon(Icons.menu),
      title: Text('category'),
    ))],
            onChanged: (e) {
              setState(() {
                //defaultValue = e;
              });
            },
            //value: defaultValue,
          )
        ],
      ),
    );
  }
}
