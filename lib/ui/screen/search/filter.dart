import 'package:ambataapp/data/model/pastry.dart';

class SearchFilter {

  List<Pastry> filterByCategories(
    List<Pastry> pastries,
    Set<PastryCategory> selectedCategory,
  ) {
    return pastries
        .where((pastry) => selectedCategory
                .every((category) => category == PastryCategory.none)
            ? true
            : selectedCategory.contains(pastry.category))
        .toList();
  }

  List<Pastry> filterByName(
    List<Pastry> pastries,
    String name,
  ) {
    return pastries
        .where((pastry) =>
            name.isEmpty ? true : pastry.name.toLowerCase().contains(name))
        .toList();
  }
}
