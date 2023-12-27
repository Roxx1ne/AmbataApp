part of 'cart_cubit.dart';

sealed class CartUiState {}

final class Loading extends CartUiState {}

final class Success extends CartUiState {
  final LinkedHashMap<Pastry, int> data;

  Success(this.data);
}

final class Error extends CartUiState {
  final String message;

  Error({required String message})
      : message = (message.isEmpty ? 'Unexpected error occured :(' : message);
}
