import 'package:get_storage/get_storage.dart';

class LocalGetStorage {
  final box = GetStorage();
//for onboarding
  onboard() {
    bool onboard = box.read('onboard') ?? true;
    if (onboard) {
      print(onboard);
      box.write('onboard', false);
    }
    return onboard;
  }

//for cart items
  read(String cart) async {
    var prod = box.read(cart);
    return prod;
  }

  write(String cart, var a) async {
    await box.write('cart', a);
  }

  // listen(String cart) {
  //   box.listen(() {
  //     print('box changed');
  //   });
  //   // box.removeListen(listen);
  // }

//for storing user
  writeuser(String user) {
    box.write('user', user);
  }

  readuser() {
    var prod = box.read('user');
    return prod;
  }

  clearuser() {
    box.remove('user');
  }
  // getuser(){
  //   var prod = box.read('user');

  //   return prod;
  // }

  clear() {
    box.remove('cart');
    //box.remove('user');
  }

  // delete() {
  //   box.erase();
  // }
}

LocalGetStorage allStorage = LocalGetStorage();
