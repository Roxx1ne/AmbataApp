import 'package:collection/collection.dart';

import '../model/pastry.dart';

class DefaultPastryRepository {
  final List<Pastry> _pastries = [
    Pastry.flavourful(
      0,
      'Cheese Cake',
      25000,
      [Flavour('Strawberry'), Flavour('Chocolate')],
      PastryCategory.bread,
    ),
    Pastry.flavourful(
      1,
      'Macaron',
      22000,
      [Flavour('Pistachio'), Flavour('Lemon')],
      PastryCategory.bread,
    ),
    Pastry.flavourful(
      2,
      'Danish Pastry',
      19000,
      [Flavour('Blueberry'), Flavour('Apple Cinnamon')],
      PastryCategory.bread,
    ),
    Pastry.flavourful(
      3,
      'Cannoli',
      25000,
      [Flavour('Ricotta Orange'), Flavour('Pistachio Chocolate Chip')],
      PastryCategory.bread,
    ),
    Pastry.flavourful(
      4,
      'Tiramisu',
      23000,
      [Flavour('Classic Coffee'), Flavour('Raspberry Chocolate')],
      PastryCategory.bread,
    ),
    Pastry.flavourful(
      5,
      'Strudel',
      21000,
      [Flavour('Cherry'), Flavour('Apricot')],
      PastryCategory.bread,
    ),
    Pastry.flavourful(
      6,
      'Palmier',
      20000,
      [Flavour('Cinnamon Sugar'), Flavour('Nutella')],
      PastryCategory.bread,
    ),
    Pastry.flavourful(
      7,
      'Mille-Feuille',
      24000,
      [Flavour('Strawberry Cream'), Flavour('Hazelnut')],
      PastryCategory.bread,
    ),
    Pastry.flavourful(
      8,
      'Baklava',
      26000,
      [Flavour('Pistachio Honey'), Flavour('Walnut Cinnamon')],
      PastryCategory.bread,
    ),
    Pastry.flavourful(
      9,
      'Churro',
      18000,
      [Flavour('Caramel'), Flavour('Matcha')],
      PastryCategory.bread,
    ),
    Pastry.flavourful(
      10,
      'Profiterole',
      21000,
      [Flavour('Vanilla Cream'), Flavour('Salted Caramel')],
      PastryCategory.bread,
    ),
    Pastry.flavourful(
      11,
      'Pain au Chocolat',
      19000,
      [Flavour('Dark Chocolate'), Flavour('Orange Zest')],
      PastryCategory.bread,
    ),
    Pastry.flavourful(
      12,
      'Brioche',
      22000,
      [Flavour('Blueberry Lemon'), Flavour('Chocolate Hazelnut')],
      PastryCategory.cake,
    ),
    Pastry.flavourful(
      13,
      'Kouign-Amann',
      23000,
      [Flavour('Apple Caramel'), Flavour('Raspberry Pistachio')],
      PastryCategory.cake,
    ),
    Pastry.flavourful(
      14,
      'Puff Pastry Pinwheel',
      20000,
      [Flavour('Cinnamon Brown Sugar'), Flavour('Mixed Berry')],
      PastryCategory.cake,
    ),
    Pastry.flavourful(
      15,
      'Cinnamon Roll',
      21000,
      [Flavour('Classic Cinnamon'), Flavour('Cream Cheese Frosting')],
      PastryCategory.cake,
    ),
    Pastry.flavourful(
      16,
      'Sfogliatelle',
      24000,
      [Flavour('Ricotta Orange Zest'), Flavour('Chocolate Chip')],
      PastryCategory.cake,
    ),
    Pastry.flavourful(
      17,
      'Galette',
      25000,
      [Flavour('Peach Ginger'), Flavour('Mixed Berry')],
      PastryCategory.cake,
    ),
    Pastry.flavourful(
      18,
      'Cruffin',
      22000,
      [Flavour('Matcha White Chocolate'), Flavour('Strawberry Jam-filled')],
      PastryCategory.cake,
    )
  ];

  List<Pastry> getPastries() {
    return _pastries;
  }

  Pastry? getPastryById(int id) {
    return _pastries.firstWhereOrNull((pastry) => pastry.id == id);
  }
}
