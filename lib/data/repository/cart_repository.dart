
import 'package:flutter/cupertino.dart';
import '../../model/pastry.dart';

class DefaultCartRepository extends ChangeNotifier {

  late List<Pastry> _pastryInCart = [];

  set pastryInCart(List<Pastry> pastries) {
    _pastryInCart = pastries;

    notifyListeners();
  }

  void add(Pastry pastry) {
    _pastryInCart.add(pastry);

    notifyListeners();
  }

  void remove(Pastry pastry) {
    _pastryInCart.remove(pastry);

    notifyListeners();
  }

}