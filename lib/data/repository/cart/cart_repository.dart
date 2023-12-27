import 'dart:async';
import 'dart:collection';

import '../../model/pastry.dart';

abstract class CartRepository {
  Stream<LinkedHashMap<Pastry, int>> get cart;

  void getAllPastriesInCart();

  Future<void> add(Pastry pastry, int quantity);

  Future<void> updateQuantity(Pastry pastry, int quantity);

  Future<void> removeAll();

  Future<Pastry?> getPastryById(int id);
}
