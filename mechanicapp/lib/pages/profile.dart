import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../pages/widgets/constant/default_value.dart';
import '../pages/widgets/constant/inputfield.dart';
import '../pages/widgets/textbutton.dart';
class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:Column(
              children: [
                AccountHeader(),
                GestureDetector(
                  onTap: () {
                  //  Get.to(() => AddAddressView(), arguments: true);
                  },
                  child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color:Colors.yellowAccent)),
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          SizedBox(width:12),
                          Text('Add Address')
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {
                    //Get.to(() => AddAddressView(), arguments: false);
                  },
                  child: Container(
                      height: 120,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Selected Address',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    fontSize:22),
                                textAlign: TextAlign.left,
                              ),
                              Icon(
                                Icons.arrow_right_alt,
                                size: 30,
                                color: Colors.red,
                              )
                            ],
                          ),
                          Text('',
                            //controller.fetchingSingleAddress(),
                            style:
                                TextStyle(),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      )),
                ),
                Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)),
                    child: Row(
                      children: [
                        Icon(Icons.shopping_bag),
                        SizedBox(width:10),
                        Text(
                          'Current Order',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Text('Order1...');
                      }),
                ),
                CustomeTextButton(
                  label: 'Log Out',
                  onPressed: () {
        //  controller.logOut();
                  },
                  color: Theme.of(context).backgroundColor,
                )
              ],
            ));
  }
}

class AccountHeader extends StatelessWidget {
  const AccountHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
       Container(
          padding: EdgeInsets.only(top: 12),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .30,
          color: Theme.of(context).backgroundColor,
          child:Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Stack(
                      children: [
                        CircleAvatar(
                            foregroundColor: Theme.of(context).primaryColor,
                            backgroundColor: Colors.white,
                            radius: 60,
                            child:Text(''),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                              onPressed: () {
                              
                              },
                              icon: Icon(FontAwesomeIcons.camera)),
                        )
                      ],
                    ),
                    SizedBox(height:12),
                    Text(
                     '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                        //  fontSize: Defaults.defaultPadding / 1.8,
                          color: Theme.of(context).primaryColor),
                    ),
                   // SizedBox(height: Defaults.defaultfontsize / 3),
                    Text(
                    '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          //fontSize: Defaults.defaultPadding - 4,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(),
                    Text(
                      '',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                         
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ))),
      Positioned(
        top: 2,
        right: 2,
        child: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(child: dialogInfo(context));
                  });
            },
            icon: Icon(
              FontAwesomeIcons.pencilAlt,
              color: Colors.white,
            )),
      )
    ]);
  }
}



dialogInfo(BuildContext context) {
  return Container(
    
    color: Theme.of(context).backgroundColor,
   
    child: Column(
      children: [
        Text(
          'User Information',
          style: TextStyle(
               color: Colors.white),
        ),
        SizedBox(width: Defaults.defaultfontsize * 2),
        InputField(
         // controller: userinfo.userInputName,
          context: context,
          hintText: 'Dispaly Name',
          label: 'Display Name',
        ),
        InputField(
          //  controller: userinfo.userInputPhone,
            context: context,
            hintText: 'Phone No',
            label: 'Phone No',
            textFieldColor: Colors.black),
        SizedBox(width: Defaults.defaultfontsize),
        Row(children: [
          Expanded(
              child: CustomeTextButton(
            label: 'Cancel',
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Theme.of(context).backgroundColor,
          )),
          SizedBox(width: Defaults.defaultfontsize / 2),
          Expanded(
              child: CustomeTextButton(
            label: 'Saved',
            onPressed: () {
            //  userinfo.updateUserInfo();
              Navigator.of(context).pop();
            },
            color: Theme.of(context).backgroundColor,
          ))
        ])
      ],
    ),
  );
}