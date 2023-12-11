import 'dart:async';

import '../../model/pastry.dart';

class DefaultCartRepository {
  List<Pastry> _pastryInCart = [];

  final _controller = StreamController<List<Pastry>>();

  Stream<List<Pastry>> get cart async* {
    yield _pastryInCart;
    yield* _controller.stream;
  }

  set pastryInCart(List<Pastry> pastries) {
    _pastryInCart = pastries;
  }

  void add(Pastry pastry) {
    _pastryInCart.add(pastry);
  }

  void remove(Pastry pastry) {
    _pastryInCart.remove(pastry);
  }
}
