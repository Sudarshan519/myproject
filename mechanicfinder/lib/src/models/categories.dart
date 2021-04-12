class CategoriesModel {
  final String image;
  final String name;

  CategoriesModel({
    this.image,
    this.name,
  });
}

final List categories = List.unmodifiable([
  {'image': 'assets/service/mirror.gif', 'title': 'Mirror'},
  {'image': 'assets/service/oilservice.jpg', 'title': 'CarOil'},
  {'image': 'assets/service/gasservice.jpg', 'title': 'Fuel'},
  {'image': 'assets/service/brakeservice.jpg', 'title': 'Brake'},
  {'image': 'assets/service/engine.gif', 'title': 'Engine'},
]);
