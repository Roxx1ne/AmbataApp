import 'dart:async';

import 'package:ambataapp/data/repository/pastry/pastry_repository.dart';
import 'package:collection/collection.dart';

import '../../model/pastry.dart';

class DefaultPastryRepository extends PastryRepository {
  final _controller = StreamController<List<Pastry>>.broadcast();

  final List<Pastry> _pastries = [
    Pastry.flavourful(
      0,
      'Cheese Cake',
      25000,
      [Flavour('Strawberry'), Flavour('Chocolate')],
      'Description',
      '',
      PastryCategory.bread,
    ),
    Pastry.flavourful(
      1,
      'Macaron',
      22000,
      [Flavour('Pistachio'), Flavour('Lemon')],
      'Description',
      '',
      PastryCategory.cake,
    ),
    Pastry.flavourful(
      2,
      'Danish Pastry',
      19000,
      [Flavour('Blueberry'), Flavour('Apple Cinnamon')],
      'Description',
      '',
      PastryCategory.bread,
    ),
    Pastry.flavourful(
      3,
      'Cannoli',
      25000,
      [Flavour('Ricotta Orange'), Flavour('Pistachio Chocolate Chip')],
      'Description',
      '',
      PastryCategory.bread,
    ),
    Pastry.flavourful(
      4,
      'Tiramisu',
      23000,
      [Flavour('Classic Coffee'), Flavour('Raspberry Chocolate')],
      'Description',
      '',
      PastryCategory.cake,
    ),

  ];

  @override
  Stream<List<Pastry>> get pastries => _controller.stream;

  @override
  void getAllPastries() {
    Future.delayed(const Duration(milliseconds: 350))
        .then((_) => _controller.sink.add(_pastries));
  }

  @override
  Future<Pastry?> getPastryById(int id) async {
    Future.delayed(const Duration(milliseconds: 250));
    return _pastries.firstWhereOrNull((pastry) => pastry.id == id);
  }
}
