import 'dart:async';
import 'dart:collection';

import '../../model/pastry.dart';
import 'cart_repository.dart';

class DefaultCartRepository extends CartRepository {
  final _controller = StreamController<LinkedHashMap<Pastry, int>>.broadcast();

  final LinkedHashMap<Pastry, int> _pastryInCart = LinkedHashMap.of({});

  @override
  void getAllPastriesInCart() {
    _controller.sink.add(_pastryInCart);
  }

  @override
  Stream<LinkedHashMap<Pastry, int>> get cart => _controller.stream;

  @override
  Future<void> add(Pastry pastry, int quantity) async {
    _pastryInCart.putIfAbsent(pastry, () => quantity);
    Future.delayed(const Duration(milliseconds: 350))
        .then((_) => _controller.sink.add(_pastryInCart));
  }

  @override
  Future<void> updateQuantity(Pastry pastry, int quantity) async {
    if (quantity >= 1) {
      _pastryInCart.update(pastry, (value) => quantity);
    } else {
      _pastryInCart.remove(pastry);
    }

    Future.delayed(const Duration(milliseconds: 50))
        .then((_) => _controller.sink.add(_pastryInCart));
  }


  @override
  Future<void> removeAll() async {
    for(var pastry in _pastryInCart.keys) {
      _pastryInCart.remove(pastry);
    }

    Future.delayed(const Duration(milliseconds: 450))
        .then((_) => _controller.sink.add(_pastryInCart));
  }

  @override
  Future<Pastry?> getPastryById(int id) async {
    Future.delayed(const Duration(milliseconds: 250));

    try {
      return _pastryInCart.keys.firstWhere((pastry) => pastry.id == id);
    } catch (e) {
      return null;
    }
  }

}
