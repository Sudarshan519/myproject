import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  void _show(BuildContext ctx) {
    showModalBottomSheet(
      
        elevation: 10,
        backgroundColor: Colors.white,
        context: ctx,
        builder: (ctx) => Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              width: 300,
              height: 250,
              color: Colors.white54,
              alignment: Alignment.center,
              child: Text('Breathe in... Breathe out...'),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: SafeArea(
                  child: Column(children: [
                    Card(
                     
                      child:ListTile(onTap: (){

                      },
                      title:  Text('Profile')),
                    ),
      Card(
          child: ListTile(
            onTap: () {_show(context);},
            leading: Icon(Icons.language),
            title: Text('Language'),
          ),
      )
    ]),
        ));
  }
}
