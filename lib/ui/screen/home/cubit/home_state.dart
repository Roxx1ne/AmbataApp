part of 'home_cubit.dart';

sealed class HomeUiState {}

final class Loading extends HomeUiState {}

final class Success extends HomeUiState {
  final List<Pastry> data;

  Success(this.data);
}

final class Error extends HomeUiState {
  final String message;

  Error({required String message})
      : message = (message.isEmpty ? 'Unexpected error occured :(' : message);
}
