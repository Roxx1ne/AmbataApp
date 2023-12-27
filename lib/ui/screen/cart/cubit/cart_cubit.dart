import 'dart:async';
import 'dart:collection';

import 'package:ambataapp/data/repository/cart/cart_repository.dart';
import 'package:bloc/bloc.dart';

import '../../../../data/model/pastry.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartUiState> {
  CartCubit(
    this._cartRepository,
  ) : super(Loading()) {
    _subscribe();
    _cartRepository.getAllPastriesInCart();
  }

  final CartRepository _cartRepository;

  late final StreamSubscription _subscription;

  void _subscribe() {
    _subscription = _cartRepository.cart.listen(
      (pastries) {
        emit(Success(pastries));
      },
      onError: (error) => emit(Error(message: '$error')),
    );
  }

  @override
  Future<void> close() async {
    _subscription.cancel();
    super.close();
  }
}
