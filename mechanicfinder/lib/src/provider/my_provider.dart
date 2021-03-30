import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mechanicfinder/src/models/mechanic.dart';

class MyProvider extends ChangeNotifier {
  // List<CategoriesModel> categoriesList = [];
  // CategoriesModel categoriesModel;
  // Future<void> getCategories() async {
  //   List<CategoriesModel> newCategoriesList = [];
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('categories')
  //       .doc('id')
  //       .collection('twoWheeler')
  //       .get();
  //   querySnapshot.docs.forEach((element) {
  //     categoriesModel = CategoriesModel(
  //         image: element.data()['image'], name: element.data()['name']);
  //     print(categoriesModel);
  //     newCategoriesList.add(categoriesModel);
  //     categoriesList = newCategoriesList;
  //   });
  // }

  // get throwList {
  //   return categoriesList;
  // }

  /// Mechanic List///
  List<MechanicModel> mechanicsList = [];
  MechanicModel mechanicModel;
  Future<void> getMechnicsList() async {
    List<MechanicModel> newmechanicModelList;
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('mechaniclist').get();

    querySnapshot.docs.forEach((element) {
      if (element.exists) {
        // mechanicModel = MechanicModel(
        //     mechanicName: element.data()['mechanicName'],
        //     latitude: element.data()['latitude'],
        //     longitude: element.data()['longitude']);
        newmechanicModelList.add(mechanicModel);
      }
    });
    print(newmechanicModelList.toString());
    mechanicsList = newmechanicModelList;
  }

  get throwMechanicList {
    if (mechanicsList.length != 0)
      return mechanicsList;
    else
      return [];
  }
}
