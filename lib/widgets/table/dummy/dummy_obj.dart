import 'package:flutter/foundation.dart';

import 'package:pictures_view/widgets/table/dummy/dummy_builders.dart';
import 'package:pictures_view/widgets/table/model/table_row_element.dart';

class Parrot {
  final int id;
  final String name;
  final int age;
  final DateTime dateOfBirth;

  Parrot({
    @required this.id,
    @required this.name,
    @required this.age,
    @required this.dateOfBirth,
  });

  factory Parrot.generalByIndex(int index) {
    return Parrot(
      id: index,
      name: 'Joly',
      age: 10,
      dateOfBirth: DateTime.now(),
    );
  }

  factory Parrot.copy(Parrot parrot) {
    return Parrot(
      id: parrot.id,
      name: parrot.name,
      age: parrot.age,
      dateOfBirth: parrot.dateOfBirth,
    );
  }
}

class ParrotCell extends IndexedCell<Parrot> {
  ParrotCell(Parrot element) : super(element);

  @override
  void createListOfElements() {
    row.add(DateBuilder(element.dateOfBirth, 200.0));
    row.add(GeneralTextBuilder(element.name, 150.0));
    row.add(TextBuilder(element.age, 70.0));
    row.add(IntBuilder(element.age, 150.0));
  }

  @override
  String get getId => element.id.toString();
}
