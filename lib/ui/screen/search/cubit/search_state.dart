part of 'search_cubit.dart';

sealed class SearchUiState {}

final class Loading extends SearchUiState {}

final class Success extends SearchUiState {
  final bool isSearched;
  final Set<PastryCategory> selectedCategories;
  final List<Pastry> data;

  Success(
    this.isSearched,
    this.selectedCategories,
    this.data,
  );
}

final class Error extends SearchUiState {
  final String message;

  Error({required String message})
      : message = (message.isEmpty ? 'Unexpected error occured :(' : message);
}
