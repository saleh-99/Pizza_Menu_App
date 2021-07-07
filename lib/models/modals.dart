import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PizzaDetails {
  final title;
  final description;
  final image;

  List<Modifier> modifiers;

  PizzaDetails({this.title, this.description, this.image, this.modifiers});

  factory PizzaDetails.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return PizzaDetails(
      title: data['title'] ?? 'title',
      description: ['description'] ?? 'description',
      image: data['image'] ?? 'HU image',
      modifiers: data['modifier'].forEach((element) {
        return Modifier.fromMap(element);
      }),
    );
  }
}

class Modifier {
  final name;
  final required;
  final oneMany;

  List<Option> options;

  Modifier({this.required, this.oneMany, this.name, this.options});

  factory Modifier.fromMap(Map data) {
    return Modifier(
      name: data['Name'] ?? 'No Name',
      required: data['required'] ?? 'No Name',
      oneMany: data['oneMany'] ?? 'No Name',
      options: data['option'].forEach((element) {
        return Option.fromMap(element);
      }),
    );
  }
}

class Option {
  final name;
  final price;

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
