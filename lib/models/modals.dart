import 'package:cloud_firestore/cloud_firestore.dart';

class PizzaDetails {
  String title;
  String description;
  String image;

  List<dynamic> modifiers = <Modifier>[];

  PizzaDetails({this.title, this.description, this.image, this.modifiers});

  factory PizzaDetails.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return PizzaDetails(
      title: data['title'] ?? 'title',
      description: data['description'] ?? 'description',
      image: data['image'] ?? 'HU image',
      modifiers:
          data['modifier'].map((element) => Modifier.fromMap(element)).toList(),
    );
  }
}

class Modifier {
  String name;
  bool required;
  bool oneMany;

  List<dynamic> options = <Option>[];

  Modifier({this.required, this.oneMany, this.name, this.options});

  factory Modifier.fromMap(Map data) {
    return Modifier(
      name: data['name'] ?? 'No Name',
      required: data['required'] ?? 'No Name',
      oneMany: data['oneMany'] ?? 'No Name',
      options:
          data['opinion'].map((element) => Option.fromMap(element)).toList(),
    );
  }
}

class Option {
  String name;
  String price;

  Option({
    this.name,
    this.price,
  });

  factory Option.fromMap(Map data) {
    return Option(
      name: data['name'] ?? 'No Name',
      price: data['price'] ?? 'No Name',
    );
  }
}
