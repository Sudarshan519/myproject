import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanicfinder/src/controller/user_controller.dart';

import 'complete_profile.dart';

class Profile extends StatelessWidget {
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.center,
                height: 300,
                color: Colors.red,
                child: Stack(children: [
                  Container(
                    height: 150,
                    color: Colors.white,
                  ),
                  Center(
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
                        )),
                  ),
                  Positioned(
                      right: 30,
                      top: 40,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back),
                      )),
                  Positioned(
                      right: 30,
                      top: 40,
                      child: InkWell(
                        onTap: () {
                          Get.to(CompleteprofileView(isUpdate: true));
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.edit),
                        ),
                      ))
                ])),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text('Name'),
                  SizedBox(height: 10),
                  Text(userController.user.value.name ?? ''),
                  Divider(),
                  SizedBox(height: 20),
                  Text('Email'),
                  SizedBox(height: 10),
                  Text(userController.user.value.email ?? ''),
                  Divider(),
                  SizedBox(height: 20),
                  Text('Address'),
                  SizedBox(height: 10),
                  Text(
                      '${userController.user.value.street},${userController.user.value.city}' ??
                          ''),
                  Divider(),
                  SizedBox(height: 20),
                  Text('Phone'),
                  SizedBox(height: 10),
                  Text('${userController.user.value.phone}' ?? ''),
                  SizedBox(height: 20),
                  Text('')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
